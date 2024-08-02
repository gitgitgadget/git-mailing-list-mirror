Received: from mr85p00im-hyfv06011401.me.com (mr85p00im-hyfv06011401.me.com [17.58.23.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3997256D
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 09:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722592005; cv=none; b=f9gVlgXF7AYdGxjlO8GL/vfyLLmb2LgEmJ4Y8jbq3UxtkywbgkHm7YzrUwMhsPe+DR0rXuut33bdFdjNJWxtr7/MpOEzN0jM2tymu1zBMK01r9mCBEa1IIVW3PXHXgMV25UJheDzHxuXSyWRh58gbpy45eXVMsnVbp3R7EpukyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722592005; c=relaxed/simple;
	bh=tWV5FakjZN3QH4XXRfOd+JcI1b5FrCdIB5MPwtXzXO0=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=G4zqC6hawbx8tgBdQiyXigyEVOAI5DCiTyO44+wv7SchmprckpGw9eFTwbJFmGQT7/PA33k/O9mjw/w1MFslcHuwV08fqWB6QwXRWGpx4y1hgCQScQXfGVt7B1Fr/lMxLriU1yY7CS5N9uTTbiIk4yZKqPPNvVI4RcyQMHmBByU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mac.com; spf=pass smtp.mailfrom=mac.com; dkim=pass (2048-bit key) header.d=mac.com header.i=@mac.com header.b=Fqk0IdBe; arc=none smtp.client-ip=17.58.23.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mac.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mac.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mac.com header.i=@mac.com header.b="Fqk0IdBe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mac.com; s=1a1hai;
	t=1722592003; bh=y9tiN7t7wgbVzsYpWhsjQuP2GpKBKuA6KPiYs7ks9VE=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To;
	b=Fqk0IdBeUQrWsSorEbQzyLUsWHHiehgogaX8YFaUqKptoB1XpBRUdLcv2EBTJN91P
	 zagRY2mcCRGHSEgGjv3xBeMwZg7JBX/hmphis/jwWwGMkE76wXQ3eUY8L0aigqrC0l
	 DKh5nKEBN99HzFd/6+LnfgTul2kAHr/KMfJ/91moUiWKpz44wowUzwx/MSc1cUusTs
	 MUQVpYdTFN8um9gBrn/m4cmS8fruk2t0QnkFRh1NFNf0JoQuQBBTDCYXoPB/RQwL4o
	 b4v1zzBLfhFm7EziWJrv4buiLVMAJUghKqIubU/7rfdo9whH+6+1Hh7IYOuQ/2o8Vo
	 fk4dLtPe01qjA==
Received: from smtpclient.apple (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-hyfv06011401.me.com (Postfix) with ESMTPSA id 9C23A357AE1C
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 09:46:42 +0000 (UTC)
From: the.tester@mac.com
Content-Type: multipart/signed;
	boundary="Apple-Mail=_A99F71C5-CC8D-4BB2-AD40-C53F76A75D82";
	protocol="application/pgp-signature";
	micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Date and time processing issue
Message-Id: <B896574C-A150-45AE-A636-ADA9ADF3255A@mac.com>
Date: Fri, 2 Aug 2024 11:46:30 +0200
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3776.700.51)
X-Proofpoint-ORIG-GUID: Jl4y2TCblbxojfhNXwVPg7fCmBl86UPq
X-Proofpoint-GUID: Jl4y2TCblbxojfhNXwVPg7fCmBl86UPq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_06,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408020065


--Apple-Mail=_A99F71C5-CC8D-4BB2-AD40-C53F76A75D82
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi all,

Context:=20

I=E2=80=99m preparing an example repo to be used as an example and for =
exercises for a tutorial I=E2=80=99m preparing set in time travel story, =
which should explain why I=E2=80=99m doing what I=E2=80=99m doing).

For this I am using the environement variable 'GIT_COMMITTER_DATE' and =
the '=E2=80=94date=E2=80=99 option to set these time stamps.


Observartion:=20

When attempting to commit changes in some cases the following error is =
reported:


> GIT_COMMITTER_DATE=3D"31 Dec 23:59:60 1969 +0100" git commit -m "Begs =
sharable holistic policy" --date "10 Apr 02:42:06 1970 +0100"

fatal: invalid date format: 31 Dec 23:59:60 1969 +0100



A second later, thigs work as I expect:

 > GIT_COMMITTER_DATE=3D"01 Jan 00:00:00 1970 +0100" git commit -m "Begs =
sharable holistic policy" --date "10 Apr 02:42:06 1970 +0100"

[main 4fc6ea0] Begs sharable holistic policy


How to reproduce:

$ mkdir tmp
$ cd tmp
$ git init
Initialized empty Git repository in =E2=80=A6/tmp/.git/
$ echo "Some content" > non-empty-file.txt
$ git add .
$ GIT_COMMITTER_DATE=3D"31 Dec 23:59:60 1969 +0100" git commit -m "Demo =
commit" --date "12 Dec 23:59:60 1969 +0100"
fatal: invalid date format: 31 Dec 23:59:60 1969 +0100
$ GIT_COMMITTER_DATE=3D"01 Jan 00:00:00 1970 +0100" git commit -m "Demo =
commit" --date "01 Jan 00:00:00 1970 +0100"
[main (root-commit) a5c7d72] Demo commit
 Date: Thu Jan 1 00:00:00 1970 +0000
 1 file changed, 1 insertion(+)
 create mode 100644 non-empty-file.txt

The same lines from a short shell script:

$ cat reproduction_sctipt.sh
mkdir tmp
cd tmp
git init
echo "Some content" > non-empty-file.txt
git add .
GIT_COMMITTER_DATE=3D"31 Dec 23:59:60 1969 +0100" git commit -m "Demo =
commit" --date "12 Dec 23:59:60 1969 +0100"
GIT_COMMITTER_DATE=3D"01 Jan 00:00:00 1970 +0100" git commit -m "Demo =
commit" --date "01 Jan 00:00:00 1970 +0100"


System & version info:

Git version: 2.45.2
OS: macOS Sonoma 14.6 x86_64
Shell: zsh 5.9


(My) Interpretation:

To me, the error message is at least misleading.=20
It also seem to be hidin the underlying issue that git (commit) =
doesn=E2=80=99t accept time stamps before the epoch.

Given that 1970-01-01 00:00:00 seems to be the lower boundary, I =
expected some time in 2038-01-19 to be the corresponding upper boundary.
However the same error message is given when the date is >=3D 2100-01-01 =
00:00:00.

Personally, I think that at least the error message is misleading. =
(I=E2=80=99d say it=E2=80=99s a bug, if one that=E2=80=99s not =
particularly likely to run into).
I expect the error message to point to the real problem, which is not a =
wrong date format, but the value the timestamp represents.

I=E2=80=99d also expect that correctly formatted time stamps containing =
valid date & time information should be processed correctly.=20
(at least for dates after Friday 15 October 1582 (as the day before was =
Thursday 4 October 1582)


Am I doing it wrong? Is it a bug? Am I expecting too much?
Can I do anything to make a wider date range available?

Best regards

Stephan


--Apple-Mail=_A99F71C5-CC8D-4BB2-AD40-C53F76A75D82
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEImVTW2kalIKnTbGpN5OCOCEvsmQFAmasqvYACgkQN5OCOCEv
smQE8BAAuOH8brXJkVWiusfO/jkFG7OFAbEFY9N7sxaBf+/3NpiCCh9Gb0+nzENB
oEyypJMj6VbnW8K9+7SPSPqNyRVmFpxIjA4wsk9X2cHmY5haA4Sen7e1OigQR2+S
4hVMzeH3NXmltyL7CFhVtqfvPvuhFQB2iYKlVAw/7h+C4+D0MccpZwSUSQ1+Sszs
3TN/ad97OBSCOzWVpagY0BEXdwu+nlKj1eLxg0nEarVzr06HJIVr1iJXiYaLL7Hj
N/RHR6k/VTInmU/RZdJHcGTl7uTYDmy8SeTK+1e2nPY0955tw2huKhvF1EZmsTdy
cbGLLbIQTfRu9/2m3MQBFNpbCdBIAIoTOhDZjY71E+CiW+SrC+s8X6AZKg9v++Kx
uFyhMZQn+l+TW+oNNIAkKtpXcnf6i6JX7ws6ZLUxHgh742IU3qivJWwc/Sa06QZX
1nwgmuGasejqbaQfZJN2GL58hk3npfWYVjtaRo/jjEQTQ9vsChcIXpF1wlQVcO1l
Qxv/Pk5z0AbQsOkRgGEyuL6DCLu28kZL9Jq1Ly2Xtm6fvH65YvlA4CYCdBNo6qBE
bFDQE0Ob750/RrkP33rVZBVfNSRwEg2dnhFTw+HgTlbfy8iVu01K+wyC3kbvfm7y
d4JR+rIZNCWUFP9hvVpMKXhDgxTkrUUM/ANRDaWlCVnayXbtYcA=
=O8CJ
-----END PGP SIGNATURE-----

--Apple-Mail=_A99F71C5-CC8D-4BB2-AD40-C53F76A75D82--
