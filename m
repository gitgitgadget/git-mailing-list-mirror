From: Jacek Wielemborek <d33tah@gmail.com>
Subject: git status --diffstat?
Date: Tue, 23 Jun 2015 21:30:13 +0200
Message-ID: <5589B3C5.7050504@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="t9LJJX5owtcrlH1pNhHwmQVKqFB6kplCF"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 23 21:30:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7Ttw-0007NE-Bx
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 21:30:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933231AbbFWTa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 15:30:28 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:36684 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933015AbbFWTa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 15:30:26 -0400
Received: by lbbpo10 with SMTP id po10so13135578lbb.3
        for <git@vger.kernel.org>; Tue, 23 Jun 2015 12:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:subject:content-type;
        bh=kuCS8cJwZayyYnZdknDk7R4ovc4hgvSHtHuSo2yU6GU=;
        b=BCgGCobEAn3sQBg+GpNGdZQnX1xC9cnCAk56gRIRqFdjerFG9dHnGZh90ULMhVuOLR
         0cY/nolxPCTWSEx5iFnk6cbKUndBCVUYkLgFhFzAOQsmbRhwtq/flU1JrRrCh336eRA8
         HtsVWhZueAvbJDsuNakx+Ntj3bRdrraQ1Cg+EGaiNcXHzK8y5m5oUKGdE6wS5xgakes7
         yKDV8EKe0O42uHgs6ad5CzqprI1s7RtmbSOuq0KsQqsC3JwADi6z+aERGFF4ji2ooaxO
         f7VKTqrI301alH6OCK1pKgT1jzLAm4vYA8BeYVclRKGdSYmgR8lDP0EiXRHCKEUGmMZe
         /upA==
X-Received: by 10.112.213.108 with SMTP id nr12mr36926215lbc.42.1435087824706;
        Tue, 23 Jun 2015 12:30:24 -0700 (PDT)
Received: from [172.16.1.2] (staticline-31-183-3-28.toya.net.pl. [31.183.3.28])
        by mx.google.com with ESMTPSA id tp10sm5755652lbb.4.2015.06.23.12.30.23
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jun 2015 12:30:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272487>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--t9LJJX5owtcrlH1pNhHwmQVKqFB6kplCF
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I recently realized that I could use a "git status" syntax like this:

On branch master
Your branch is up-to-date with 'origin/master'.
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working director=
y)

        modified:   macd.py     2 +-
        modified:   macd.wsgi     2 +-
        modified:   macd/admin.py     4 ++++
        modified:   macd/index.html     2 +-
        modified:   macd/models.py     7 +++++--
        modified:   macd/settings.py    27 +++++++++++++++++----------
        modified:   macd/urls.py     6 ++++++
        modified:   macd/views.py    27 +++++++++++++++++++--------

(...)

The idea is to add diffstats to git-status. I cooked up a Python script
to do that [1], but I'd like that to be default behavior on my box.
Someone suggested me to just implement it in C, but I'm not familiar
with the codebase, so it'd take me a while.

What do you think about this? Would anybody else find it useful and
perhaps consider implementing it?

Cheers,
d33tah


--t9LJJX5owtcrlH1pNhHwmQVKqFB6kplCF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVibPOAAoJEGlViymZXJRvPC4P/2gdSqH4tEZJIiAFfnXvCVHZ
iQfm9sC4hsP16xWAxU00XIs5Ugbbf9aVafK7kcW9BOkpgIPYuPwidsFSTB/sArIV
hczag1fssrQckKEA5WxK4R119msJ670NkXiwrrr4R3uEvAhmSwYXXlDHaMaGrQHU
2has4H7ymr4iQWp2wxRM5rxBgNMZ3AATEUrJzTYJb0ViefWW/CEPM6yMfeRXqszr
JaUMdh2EL5yW6Bz6GQ0xvzi0dgIEvbLhYanhqPq3AGfG5T5o+xLcELlWt1HbrFH1
Lq4u6B/y8EnhC2lX3NhMJbuNbndanqdl3uw+g34DpPXsZg/ptgKavXWAZ7WAOj2I
8Oq6ICAVcB1PhDSjEIW4M2s3ZkIttQZtFqU3h3rxVc8+pY27zY9EO0u56YntSwCF
VSC4EhVoj5GbC7hjASJ0GOxK3DWN9hi7bTkZ+4F80s8SWHGRrzbuXS4qysPpfQXg
4cdVm6hXBk0+ZP9GrPfjEBua3mUQObgiAijL6LYLlGZsinIMo9Ep8oq9ie6QMDPh
Y0MSGTzJSD2g6AuJnJR9NL98VThDrFt4BSr0ArWwxcWcsjOzhyq29tr6SDqSCvaM
91jpaWQcmA0+VkEkHdwlCnAxS/MkwiWfy6PyRHepmo/ZAsbSHwpmDiQjCsMUkxvO
UP8COctpdvAfV69pajPR
=j+ei
-----END PGP SIGNATURE-----

--t9LJJX5owtcrlH1pNhHwmQVKqFB6kplCF--
