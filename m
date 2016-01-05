From: Jacek Wielemborek <d33tah@gmail.com>
Subject: Segmentation fault found while fuzzing .pack file under 2.7.0.rc3
Date: Tue, 5 Jan 2016 14:44:49 +0100
Message-ID: <568BC8D1.3080201@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="R6q1CHV0mLJm6IWoCkIWFRMERtD8Dj5n0"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 05 14:45:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGRv6-0000BU-4Z
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 14:45:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752372AbcAENo7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2016 08:44:59 -0500
Received: from mail-lb0-f195.google.com ([209.85.217.195]:36369 "EHLO
	mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983AbcAENo5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2016 08:44:57 -0500
Received: by mail-lb0-f195.google.com with SMTP id ti8so18760822lbb.3
        for <git@vger.kernel.org>; Tue, 05 Jan 2016 05:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=to:from:subject:message-id:date:mime-version:content-type;
        bh=CxXxE7aUyvjcMUWZyyhisKNr8qHm1v05gMiBWlmm3UI=;
        b=b5IINGHP3Rj5xgJ2thYGKUShvWtAHBHhsxhjZ6xEJeKEbOC5+95aNMvTrkHSY3wORb
         fthAkIPQ8Mf9CdhYTkpK5XEzuIMQ9bd7bppLe4iZv0bOEeyl7KuJ5F/OLfufiL8KG0ET
         lvVahM6Zf3qGzUtdoxyDU0kbUBvgkGs58HcB1ztSPeeNCTkyymsbzqPnSgVReZ+gseWk
         uV5OH4gj1pAkKPiOLnQ5j/9BRXF9aRoZ4OQrA8fAQKU5Fv8pBOWw7vu8BC1L56RuXMc0
         f20nTcvpg3F+GbbbCH0sbQ3XPGyOiQUeDN+zN7yBkIVQgPA6spMAWwvxfSXeQ/SJ5qlK
         keqA==
X-Received: by 10.112.16.231 with SMTP id j7mr13189810lbd.72.1452001495895;
        Tue, 05 Jan 2016 05:44:55 -0800 (PST)
Received: from [192.168.0.50] ([185.5.219.249])
        by smtp.googlemail.com with ESMTPSA id zu7sm6257839lbb.36.2016.01.05.05.44.54
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 05 Jan 2016 05:44:54 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283377>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--R6q1CHV0mLJm6IWoCkIWFRMERtD8Dj5n0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

Steps to reproduce:

1. base64 -d and unpack the .tar.gz file from here:
https://gist.github.com/d33tah/4e976f2e043718594a85

2. cd into it, run "git log"

I'll be happy to guide you through the fuzzing process - I stopped it at
the first crash.

Cheers,
d33tah


--R6q1CHV0mLJm6IWoCkIWFRMERtD8Dj5n0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWi8jRAAoJEGlViymZXJRvFm4P/0hexlcWFsNyWgrh1gtW4THC
YJrv/ImsEcQgQKdEk3K6CnI8dx62TUq+tUbJnOGaZvP3fxG6dgJDvIU4uKzwUvGV
Q8gEni7+vkZgLK8GZ5eaf49YcOXEgAnZwiQRwzzuIIVsfPQWPX8VeUyDM5o1wXKy
vT7DMG5lhX1GuWf6UoP8WETUxbHaXXx0gxgbhWVf1cnN232xfqVZsEdylmNZsdmg
FARTSND1Dxn8pHeb+co6lzS1sFYaLIOiKy+qaWC7Ivk+fMWZ4Cqx8azvg3a2U4wJ
jShM/oL1mSOHLoBkfIEIjq17tKFRx3fOUVcctZpZiqEq9FNjlVaV1HmZoZfAoNp4
KHO6+/j7SYaEMFAty8xmnGshBouMVPdqQ4dr6cprtzIKKCiKdEZ7mYYKaJXv0ace
poqiePTEl3ArBJXEXrRl7XrtR+GM0vUqWZbYHGVFe/BolAcPtBMkO9pJbMUORW7H
Djlnf1/YUFpqNXCpurDAuBDKDcrh7PUmpQ5vYLYGUwFQobc27XevfUCDtalvSyRW
yHBQvZvIa1AwQO+5BEHmm3Me1yF5aZzEpzcdj7dAayO8dhFGjq1Xrn3lBhgLVJxW
bCzpOqw6W6UUICjdVyWi9dY0nXSfij9WDP63L6IO2nVIe7uiV4RE/Yr1xkEA7o44
VM1P3V1n6d/1Gd4qVmsq
=69Zc
-----END PGP SIGNATURE-----

--R6q1CHV0mLJm6IWoCkIWFRMERtD8Dj5n0--
