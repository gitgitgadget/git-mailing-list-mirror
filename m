Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B6818C022
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 17:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731605734; cv=none; b=bP/u2i/0UfSt5+VpMkuK10ITKQbcomGzS5jT3WViA04XWisNnA+pAiYQ2UHDo73WusMShB6UPaRpB9Q5y7j08w/7OQd8wobfmyh+YWG05FM6Akzt1UeUDCO/RfGTWudZK58OTh6oLy5Sp/ORcIqn4w6W7LCyZKXl9I8YFqFkoYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731605734; c=relaxed/simple;
	bh=/tnPCFHAW0/UbANc5WFgalEngYxpDTQ/Z3zBzgnfcSs=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=N9J/aedDCTtgN9ecVz4ZCq5wvZGTRCZsGG6Xm6dWYDA/bHbO5v2n1MXj4Lt/Hd82CR646KIBgK310PBDbEKXdlhpW3eiMrv0ORGnSYMAFfVETlEawXUbOhwTc9FG8yd/8tI12IGAF0D1z+drKU0yPVbztB0BfdG/Kodhjz9Patw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=RL51/qxI; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="RL51/qxI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1731605717; x=1731864917;
	bh=/tnPCFHAW0/UbANc5WFgalEngYxpDTQ/Z3zBzgnfcSs=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=RL51/qxINzD8XY0EZRCNWU5kLKNCw3+1UFkV0thtCctCFz/7jlJFkvtug/jSxvZKT
	 2ehPLzmSUIE4heqEvfBuz9Cwl5t/NC2xpqFD/yqMyyPLBkrBfiAD7OoX1MvS7oy/lJ
	 YmrlnHP7jtAPi3DoNAbKSoSfkxnV02aCQVUZwPjxOPlNJ1s5O4I4xuxK4QnA4n0Bgy
	 wL9kT1O7h4W9W20rzGQJJ42x03a+7pVLzC4XcC/X89atMffPuVd2dqCFrpfqmO5S2m
	 B3taQuHkJv+VKRwSJYxQTOb0N+dhp4uc5Y27vNdvwDeTvog1qCPMZLaTgmOXReP9vG
	 Xb6lFwzB4T+9A==
Date: Thu, 14 Nov 2024 17:35:14 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: A bughunter <A_bughunter@proton.me>
Subject: SUBSCRIBE
Message-ID: <2P3PDQjkCUaHWvp3LXLjq1gT6ikydEkUy_5VOG1PbQgLj2FB4TzVreyMDKEFIYDStEaW82YCAuq_Lff9cOgtmSuc48apk5NlAorBUiY9FiM=@proton.me>
Feedback-ID: 120910843:user:proton
X-Pm-Message-ID: 9b7a6e649969e4ca5ad971f94b628ae82877b6db
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1=_aap71KJp0n0G3G1ulEYmevN1pSubvBVYuVwQ2iEXtA"

--b1=_aap71KJp0n0G3G1ulEYmevN1pSubvBVYuVwQ2iEXtA
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

SUBSCRIBE



from A_bughunter@proton.me

Sent with Proton Mail secure email.
-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKACcFgmc2NNAJkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu
8pkAAFfyAP4yIB6qFLD31DLqc3G4iVlapT3wE2+NIzHj5UHWTv0tKQEAonjo
HXqLKcgpoHTrIKBY2QwwvfCQ6q4oSd4v8qZnqQo=3D
=3Dwmxp
-----END PGP SIGNATURE-----

--b1=_aap71KJp0n0G3G1ulEYmevN1pSubvBVYuVwQ2iEXtA
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

--b1=_aap71KJp0n0G3G1ulEYmevN1pSubvBVYuVwQ2iEXtA
Content-Type: application/pgp-signature; name="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"

wnUEABYKACcFgmc2NNAJkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu8pkAADhgAQCmyr91
YzQwd0v51x2WRh/c8z2yLOYO2Pd4DIbbOk0oiwD+PajFf4jxvziYJZGGo4LQA/efnQyS1zKHVzQq
JGUrowM=

--b1=_aap71KJp0n0G3G1ulEYmevN1pSubvBVYuVwQ2iEXtA--

