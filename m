From: Simon Arlott <simon@arlott.org>
Subject: git.kernel.org disconnects when git-1.3.3 tries to pull changes
Date: Tue, 24 Oct 2006 01:03:10 +0100
Message-ID: <453D583E.3010601@simon.arlott.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="------------enig609489218A2FF108540DAF7D"
X-From: git-owner@vger.kernel.org Tue Oct 24 02:03:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc9lQ-00087b-Up
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 02:03:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbWJXADZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 20:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbWJXADZ
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 20:03:25 -0400
Received: from blackhole.arlott.org.uk ([84.92.75.21]:16334 "EHLO
	blackhole.arlott.org.uk") by vger.kernel.org with ESMTP
	id S932345AbWJXADZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Oct 2006 20:03:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=exim; d=arlott.org;
	h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:X-Enigmail-Version:OpenPGP:Content-Type;
	b=KHqHFXn6KiM85IzD2IMqkM2qsCmbt914SGfaWc7rU5X+LM+IRoOfILfBzCdUpFaRh7LO9Z5p+lHY5yOFs0cZB1Gvh3k0kffZj7wP/ojzdOmjDu24FcwfwgeVedBRRGpc;
Received: from redrum.lp0.eu ([2001:4bd0:1000:0:202:44ff:fe50:91af]:44590 ident=byte)
	by blackhole.arlott.org.uk with esmtps (TLSv1:AES256-SHA:256)
	id 1Gc9lJ-0005Cm-6f
	for git@vger.kernel.org; Tue, 24 Oct 2006 01:03:22 +0100
User-Agent: Thunderbird 1.5.0.5 (X11/20060819)
To: git@vger.kernel.org
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=89C93563
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29904>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig609489218A2FF108540DAF7D
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

$ git --version
git version 1.3.3

$ git pull
fatal: unexpected EOF
Fetch failure: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/lin=
ux-2.6.git/

[pid 14283] write(3, "0046git-upload-pack /pub/scm/linux/kernel/git/torva=
lds/linux-2.6.git/\n", 70) =3D 70

$ nc -vv git.kernel.org git
DNS fwd/rev mismatch: zeus-pub.kernel.org !=3D zeus-pub1.kernel.org
DNS fwd/rev mismatch: zeus-pub.kernel.org !=3D zeus-pub2.kernel.org
zeus-pub.kernel.org [204.152.191.5] 9418 (git) open
0046git-upload-pack /pub/scm/linux/kernel/git/torvalds/linux-2.6.git/
 sent 70, rcvd 0
$

<pasky> the difference seems to be just that newer git version sends a ho=
st information
<pasky> anyway, this isn't supposed to happen
<pasky> could you mail the mailing list, please?

--=20
Simon Arlott


--------------enig609489218A2FF108540DAF7D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iQIVAwUBRT1YRqRtx1WjQ8ihAQo05A/+JaS79rsOKkVVR6EjMuDEjb+TFD2CH3iR
Hb+6X47O1bGxmhBej1vbqkrusuW8f0Q987FgpBF51yi6TjfUYXpi3aAMlH4jurNB
3eLeYa9cPIEz8Qshj+f831TXgqQg45cYRcqkbIsNXHH769ujiq4s1piAmyvrHLgq
viwZA5NLlHCJTvK6zw31kqVamVLnd/DoGzOLxyFr9QBrmntrstm+VSMiuBn2RiP8
Rr9kQWjUg1K7pyhKqbJfH3Q9kZ5vLN1xvRlB2+8Z1gy+DgYUHqOF8q/M3QXft/jp
qSkPEUHo1IF5Mrip/2CJY9vD5Z2/tv1sJY0DHBIlPBorAfDrneUe+Jgk6AvvweMG
YhZKO4+GtR/lO8m+/Ghk3pODCZpxXRirNybOop8PSzlc8b/jSXX/lELT7FSKhzVK
pPjlEJP7bO29ysb3H0N1gE64vl15L7JVB/80vP3as6LiVTxzr1dLjDyM4nPwXpBr
QWEueT4APvp6ECp5b5bLX8qJ/CjT1uczFfpf+WmB0ejQQ0IW67eP9/3o7OiEDlpD
YGYoVhJxYawOjchVALeDUs1upSWHxsvDGaxGd+ZspMzKzyKn1mGSBKDMYCp2Hsuu
w5JW4HvPGJG+BFAo2z24dhwRQDxeDo1xhNXXOG1rm/D73Je5x605KUVFguQbDDWv
Uz5bJWAl0Fg=
=Z1KD
-----END PGP SIGNATURE-----

--------------enig609489218A2FF108540DAF7D--
