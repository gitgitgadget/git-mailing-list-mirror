From: Lisandro =?utf-8?q?Dami=C3=A1n_Nicanor_P=C3=A9rez_Meyer?= 
	<perezmeyer@gmail.com>
Subject: Re: [wishlist] support git flow-like view
Date: Wed, 21 Nov 2012 13:43:41 -0300
Message-ID: <201211211343.42187.perezmeyer@gmail.com>
References: <201211202043.00293.perezmeyer@gmail.com> <201211202113.44459.perezmeyer@gmail.com> <50ACEA95.9020909@ira.uka.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4672067.q8ScDnOixy";
  protocol="application/pgp-signature";
  micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
Cc: Andrew Ardill <andrew.ardill@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Holger Hellmuth (IKS)" <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Nov 21 17:44:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbDP8-0005OV-LY
	for gcvg-git-2@plane.gmane.org; Wed, 21 Nov 2012 17:44:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755288Ab2KUQns (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2012 11:43:48 -0500
Received: from mail-gh0-f174.google.com ([209.85.160.174]:58355 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753965Ab2KUQnr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2012 11:43:47 -0500
Received: by mail-gh0-f174.google.com with SMTP id g15so712554ghb.19
        for <git@vger.kernel.org>; Wed, 21 Nov 2012 08:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:x-face
         :mime-version:content-type:content-transfer-encoding:message-id;
        bh=JVWccTq2QJl7JjdPu0AQ6j1yOqap4m10NeWjDY273MU=;
        b=re5swVfQXVJ39xpaNzgy4zVuNF8gixWhB2Oe9+F9zKFspyktUCblXP2S13W5PEOl49
         cbS/OE7LXGRlDepM8qhm64szBH/Dkah9H7Vd6UwQ7MIEw19BaBynJJcWRxlUQ0qWhnFd
         yBSIe68sR4pHW54iuUh8W5Z7PgsAUHEoEmKUpDc0e5sGuDkAXFbqR0ttPYezVHQi6f1T
         fFg5Z7bgqYLCUCOMSRhAhXy0wMPOjO8Lkr+fGgy1CmmV+eGPVmECeZOYyEJB41oetcFD
         h86Mm09ADychvZ1f9pxxWgaDyyVtppgcio+69TYGZB5ta5Cji+YeV6A1+n+z4s3HbDL2
         V8yg==
Received: by 10.101.134.15 with SMTP id l15mr5440918ann.46.1353516226569;
        Wed, 21 Nov 2012 08:43:46 -0800 (PST)
Received: from tonks.localnet (diec-out.uns.edu.ar. [200.49.237.230])
        by mx.google.com with ESMTPS id e18sm622111yhi.0.2012.11.21.08.43.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 21 Nov 2012 08:43:45 -0800 (PST)
User-Agent: KMail/1.13.7 (Linux/3.0.0-1-amd64; KDE/4.8.5; x86_64; ; )
In-Reply-To: <50ACEA95.9020909@ira.uka.de>
X-Face: &O7POA^t$8Gq0El|^zM9V:*jgn,ETU\1A73;Zdeojd,G(a";/Y0Fu|/*_jQF+@3';#.O@
 =?utf-8?q?=26=0A=09=2ET?="FaLh+5o_F,\lrKg~{JYYVM20<P[J.ve7:7m;51A=i@"XBI].=`ZFX4h@tGL>
 =?utf-8?q?Q1I=26fUN=0A=094?=<\TGcR5=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210152>

--nextPart4672067.q8ScDnOixy
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed 21 Nov 2012 11:52:05 Holger Hellmuth (IKS) escribi=C3=B3:
> Am 21.11.2012 01:13, schrieb Lisandro Dami=C3=A1n Nicanor P=C3=A9rez Meye=
r:
> > Well, two ideas come to my mind:
> >=20
> > - detect when using git flow (.git/config contains [gitflow
> > "some_branch"] entries).
>=20
> Shouldn't it be part of the gitflow package then?
>=20
> > - Show "swim-lane"-like graphs, including branches that may not be
> > present, but where there (release branches often are created and merged
> > back, for example)
>=20
> As a general feature there could be a config option gitk reads with an
> ordered list of branch names (with wildcards). Those branches would
> always be printed in gitk as the leftmost branches (i.e. have their own
> lane on the left side). All other branches would be shown normally.
>=20
> This would give you part of what you want, a special lane at least for
> master and develop and for branches you can group under wildcard branch
> names (for example if you prefix all release branches with "rel-").
>=20
> And it would give others the ability to make special branches in gitk
> more visible.
>=20
> (Yes I know, I'm talking again of stuff I won't have time or ability to
> implement ;-). Sigh)

That seems an interesting idea, indeed. Thanks!

=2D-=20
Either he's dead or my watch has stopped.
 -- Groucho Marx

Lisandro Dami=C3=A1n Nicanor P=C3=A9rez Meyer
http://perezmeyer.com.ar/
http://perezmeyer.blogspot.com/

--nextPart4672067.q8ScDnOixy
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCAAGBQJQrQS+AAoJEKtkX0BihqfQe6oP/jUHMqC38h+PFcCcqIPrHu/x
f64/Xk5oSiOxH5MBhdYI7tfZrZ2GnGFt+Uh3iyIAK3yuFFvy+6FxhzLVRdRu1QBT
hT/UzAVCJ17lxjtZJRhb5h0MxWkXLEphm7Yz5ifx/ec9mctQ3KAXdoxIK+ciHDae
BRC0edLxQdLgJf/uhk1MwFZWDSLUU+zJfOf22m4dm/0LYNpg6z90ZRQ8l4FVdOXO
95A8X+GXzzmttEVbM+PLwwhfmvQoIZ4ATEUtX4NPqd8W9vEDFExExm38QCzAL40N
sMevhUJ7mhdOYEJN7f4yN2UvxkN74VhE/pA+krkA/CtLpawz83ptTIkD82oAOhaA
1ez+STQe6LKm/NbQAVIzarYKWW3Cu9yfJ0/lUZ0Lk7m8kYban5Hi2q0zSPuECAUR
ZaxpbY6dEMd/qb5e3op6FiYxidtO6v1EqW6Fq6JAly+eJ/aVh4uYfcI/4lSQk8ZZ
G7IxzbMgjHYAtPfBKybaNohoO/iFwQu1eYEY77EL6yZvDxjuH+Fm6dKBFpFXLZZe
iDT4RqLz8Ftrik+irLuK/R8K7erxLBISPJw3z7Weqo9mDgk+MOye4xNxzrQk3/sy
QyudZ9uMdUW/4ldNW7PqkmO3rIDjMI+/jOadts62z/FFndu1NdPk/nm6vOvqeYzH
GeEtfi+tsxLOtwVxCzIp
=5mRR
-----END PGP SIGNATURE-----

--nextPart4672067.q8ScDnOixy--
