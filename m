Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5A93EA9A
	for <git@vger.kernel.org>; Sun, 17 Nov 2024 11:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731842667; cv=none; b=hQH71Ccnr2ST6aoedKhz88F2rRgTW6hTPCRrUCZzKvoEqCOzji4zcuYHuTBOhd2Bhkep4sJennD7ImxfWP8JKkJ/bi5K0uGU/u3MaU9ApjSqplAtIAi+HsDktborr7Mmz4bIs68n+jC39VCUs50a8fQdQr4a7FouUlIsN3WbT3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731842667; c=relaxed/simple;
	bh=bRfTmg5t4bvk9jEvwoytElrzW6Q7ZCpbAhAsaOKj/Cw=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=a+8mnZ3LtcCp4fE6p3NpuSgBvYIw1FL/VyIgGR2Srv4Vx8CB9WF+vznl8j0Om5z8yH/bziaESr+W4SuJ0vjpvgKOnJPiZyols0nMz2vLzHkvWQnPbOYZWQPry4ZyVBvfUqR+aV/nVMNQFsmxCCnNOkKYTsD3GmWsuvpywQg2Q5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=CI1COlSo; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="CI1COlSo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1731842654; x=1732101854;
	bh=bRfTmg5t4bvk9jEvwoytElrzW6Q7ZCpbAhAsaOKj/Cw=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=CI1COlSoFJE5Bo1ThxsqeqmxqBXyAIhGJAv4XlLI1WTrqQb6Y3vUnLlt3RfZKg0NI
	 YG71sErDb38Ev/8sVA/OqJ17v4pMKGiWM1EThJYopMthwQly1zbwYzKcDog1g6LOsK
	 Lb4ra3Tc1PEm9E5p5QCNSr+YyMmd/8aq/zQMU28g4Uw4eHAYZsgLapmgKwpTe7iyAC
	 sbP93R2z6z9DxQIv3XzXnYHY5kkgc9WKchBEG07TUkvXwP3gNiCzuotgHWTZhcmgcs
	 UnykRyjx56yU7+E7zmKP50Wej6bSm17nf+HmP0E0tF+DaajECnowWS8llrwLlzbnPS
	 ZXvyA/iGkqzXQ==
Date: Sun, 17 Nov 2024 11:24:10 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: A bughunter <A_bughunter@proton.me>
Subject: How do you undo an add
Message-ID: <4hiTc8Kx5yNhYuN8abv3QFJBuptM6VWZ9OKvkdZFlSI5y0zoK-lN_VHf-QCSEjllmSWvu9V-tbrvFOx17_P0Nq8UKxEcK3Rs2d02FjbYuUc=@proton.me>
Feedback-ID: 120910843:user:proton
X-Pm-Message-ID: 3412a84342d3da96356f1082600a88af6223a62c
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1=_vgBTMjYbHt87C7hZWgSkGp0mYPU62q4LW6tKgOeY"

--b1=_vgBTMjYbHt87C7hZWgSkGp0mYPU62q4LW6tKgOeY
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Maybe if I ask a queation a different way? What is the problem?
ADD, ADD, ADD why cant they get that: ADD. ADD tracks files for commit. It'=
s already been commit : push failed. Failed pushes piled up. I need them un=
tracked. How do you undo an add ( many adds) simple question. Without delet=
ing any files, to repush 1 by 1.


from A_bughunter@proton.me

Sent with Proton Mail secure email.
-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKACcFgmc50lcJkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu
8pkAAAtSAQCoWAIHvKlg90Ehervf3zZtd1Ls65ZW0yMZ8ms6LgKClwEAn8lO
6WSjvf58MofXRnDD88ciYBQBqfbs3v//kOiIYgA=3D
=3DO0ks
-----END PGP SIGNATURE-----

--b1=_vgBTMjYbHt87C7hZWgSkGp0mYPU62q4LW6tKgOeY
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

--b1=_vgBTMjYbHt87C7hZWgSkGp0mYPU62q4LW6tKgOeY
Content-Type: application/pgp-signature; name="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"

wnUEABYKACcFgmc50lcJkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu8pkAAP3GAP4w5u54
IbkG53IR1b+RIYcT4HUp79J89kvg/JoWJYWqlgEA4MNm8utmNKocG+RqhYzetoz6gX7lJS7xA3nU
eBbIZgA=

--b1=_vgBTMjYbHt87C7hZWgSkGp0mYPU62q4LW6tKgOeY--

