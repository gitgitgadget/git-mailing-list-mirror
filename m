Received: from mail-24424.protonmail.ch (mail-24424.protonmail.ch [109.224.244.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86BB26E6FA
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 19:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772567825; cv=none; b=XaOzaFrAxOE8VzvLrVprU0Q0OIMtRZ6OQ3gKdI24s1axvM+DtDxswBwHxSGxGIiAg45fMJdk/aIP3IDsIaNsKp4SCvpQmXUelDO2imPsZxoWqotbHu0i6tI/AEjBnj5e/OuMCSQ0kH9aLPCDiVhHlJbmc0Ff8TjsZXeuWTWFwVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772567825; c=relaxed/simple;
	bh=Gkn+VxLt+Ma1ntune3HjzuWbuSoXEwnqnHYnlsDZwZs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TMbqqNDIme2qRiUym1IM1WH9dCqbcKUWHt4BgS2RVQBFoOhwCIfipWmHYgbQiNDQYUar9ghI6apijd88U1eS/6fnlllPXQ57IT02sHtdlz3SmjSfPvUQtKdiXR2a9Y/xlpekkBubiKuRoDquPtHAK1g6ONb0TlI3AmOK3AkRQO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=oyajPeYZ; arc=none smtp.client-ip=109.224.244.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="oyajPeYZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1772567821; x=1772827021;
	bh=bikiHfUbI7L4KMdwaGTD7L9Tt/UW1MAT940W73PqSEQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=oyajPeYZYH3RGJlmx5pKT29RTPORyIWxAWeQIcZck7mHheOD2JHjx/CIrEynJSSAe
	 gLGO0Zjd255PnGQgu1GIwSyUgvMMJupA4kbjR+0xRHfG6MexDHONHOtnqMQXdcjQvj
	 ReAMpkC175T24odT+H15PjU/Alvp+gem5y8BLfoGxzUbrH3yUoXU7n/INyZSA+pCM9
	 nnv9dHHzDWolmfA/vagbYV8yD9nMUvw4BKc1AGxVxcHCS0s5lbURgAmEU4r6LwUMMJ
	 2aB/PmJxUxc1a1w0qnQbfmf+fsLt2zrqKkRlu7QOzr/Xp/zYAaICePYRqIwKGVOofi
	 PHPCnnrMjhGJA==
Date: Tue, 03 Mar 2026 19:56:58 +0000
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
From: Antoine Cousson <antoine.cousson@protonmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: git whatchanged --i-still-use-it
Message-ID: <kOjl5h30sXFnFJAzA1AbUTswK3k7xK-pSW6aos9GXIODTM9Qd5QK6AacNTZaDMV5OQRvAlymjdG2ME4d73YxGGDRzbVq6ZOPxhGn0G9gi2g=@protonmail.com>
In-Reply-To: <1c20a804-8146-49a7-a476-01a9219d9350@app.fastmail.com>
References: <bhYbjxeZY0QZt48g6XVTVfyPo6vbv9yeYLsw9PgFdVKgye6Ue0cAPy_RkNTwAOYEANhHyD6QbaxZrWaPS4__jlTcAVKOaEjrDgAxQYKdYvE=@protonmail.com> <xmqqpl5kdc3b.fsf@gitster.g> <1c20a804-8146-49a7-a476-01a9219d9350@app.fastmail.com>
Feedback-ID: 49647671:user:proton
X-Pm-Message-ID: f19f601ad0b1d5ebf4a3cfe085091ffb5a4a11f4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------93a1da1b0758e605036b6ea1dede4165b34344bbb7d70d7a43652b7a05564b28"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------93a1da1b0758e605036b6ea1dede4165b34344bbb7d70d7a43652b7a05564b28
Content-Type: multipart/mixed;boundary=---------------------a51318db5406f41c20f644a3a2ef4595

-----------------------a51318db5406f41c20f644a3a2ef4595
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

> Then perhaps you would like "git log --stat" even better?  Instead
of meaningless pair of hexadecimal object names, you'd get a sense
of the size of damage each commit causes to the codebase.

I have tested "git log --stat" and I really liked the display, thanks for =
the tips =


I agree that i was not looking at the hexadecimal but more to the names of=
 the file, the visual representation og the changes and the numbers are gr=
eat ! =




> Yes, on Git v2.51.1, Git 2.52 or higher.

I am on v2.43.0 I will update thanks
  =




Le mardi 3 mars 2026 =C3=A0 7:17 PM, Kristoffer Haugsbakk <kristofferhaugs=
bakk@fastmail.com> a =C3=A9crit=C2=A0:

> On Tue, Mar 3, 2026, at 19:03, Junio C Hamano wrote:
> >[snip]
> > The command is going away.  You could
> >
> >   $ git config alias.whatchanged "log --raw --no-merges"
> >
> > if you really prefer the ugly hexadecimal gibberish, though.
> =


> Yes, on Git v2.51.1, Git 2.52 or higher.
> =


-----------------------a51318db5406f41c20f644a3a2ef4595
Content-Type: application/pgp-keys; filename="publickey - antoine.cousson@protonmail.com - 0x675DB63B.asc"; name="publickey - antoine.cousson@protonmail.com - 0x675DB63B.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - antoine.cousson@protonmail.com - 0x675DB63B.asc"; name="publickey - antoine.cousson@protonmail.com - 0x675DB63B.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgp4c0ZOQkdLZkR5TUJFQURPb0Zi
L1BuSGFDZkFtNWRBM0FOb09GaVdzd0lVWHV2VVhlc1dxMlArYmlpYlAKQkFTNEdTYlM2MzJWOExu
S3Z0RkxJemVCMVVEOThqMnM3NEI1VXcrZ01TYzA2cEFGQk5pc1dtK2tSOGNBCldXbzl5MTVTc2ZD
RTFuVnJzeXBNalNKaW42NnN3UDU5dlVLUEJGUE9jTEdVL3VST3FPdGlkUDBTcDk2dQpDRXhlNnMz
NVNxbDVIT2F0QktVb1ZTVFp3VVF1QWI0TEpkZW5tMEdEVW01Q3hHMVphWnA0VmpITkNkWmEKcCtw
U0Jlb1B0cUVCVDUvb1FOUzVxMVIweUZxbWo1aTd0U0RaK1NCUzFCY0JJOURHMTBIZVhVaktZRk5a
CjlJRUx1VjVQSi9ZOW5zc1puRHU1M1ZRQ3craTIrYUV1TDFrYTNIbzg0UEZPaDVadTJiWktNaTFU
VXJqVAovNThrRFhvRVFocGEvODRBZHlpc0JEdE1sQ1lDM09vS3dLRWRVNWZ5SjRkT1dPN0hLNEY5
Ujc4K1JlemoKQXlsM1RKc0tLZTNMbkI4c3JGa0pUbmdrck9VS0EvdE80OFA4bkNMY1VrdjE3elc4
VXlnM3B6YkYvQWR4ClNiWmtEUnpmKy8waXMzUE4xd2Z0MmowUEErUS9odGZsb1BqZFJrdmtlMGdL
c3R5ZjNwcVF2dDRYem9OeQpkQWpEdnlZKzRORUNpdHh3TFRZZk1WcElQVFlGc1pHZlRVMVlvc3Ns
RkZ0ZXNiTEE3UGoxZzNpcXFqMHEKSGIvdU9KSlhva3lDalFGOFZPdEZqU3dBVnpLYjJnZGJmNmRx
NlVIUndIU3VoeHdKU2JmdHFLRjRub1pnCmxMTU8zcWZXZGFHVEFaeTdFNlRWeHBxZzFrQVBRbEFL
NUhISmxRQVJBUUFCelQ5aGJuUnZhVzVsTG1OdgpkWE56YjI1QWNISnZkRzl1YldGcGJDNWpiMjBn
UEdGdWRHOXBibVV1WTI5MWMzTnZia0J3Y205MGIyNXQKWVdsc0xtTnZiVDdDd1kwRUVBRUlBQ0FG
QW1LZkR5TUdDd2tIQ0FNQ0JCVUlDZ0lFRmdJQkFBSVpBUUliCkF3SWVBUUFoQ1JEa0xqclpJZUs1
NlJZaEJHZGR0anRTMmZjMmRFSGlPdVF1T3RraDRybnBKRWtQLzNTLwpGYUUrQnJmY29OT3dQMy90
ZTdiWGFhb2p0dkFjTG9LZFZjM1d5cjErSlRTREZ3OWxHYVlJMVJUaHBhczAKM3RTV3lhY2Nucktr
V1B4eVBlc1lCMjJTb0FkRmlYWTRIVGttRnhSMnFlL3N0Q055TkVSQ2k0c042RkpRCml3eDBpYmpN
SzYzKzlEeUlhNkM2SDUrV3lYNUhNVUUrRlhJK0lCY1FZdE5lcjV5aFFPWEkrN295NitvSAp4NmpS
SU05bjRMRC8yUEF4a2pTd2RxQzI3YXk2UFRMeWZWNjI4a1ljdko3bjB6bjFyQkg2UGM0V25iVzEK
NnFVRVBBV1JramZhRzJQcjJmcWJNd005VzQ1QU1mWWtpSDY3ZXdYNkpRb0VvNFpSYjh5MTVPdmw3
VytqCnVUZXdxcEZDb1hkdHNMSFhKcE9CeEthS1ZuWCtSMlZCYzd5c3lzN096cEp4Znd4SU5ReGtU
QlZGWGZ1OApLWG9heEsrNjllOG9QWGFVTmdhVEdoL3praEp6Wm8vaHJGUlAyMVhHbGFGaFJtclJo
Vy9XNWVTcnZWdU8KYWYvUUMvMGpuVFcrZmhUL3VlKzdVNEJXOXdLa1lYVThJWGhTdllDazl6QTZ0
MDdxYVJzYVowUlZqNUhTCk5NcmFXYXFDS0Z5NkxMUlF3RWtxa0IrKzFOWFdNZFFqQldWY1hnTFNj
WGdLQjlWclVES0c5RjdCQTdVTApQQ3ZZMUwrN0MwS0E1a3l1WUFVWEpIbWhoVzQwbFJOalVFMlZn
WjlWNjdhcURFTVZGTFV2QS9QdDFTcG8KaWtONWtwejBsTGtzdmFnb3pVWUZlME9EVU1aazZKblZk
OUJmZVNQQ1FoQVp1aTd5QkRlSyt5QWJPWkFxCi9yTzNLa2lWRmRrNVozRWpzc0tXenNGTkJHS2ZE
eU1CRUFDV1IzajFSbVlqMGd6bmtWVkVsUjZBNDNueAozR0pydG93VFRmMEhjVkh0WnZQaTBUREVE
QkVhRTI5anY1SEJZTXpoTXRnWVNVYWQycXEzRU1ESlZ0V3QKWnFIQ2xEMGl4M1JCaHVWM1REN0hM
REdSK0ZXVjZ0b3JQWE8rSVhXWUtkS3o1T2k4WXpaQjZHaWdSNU1VCkFWSi9TVWxtRjdqeENIRVB1
MU1jaXJEd3RhV0dzSlJqOEQ1R3JlZ2V2YU5nTDdYdXJCTXJwOXV4SGd6UgpLdmJwWU9UMjBITDV5
NFBZNnVOOTFjNTZ2cmVVOHhvSmZ2NVh3M1UrdDVGQXZPK1FHaUVhTzVkZ0pVQmsKY3MyTndhaU54
SkZQRURVR1ZjVXBFNVpmSEc5ZmYyNklJb2R2ZjdoVzdTZmhkNUpObTlvejlFUWUrT3QxCmsyUVpO
ZzNjQ3N3aTMrNnNNbEhjVXoxaHJ5NmMza0dsejJXamhkcWJ3OG9NajBKQU5OUnRNb1hKOFFtWApB
SVBzcSt4TEpjYmxtaWRrZTRWc0lURk9YMzEwdnhocDJrTjlZam1JQTZBT0piam55MmJ4eUtIU01L
emMKeDlRTTRvOVJnMis0dkhtOHdrU1o3dGZWYUtDTWtjMDQwald6SktCaVhaK0NIQS9kSG9wYXRK
MWlnSmxzCldXYk9kcXdJNThiSHM0SGVvcXZEczFhVGhNUjlaVG55bjFCY0pjV1p0L3A3RnY3VkRo
akh0K0NIY0NTawprNlZTQUZubmVGdjNaUkFUZHIyMGpNcC9sN3ovNmtyMmw3dmZsT2ltMnJiR3hk
Tm5GNzNJWDBhMXBLaGMKaGMwUVZ5emEzYXpJZWdjNHVBbFhDaFZncUJ4T1F3My9penFUWE0vUmZ6
TXYySDl1OXVZQW9lNUl2d0FSCkFRQUJ3c0YyQkJnQkNBQUpCUUppbnc4akFoc01BQ0VKRU9RdU90
a2g0cm5wRmlFRVoxMjJPMUxaOXpaMApRZUk2NUM0NjJTSGl1ZWwvdFEvK0xiYkZFdjdBVFhzUXpQ
RituTXlIQVI0NGNsZzlZMWxnQjVIN2tZM1IKSW9pT1o4V2JHNHhocWV6WXhTaytyOUxNS3IyZ0hn
VkNQNFJZei9MbnNtMHBYa3ZKbTFiV1dmTkZOVXd5CjhnRnY5c2QxVTNDTFZZUUVidElnd0ZBWWRW
Q0NiV0RQY1pXWDBsV21KU3BnbUt3ZHZIQWxqZkkvUGQ5NgpPN0N6V3JSenpEU3VMclZRWjdiTkRw
MGhTTGhPYXp0SkoyR0V1c1F4emJqUHJQRGZOT1lEa2NSOHRWNEEKSEV3cE9YckJSWElmdFQrVFZh
eENLazJwdnFaR3hVSGZsTkNEWFhlV080N0dWQzBWTXlNZ3ZMVDJIejl2CnVYRlNmRktDNHBDQWxz
WjU3d1ZBbjVBSVhMQk1laytPWmsrTnNUMVBLK0lQN0FpV1F4YTZnaitjb2xZbgpsOHNaSGZmNGxO
aXdwQmgyeUdBYmY3Vmo4UWlXZVNyV01lTk8yZDZvZUxvTzc4eFJMRittREJvN0l2RzYKVk4rSkFS
WWFsa2I2Tjl0MGxsc0NSdTVUYlhGMDg0cmI4dWZIQnR3dnhMYXR0U09ycnpCWHJjdWJqa2RBCllY
aUdldkJsR1B3VTVlZFg4anpISTBtTTVwanJjMnJpSHE5QXhnUTdDQThUTERCRXlsNzZXdmRnTE1E
eQp1SWRlU3YycEluVlY0Y045MkFzNWNSSzVZNHc5YTlqNU1oWmMwczJ4aE0vc2pibkVYWFlIdkZw
UnNEdFgKQi9CQTVYWUljaE9rZnJiSVJ0TEl0SFZyeklMTDV0cW8zNkpIbTVxYVRHaTlnQ1Q2QXZ1
UmJEY083VFhQCnM3UVl0Z2h0c2pUcU5HeE83eGl0cmRtbDVUbEd2VGxpdWVibEQ2NGVlV2M9Cj1o
bDQ4Ci0tLS0tRU5EIFBHUCBQVUJMSUMgS0VZIEJMT0NLLS0tLS0K
-----------------------a51318db5406f41c20f644a3a2ef4595--

--------93a1da1b0758e605036b6ea1dede4165b34344bbb7d70d7a43652b7a05564b28
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsG5BAEBCgBtBYJppzz8CRDkLjrZIeK56UUUAAAAAAAcACBzYWx0QG5vdGF0
aW9ucy5vcGVucGdwanMub3JnX50vhRey/WcUFR/kdCGTvYci3GT3VrUzeuWn
vr9QgVUWIQRnXbY7Utn3NnRB4jrkLjrZIeK56QAAhN4P/37/7twEiyqoKDck
rP3rxX/e4+54brQr19Q7f2VoI36f66FBMxPBeG9u4Qq1gPEriKeHC4rhTtuK
fcbVHlm/5VLUWIRMr54AhYpGJ7cnTJp/1PntvL7RluM/O+lPP/hWUtsKz2L6
IY4Nsb5RZQlA/1Vl2TAYbMA1hMTY6xyEdjgY2NtdJdTre+rcgIfheIfOzjEs
ejkFZr8WfzbcDz8u5u4w1sRyV896lUwWU1z3HoRy871Wu8PHnr3H1xj+Xu6a
+k9MtB/aCQIjourBpDbTiielT5aHnE4ip7XjtFXrZknHxb20RIqo1ODnqTLY
0/dPX4DbeU22AySsuuT7MGnmw5P2YZGvzjH8lvoMyePc+1DW+oxlURlyfn1p
N/FnA4E8r8oIaQrBlKmEIPwGT7g4tAG+K8lildneH05GIbYSc3QWT199VlK0
VOp5PMQQ4LofUHF3h3ZatNk3G/jtZvWP8xVqiDVd3Vsqx4+J3nVKW14nRA27
f6OT8yNidyl0oGlf0OnYaPnv+UDJuYU06EWDoTcW1cCwJm2lRYmPq7CUU6By
LJ1Vk44zVqhf2V8E5KiI72pBTC0VICx4eWZbmqdzYVWFHyet8LSpZ1INfTya
MAgUprO5y1dx1O80fdsgIibgN6mJzHgiI5abjpIowxH4fLKdCLgsXdU5nqIq
geLCvwWU
=el7o
-----END PGP SIGNATURE-----


--------93a1da1b0758e605036b6ea1dede4165b34344bbb7d70d7a43652b7a05564b28--

