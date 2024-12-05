Received: from mail-40130.protonmail.ch (mail-40130.protonmail.ch [185.70.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A48B19ABC6
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 19:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733428371; cv=none; b=KDqY7MpGnh8tImCsLNmmpKNVGfJDbzqa/bK/dgjMMDcpX+xxXqE3tU9jrIY+DnDsN4ampMzozE2rpIlKQUal0f6GX3ZLNcdFmdNPm/D7lAyGsFY81GhwJ/FhMrY69ooJgGihEQ0Naw2Y0+3vRUZE9zl1hdEIsCQ502axY6kYyhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733428371; c=relaxed/simple;
	bh=43QfBISovb8SNGuOIPDxNJfqu/3XBcmo8lts5JZfbBQ=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=bkCGWygTOaSH+6339k2s7bNYaK+ZkgW7XbHm7ceup6boe1pVWDmR1dkg6Y1MxXKe5HllCCqna8wzySGPwolwcNl6OVpxRNkslbhRCGDqDB4rFAl1Tb2pwYGnhzSyuS8oBl1pXikELELjqFswWlZ9gtuAzHzb5jDYioYtG1/bMGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=eBi9ZSE0; arc=none smtp.client-ip=185.70.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="eBi9ZSE0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1733428361; x=1733687561;
	bh=YDRBrr/7FmCRpEOfEiaBEvymFwTE1Wl+TxKdvBrP7Uk=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=eBi9ZSE0xzDr1pgCEK6RaifE7Hd8hrh8efovgKps21SICqKiyN2FSX3vXaaauQOJI
	 PMq7/2VhHPhv1pNsAwtPDP0qdFViyw0x97RrhbP+e1CySmuImpyaKlxMlRJy3SyCu/
	 5g8L+v1nfi4rQjMOcHKmOXjAvY7dhUJ/QQKjaPi5Zr3hQX5AmBYbN8BaQbtVElFRES
	 Mk1pzUZ/aFZadO0ymdkQodovG7PP8fdIX9MMX4UAOe5mcNmbv+N3bvV4x8h/Go1YPS
	 SCpdOYLbRx9rcWVHyWsk8L5hKr1vQe2u8MTmJwJPYZW1XAP79firtk0zea0dzWiY6b
	 976Foc8T3GKig==
Date: Thu, 05 Dec 2024 19:52:37 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: A bughunter <A_bughunter@proton.me>
Subject: [help] git status doesn't seem to work.
Message-ID: <n8KYxrArhb3MywPvDHVmEz0dka8QYYWikLDZE_aboUX9GBgF2X9uomuxtrPA6VmS33TxXyltJB4xqjALIuprVvE12prKd_ZW4MYM9kC4Qds=@proton.me>
Feedback-ID: 120910843:user:proton
X-Pm-Message-ID: b6335414d3e0dc08fdc2789b20f08423b8ccbd0a
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1=_UpKYLst2CZ0tH9IkLtzu7y5w81SEHZzYJuATLDCpCU"

--b1=_UpKYLst2CZ0tH9IkLtzu7y5w81SEHZzYJuATLDCpCU
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512




[help] git status doesn't seem to work. See how a pull caused updates after=
 status showed "up to date"

```
~/Peeranoia_Framework $ git status
On branch main
Your branch is up to date with 'origin/main'.

nothing to commit, working tree clean
~/Peeranoia_Framework $ git pull
Enter passphrase for key '/data/data/com.termux/files/home/.ssh/id_ed25519'=
:
remote: Enumerating objects: 17, done.
remote: Counting objects: 100% (17/17), done.
remote: Compressing objects: 100% (15/15), done.
remote: Total 15 (delta 4), reused 0 (delta 0), pack-reused 0 (from 0)
Unpacking objects: 100% (15/15), 6.41 KiB | 312.00 KiB/s, done.
From github.com:freedom-foundation"up to date"/Peeranoia_Framework
   03edf66..4cf4f51  main       -> origin/main
Updating 03edf66..4cf4f51
Fast-forward
 README.md | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)
~/Peeranoia_Framework $ git status
On branch main
Your branch is up to date with 'origin/main'.

nothing to commit, working tree clean
```

from A_bughunter@proton.me

Sent with Proton Mail secure email.
-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKACcFgmdSBIIJkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu
8pkAALjBAP45ZhMdBcf1zjdJRoyhz32ikG5ndCkNXFn95CpUH0txcwD/WuZQ
ZJCa46Cavsdv6ZL6kFm0w+KA9SEifL1N5eoYgg0=3D
=3DjjzN
-----END PGP SIGNATURE-----

--b1=_UpKYLst2CZ0tH9IkLtzu7y5w81SEHZzYJuATLDCpCU
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

--b1=_UpKYLst2CZ0tH9IkLtzu7y5w81SEHZzYJuATLDCpCU
Content-Type: application/pgp-signature; name="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"

wnUEABYKACcFgmdSBIIJkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu8pkAAF6CAQC1uyyr
RJf/cXW9JDPP/klB+2RYavtpGIa12ibhKmWAiQEAuYz3h6WFI3rmyIl2CfZknC+/x0AP0M6Tb1f1
mjt1VAU=

--b1=_UpKYLst2CZ0tH9IkLtzu7y5w81SEHZzYJuATLDCpCU--

