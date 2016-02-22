From: James <purpleidea@gmail.com>
Subject: [PATCH] Add --recursive flag to git bash completion script.
Date: Mon, 22 Feb 2016 16:00:13 -0500
Message-ID: <1456174813.16049.1.camel@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-a+zxBCB7WP7GnpSE/Wth"
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Feb 22 22:00:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXxao-00035g-Bo
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 22:00:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755476AbcBVVA0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 16:00:26 -0500
Received: from mail-qg0-f47.google.com ([209.85.192.47]:34403 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752199AbcBVVAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 16:00:25 -0500
Received: by mail-qg0-f47.google.com with SMTP id b67so121669071qgb.1
        for <git@vger.kernel.org>; Mon, 22 Feb 2016 13:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:subject:from:to:cc:date:content-type:mime-version;
        bh=IcstjF4pxoPOGq/5ppaJscObk8BiMUKw2HXwZ60ExMQ=;
        b=C7FIdoP50BFdw2ManJG05+cH4dClmFNhd5hjJPGUgI778AxvmBhvsOikFT273u9kvx
         8m+QxJ+wjsp3P6y9Sef2z03F61uoyfzuoB3uABrG/KdCcmnrf1NXXnIZlaAD1EKINlgS
         WYLt31Zi42KlY591h6bI/IAuknKJSGWpK6neWoHnKmWvbgTmnfslc85Ix3zgPuam3IHO
         WwPd5QHNkW4bAIK+sKBQyO1ntlL3ZrmmGuGsTDVjudmduQw4dYS7z5rIfkedsqQaYdfw
         CFPgYQ565NHRw6qCprAwfMlver+6W9+i6nPoKIduC/Qynpl1w+pCm/5Eic91Q70DnHEP
         AQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:content-type
         :mime-version;
        bh=IcstjF4pxoPOGq/5ppaJscObk8BiMUKw2HXwZ60ExMQ=;
        b=P5Qs3Z838pevj+Pz6cLk7mUUNUW5UKkAbgbP61X40AvJA3M7lkdYUHSqYi6KxFRwEt
         /hMT9+0jwis6d2mVkJPD0Bc9PFYoOoS1I19NSTOdXxPeYUiXannJi87JVz/leYiNL+6X
         spPLCXhkT5+tqKI1pnJSjI/oY8StLu6LfT1ceh1gzEPS72jeyeIwbrurObFtC/bVsKtn
         XokXFSBooPf2Jdz20mSBOWFaeiWwVNllThmvmZM2T2G/fP8NHQoHwdMa3gssv1UYtBf6
         0RF2O6cwBPxGi+siL1661zELLe0ZUaH2PeNK8icVy7Zbni79j6f6I9gg+44dSmDi3mtj
         2hnA==
X-Gm-Message-State: AG10YOT+MQ2dHIo2Oi9Lw1TM3UPKRW4p0jAcWYMay5rKdjG6NzbDeGQcp2gLZ/SxNqMXJQ==
X-Received: by 10.140.20.39 with SMTP id 36mr36810197qgi.15.1456174825175;
        Mon, 22 Feb 2016 13:00:25 -0800 (PST)
Received: from freed ([216.252.90.160])
        by smtp.gmail.com with ESMTPSA id y16sm1839406qhb.39.2016.02.22.13.00.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 22 Feb 2016 13:00:24 -0800 (PST)
X-Mailer: Evolution 3.18.4 (3.18.4-1.fc23) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286950>


--=-a+zxBCB7WP7GnpSE/Wth
Content-Type: multipart/mixed; boundary="=-k/8+xOSEKofVN3JanVLE"


--=-k/8+xOSEKofVN3JanVLE
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Patch attached!

Cheers,
James
--=-k/8+xOSEKofVN3JanVLE
Content-Disposition: attachment; filename="completion-recursive.patch"
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name="completion-recursive.patch"; charset="UTF-8"

RnJvbSBmN2ZlYjcxNGE3ZWM3MDNiOTc1NTJlMzQzZDVmNGNlNTQxZmZiN2ExIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKYW1lcyBTaHViaW4gPGphbWVzQHNodWJpbi5jYT4KRGF0ZTog
U3VuLCA4IE1hciAyMDE1IDE5OjU3OjE3IC0wNDAwClN1YmplY3Q6IFtQQVRDSF0gQWRkIC0tcmVj
dXJzaXZlIGZsYWcgdG8gZ2l0IGJhc2ggY29tcGxldGlvbiBzY3JpcHQuCgpUaGlzIGZsYWcgd2Fz
IG1pc3NpbmcgZnJvbSB0aGUgbGlzdCwgYW5kIEkgdXNlIGl0IHF1aXRlIG9mdGVuIDopCgpTaWdu
ZWQtb2ZmLWJ5OiBKYW1lcyBTaHViaW4gPGphbWVzQHNodWJpbi5jYT4KLS0tCiBjb250cmliL2Nv
bXBsZXRpb24vZ2l0LWNvbXBsZXRpb24uYmFzaCB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvY29udHJpYi9jb21wbGV0aW9uL2dpdC1jb21wbGV0aW9u
LmJhc2ggYi9jb250cmliL2NvbXBsZXRpb24vZ2l0LWNvbXBsZXRpb24uYmFzaAppbmRleCA0NWVj
NDdmLi40ZGQ5NTUyIDEwMDY0NAotLS0gYS9jb250cmliL2NvbXBsZXRpb24vZ2l0LWNvbXBsZXRp
b24uYmFzaAorKysgYi9jb250cmliL2NvbXBsZXRpb24vZ2l0LWNvbXBsZXRpb24uYmFzaApAQCAt
MTA4Miw2ICsxMDgyLDcgQEAgX2dpdF9jbG9uZSAoKQogCQkJLS1uby1oYXJkbGlua3MKIAkJCS0t
c2hhcmVkCiAJCQktLXJlZmVyZW5jZQorCQkJLS1yZWN1cnNpdmUKIAkJCS0tcXVpZXQKIAkJCS0t
bm8tY2hlY2tvdXQKIAkJCS0tYmFyZQotLSAKMi41LjAKCg==


--=-k/8+xOSEKofVN3JanVLE--

--=-a+zxBCB7WP7GnpSE/Wth
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJWy3bdAAoJEKDo88AkCQ1mMKAP/RPkhnKCpom2UngQcyx0C2IW
uMQNquyHwKa5KUERj3/zdrXVDBds715iEUrrYHp3ijg5REgBtQIMtYgQzvnuSmep
ZuWpqlW6v7DREIi+/y+ZUlcl7tVWPBmQKacVGII6QWHlSX2T/ESsvdZjfRQUvr/u
oOWNyruQByTaNCj+BStwVgL369NjatqPHOfi4wGWD8c3gANFug9opZH8FXWJcKL8
gNDkul5RclKim5vrOWDLaarTIQiSx0KEga34+DuyUg5we3jdSzHnjqjE0gQaV14D
ZRms4niaP2hM4AWYX4oV85G+pLN6yk2mzxUAuiMCR7/HTi8cq4p95LKI5oIC6cHd
0TYkoSiu/g2DrecrPUSp+OR5AVYYtq2SNAFzvKnQSUuqYBeYXdeCHwwliFWD9mF3
BIH/5bt1JWsi7czUis4zJqb1aquLR6Mhnuifm3k797p7ig8tuBqMEuXFndAf75KC
kQZ5qOlEW1cvaHfR2qz5pwMnWQ+PKmBvVJfimOZ1j462f0OhYfxfNvQaGRYtb0Kg
zOALmtOjnnekPfr4OPU8l4/mWvqFS95RWQ5vRFUQxO/kaGUL0USF5pCY7flKb9oh
0Nbm/cBCPfa24qhhhdqM6qg0Hh3prfYvqDBpLCtb/VNP7n6rMOs8gm7C68510KcU
IQkWcBZkcPQ5hsFHsop8
=NAq0
-----END PGP SIGNATURE-----

--=-a+zxBCB7WP7GnpSE/Wth--
