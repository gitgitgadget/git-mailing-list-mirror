From: Pirate Praveen <praveen@debian.org>
Subject: support git+mosh for unreliable connections
Date: Wed, 15 Apr 2015 18:37:24 +0530
Message-ID: <552E628C.7040809@debian.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6sV6S5VTKX8ieLephaCx169UJhoesrKT1"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 15 15:36:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiNUn-00046t-Qx
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 15:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754139AbbDONgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2015 09:36:45 -0400
Received: from latitanza.investici.org ([82.94.249.234]:59162 "EHLO
	latitanza.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752593AbbDONgo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2015 09:36:44 -0400
X-Greylist: delayed 1749 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Apr 2015 09:36:44 EDT
Received: from [82.94.249.234] (latitanza [82.94.249.234]) (Authenticated sender: praveen@autistici.org) by localhost (Postfix) with ESMTPSA id 6EEAE122557
	for <git@vger.kernel.org>; Wed, 15 Apr 2015 13:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=debian.org;
	s=stigmate; t=1429103252;
	bh=1M3+Vlx6oU/Fygwjw9J5/tu9QXToj3OLdqHQETi5eqs=;
	h=Date:From:To:Subject;
	b=Et0pkJtaAQwUSwBwVlAZtxfvcsaKyjFGXowqj59aSEVGKN28kiOLsrfmYsCHlOBLR
	 pagb7/UwtQQ7MGc42o2figrwutvBUt5bTBdCYKhut10XvZHD9BkbEV4aymzZGjH8bs
	 QDJqtq+uNIgESSeGH5yWvcaqHev3hxjuwtzyUCWQ=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267197>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6sV6S5VTKX8ieLephaCx169UJhoesrKT1
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

 When working with big projects over a slow, unreliable connection,
currently there is no way to resume a clone or pull when the connection
breaks. mosh is a better replacement for ssh over unreliable
connections. supporting git+mosh protocol will go a long way in
supporting people who work with unreliable, mobile networks, especially
in developed countries (I personally have to try many times when working
with large projects as my 3g mobile connection keeps dropping. I
recently discovered mosh and it works like a charm. More about mosh
https://mosh.mit.edu/

Thanks
Praveen


--6sV6S5VTKX8ieLephaCx169UJhoesrKT1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCAAGBQJVLmKMAAoJEM4fnGdFEsIqGZkP/jYZ4tILIdNn5Zp0WV201fN7
tmRuf5q+vpfvlbpewpLFrCXQQnnEUp19UpPC760h+TT0sHSgioMmWknrps4LubH3
pZxtj+s1YrIalEnoEWPl5S5JM9ZQbURRugx7v6oiLq6Z7CiYTZevKdoKsYhQklev
dZq1zNw1gVrGzEHRKmAXnb3naEimEwRXkLArChBUxr+yqO3aGmmnfp5WRpXL9mtS
yYWlullHs7B5RZQKCf61i5pJZfHXF6Rf6ILJWs54xsi3cZ0dDPdsTOF5Iyw13r3I
KPYCBXBlRKm5PuSnF5kE4sIPN5fDLAdYmXDGFnLyk5pcbZy0AGNze0pOmLY3HCDk
iPIQbtg85rPkxCt1KDAkoaIqlM0iTIll8Pca76uKwnCCV77F+QWOkg1ISuSaqFek
jw9SfHrCbLubhby6X7MbK60cOsK0PPd1u5xh2zi8+t4ZerdWJW8+kgqP9s0YBc4c
1mVq+pE0r9GyetwuZuEOxKH5Sgwndnzl5x54TAuxIPYGxhkQ1va6UrdzGJfBXVxK
YOhuOcLhmgMM45QGVwT8poOllRnODLjsunivpafNa8hQkI+puDbhmOZcyF8l+VDV
/2wItujsHDTL2fZU7ubw85QFZA+LBBeeWC5yk2/R3/4yO4Lr9xP3BeJIG5pYht2w
vaYjr7Ottmo7CfYq0dDT
=23IG
-----END PGP SIGNATURE-----

--6sV6S5VTKX8ieLephaCx169UJhoesrKT1--
