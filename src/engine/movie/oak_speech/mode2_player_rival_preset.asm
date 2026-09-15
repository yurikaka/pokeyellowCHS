DisplayMode2PlayerRivalPreset::
; Input: e = NAME_PLAYER_SCREEN (0) or NAME_RIVAL_SCREEN (1).
	ld a, e
	and a
	ld de, Mode2PlayerPresetList
	jr z, .draw
	ld de, Mode2RivalPresetList
.draw
	hlcoord 2, 2
	jp PlaceString

GetMode2PlayerRivalName::
; Input: e = NAME_PLAYER_SCREEN (0) or NAME_RIVAL_SCREEN (1).
; Output: de = wcd6d containing the matching English first preset name.
	ld a, e
	and a
	ld hl, Mode2PlayerPresetName ; YELLOW
	jr z, .copy
	ld l, LOW(Mode2RivalPresetName) ; BLUE
.copy
	ld de, wcd6d
	ld bc, NAME_BUFFER_LENGTH
	jp CopyData

Mode2PlayerPresetName:
	db "Y", "E", "L", "L", "O", "W", "@"
Mode2RivalPresetName:
	db "B", "L", "U", "E", "@"

ASSERT HIGH(Mode2PlayerPresetName) == HIGH(Mode2RivalPresetName)

; The text importer converts the normal list to Chinese at build time. These
; byte-coded rows preserve the first two Chinese presets and directly draw the
; English third preset in Mode 2.
Mode2PlayerPresetList:
	db $19, $30, $09, $da, $0a, $f0, $07, $43 ; 自己决定
	next $12, $0d, $09, $88 ; 小黄
	next $12, $0d, $18, $bd ; 小智
	next "Y", "E", "L", "L", "O", "W"
	db "@"

Mode2RivalPresetList:
	db $19, $30, $09, $da, $0a, $f0, $07, $43 ; 自己决定
	next $0e, $a0, $0c, $7a ; 青绿
	next $12, $0d, $0c, $bb ; 小茂
	next "B", "L", "U", "E"
	db "@"
