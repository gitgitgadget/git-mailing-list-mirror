Received: from mail-43167.protonmail.ch (mail-43167.protonmail.ch [185.70.43.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B01126C1C
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 05:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731906279; cv=none; b=iTIXgC2emUk+jz9Mjg01eZWa0H3jl3mvHZUH+VvHElU2VfsHEdpxcIy7IC4AmidPGNDtQdecZB1MYSrtoQF3m5/mbrRfktTwHEEkwTE2fQZ1x16stjsQNbCG7WFhWM6dfEEB+WNDvePLuTPFJGamlrucpjt6+LfXnxpRvhgK+T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731906279; c=relaxed/simple;
	bh=n5xuxHGtdxZBpsTTdbSZj/hGiSeH3GygS0tdRs9i+3M=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=rgugyxk5X6MLaW1nrBbmKtROjaH8nN5IShaY5JbbDS6nQttMh0o0Opf0PuEqKHiCKHOL7r7PFFP274v11qlP4btf7PP6mSH100XzspMgOMOek7ZBpQFGKOt7rqqdBgl4TBt9rQ6uwYnnxEICnGSxBI2JSWM2j9VigZa7aGrhJAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ZF+e+bEq; arc=none smtp.client-ip=185.70.43.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ZF+e+bEq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1731906275; x=1732165475;
	bh=n5xuxHGtdxZBpsTTdbSZj/hGiSeH3GygS0tdRs9i+3M=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=ZF+e+bEqoQyusXIdnxOeLZXAEx3fy0T1tUc9Ymy3AyqTI7RxnvaXS55OQI6V2xYTy
	 KnrKH/o5LSsGp2eEcAzjmTrElEMaGDpxQF/eRNOiQ67d2BKYI3gqq7NaDE5tyDXx3Y
	 GlFTNuGgXJxsPQ//jSbEBNJK6aOvxaOdNDaXgsg7Wy6fkM/VaLgo6hfCsaiZ4yd+Zu
	 uy6s5O9vvhqoyVxaIbUYBaf1yoL/961OVqa26nxBKNssYybdyLp6hNU9BMpZh81gnS
	 HmuqARCe6WpgmFyVD6eAKv45nk1XDtepc3EG3VfLbvCer/4vNnuLHgbzgR7NIUycOP
	 0+hKRwK4T77lA==
Date: Mon, 18 Nov 2024 05:04:30 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: A bughunter <A_bughunter@proton.me>
Subject: How do you hyperlink a thread
Message-ID: <Sj2qFJa5yPRxluqhZvXlMwgfLuX9n6Um4OOS9IHNXCJU3jjE0YblQDUt0rOpEzY-fUHs5CiognunZO-ddQN-1IVVBEyxLz_2hl936VBW-JU=@proton.me>
Feedback-ID: 120910843:user:proton
X-Pm-Message-ID: de0076e04a583ead7662d4103a0fe82086c50a40
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1=_E50MP4FXijbzBH0z9TsYIiaY8QVCTvenIVsMtAhVHI"

--b1=_E50MP4FXijbzBH0z9TsYIiaY8QVCTvenIVsMtAhVHI
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

How do you hyperlink a thread in this Mailing List when writing to the ML i=
n order to reference related threads? I now have three threads going and al=
l of them are related BUGREPORT > TECHNICAL QUESTION > USE-CASE. How do you=
 hyperlink to a ML thread in a ML message?


from A_bughunter@proton.me

Sent with Proton Mail secure email.
-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKACcFgmc6ytwJkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu
8pkAAL7tAP9yT4XPOMJbwdk55MCkEwlLZr19EV8g/BWckgB6Rf8QOgEAvyKH
IMokmjRt/d2zH/L1cqGtLtkk6aF0ufbDhrVQkA4=3D
=3DVur4
-----END PGP SIGNATURE-----

--b1=_E50MP4FXijbzBH0z9TsYIiaY8QVCTvenIVsMtAhVHI
Content-Type: application/pgp-keys; name="publickey - A_bughunter@proton.me - 0x66540805.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - A_bughunter@proton.me - 0x66540805.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgp4ak1FWnUwWDF4WUpLd1lCQkFI
YVJ3OEJBUWRBSDBJNDdqRHNQWjZndmIrWVVHQm5BeDdKeWYxNEFWT0gKeGE4eTArZG1ONWJOTFVG
ZlluVm5hSFZ1ZEdWeVFIQnliM1J2Ymk1dFpTQThRVjlpZFdkb2RXNTBaWEpBCmNISnZkRzl1TG0x
bFBzS01CQkFXQ2dBK0JZSm03UmZYQkFzSkJ3Z0prS2tXWlRsUXJ2S1pBeFVJQ2dRVwpBQUlCQWhr
QkFwc0RBaDRCRmlFRVpsUUlCY0F5Y1oybE85ejJxUlpsT1ZDdThwa0FBRDlGQVA5L2RkVDYKNTZH
a2E5TnRNdm1kb1k1a3ROZ3FiWTVYYmQ5Zng2a1BFNS80dFFEL1hpaWFsS1FIam13QXRiY1NlMVEr
CjNjeFlMeE5oalU3bXluUXNwdjlkeEFET09BUm03UmZYRWdvckJnRUVBWmRWQVFVQkFRZEFuZnAv
ejJGdwpSa3B2VWdmN21xWUk5UktuVFZhZHdHZmdhUUxobXdnM0x4TURBUWdId25nRUdCWUtBQ29G
Z21idEY5Y0oKa0trV1pUbFFydktaQXBzTUZpRUVabFFJQmNBeWNaMmxPOXoycVJabE9WQ3U4cGtB
QUppOEFRQytmbk9tCjRWajlRbUg0SDBHVnQ3UnVPUUsrd09RMVBSdnB5bVNqZXlCSk93RDlHWXV2
eE9BVks4aUF1cEorcHB3TQpyMzZWdWtJZTFwWHVIbzlSaGp2ZUF3MD0KPUZRRncKLS0tLS1FTkQg
UEdQIFBVQkxJQyBLRVkgQkxPQ0stLS0tLQo=

--b1=_E50MP4FXijbzBH0z9TsYIiaY8QVCTvenIVsMtAhVHI
Content-Type: application/pgp-signature; name="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"

wnUEABYKACcFgmc6ytwJkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu8pkAADhyAP9CUzoP
7RhBjWcU+LtocEyufKrSccMHLx7NzxP7meEUzQD9GvQjsaH+3RfvwiGIyUbHJidvoIviYCv7ECb6
IyrzTQM=

--b1=_E50MP4FXijbzBH0z9TsYIiaY8QVCTvenIVsMtAhVHI--

