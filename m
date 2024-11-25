Received: from mail-40137.protonmail.ch (mail-40137.protonmail.ch [185.70.40.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D34D268
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 16:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732553919; cv=none; b=UdLuNvOpg9+c0NxPtJ03QsMBR7WqZ+K7Y3DsDeDozsX8bLMSZwy6CAbvA3F/8PzQOkHPEjBhJBzXKvUcQM2ALXrQlpxNxlyeLOKSdWNIKc6ql3Sj/syLM/RJ/TYHc+zbZ5KI/+axEXMKMH1zQDLCXs/UeKZGx1HVRMz4y+3iB+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732553919; c=relaxed/simple;
	bh=9D9IJWqTHh+2yqXSVdMHRQPS1NUh2tLYhFf6XuIrXCk=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=ZQSHXq2A4drDby7XeWLPKYvWw9AW8l5891dJyH6MseBIOhlZW+zIsly7TCqHf9ZsaNCnKO/zuCbQ1Pvc1gC9Wu44rHNMCwE1aaq9SPma+cwvaddjm/NkiLmrbWJsmF7b7vhnJ06w6AcMY1DbsOR0b427JMAVvopQ3vTRiNgKFSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=WLv0oN3Y; arc=none smtp.client-ip=185.70.40.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="WLv0oN3Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=ono76ml7rbghhnunl5nm5zwr64.protonmail; t=1732553909; x=1732813109;
	bh=9D9IJWqTHh+2yqXSVdMHRQPS1NUh2tLYhFf6XuIrXCk=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=WLv0oN3Yi/cfx1cUC8N9VxWeUt2+R7TwRm/an7QLQaI+hjTU7D/7ZBdE7kzBNywF+
	 i5ZgdehSe8I2jVKCCLZua0Czw9BVFd8c/8JxFOBmABgUwjVZRTxaQBodHBEu9neLFi
	 NDs0k4WiFSA0Ke3X7wO0tCb+J8UkZezAafXafTgfZ/pdIefiqhNi3KmLItwzJVHmP6
	 f8fS5IPawM3bEnmNM51XRD5X1hVEY3yJu8boakc3ipv0T+Qjgy2CMMyoWVV8UBeU/P
	 3U4udYIPQ0hg+KAwPHEpwNQzTBmmdTSIAHCU0oFOsmZVp0tMyC5wM5J1TNXnYyUOAD
	 rKmZBPqVFIniA==
Date: Mon, 25 Nov 2024 16:58:25 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: A bughunter <A_bughunter@proton.me>
Subject: [question] How does git status compare logs?
Message-ID: <_eigZQXbNAqu-NrM8-CcbHJEmiHblsPSmmkHrMsUGqX5SwBmQgDXIo58ctopjK_ogO-mfzh8KiiGsdAGqQq2wf4AMZ7tHYWgCdpMCMoKxR0=@proton.me>
Feedback-ID: 120910843:user:proton
X-Pm-Message-ID: 8c16d49b1fa0a8cca2be8d440f68e2a6773a1216
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1=_JpwytBbTwsrAyKWOt9RJLwZoU8oVEYui7sO680e4"

--b1=_JpwytBbTwsrAyKWOt9RJLwZoU8oVEYui7sO680e4
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512




When using git log to find the commit-id -
Q. How does git status compare logs? My git is configured for SSH but I do =
not see any ssh call to the remote.
A. git status uses _ANSWER_HERE_ to compare with remote.

from A_bughunter@proton.me

Sent with Proton Mail secure email.
-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKACcFgmdErK8JkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu
8pkAAGyYAP9nGhlvRScg5QC6ZA2jrbSlbrIY9BKjjR3gj4HCeMuqmgEA7y7r
1WmgGQ4vg5+6ecdMPxraFW9MdMsHnI5fTPCJ7AU=3D
=3Do51m
-----END PGP SIGNATURE-----

--b1=_JpwytBbTwsrAyKWOt9RJLwZoU8oVEYui7sO680e4
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

--b1=_JpwytBbTwsrAyKWOt9RJLwZoU8oVEYui7sO680e4
Content-Type: application/pgp-signature; name="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"

wnUEABYKACcFgmdErK8JkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu8pkAAL/YAP41v0sw
wNdL1YqYicG9j/HlSwv6zAuBwUSJZMFgkS4F7gEA9LpmvOLVuzCrCg8vwxZSb3yc/2GH2QZYbFIv
6FB67AA=

--b1=_JpwytBbTwsrAyKWOt9RJLwZoU8oVEYui7sO680e4--

