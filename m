From: =?UTF-8?B?TWF0xJtqIENlcGw=?= <mcepl@redhat.com>
Subject: git-svn troubles with calendarserver SVN repo
Date: Sat, 30 Nov 2013 00:14:40 +0100
Message-ID: <52991FE0.6040503@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="rCjbcJfSxp1FNXS5FKFLfnUPcrE7ss9wQ"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 30 00:14:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VmXGo-0002ai-Bu
	for gcvg-git-2@plane.gmane.org; Sat, 30 Nov 2013 00:14:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771Ab3K2XOm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Nov 2013 18:14:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:26297 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750953Ab3K2XOm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Nov 2013 18:14:42 -0500
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id rATNEfmW015222
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Fri, 29 Nov 2013 18:14:42 -0500
Received: from wycliff.ceplovi.cz (ovpn-116-30.ams2.redhat.com [10.36.116.30])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id rATNEfw0004075
	for <git@vger.kernel.org>; Fri, 29 Nov 2013 18:14:41 -0500
Received: from wycliff.ceplovi.cz (wycliff.ceplovi.cz [127.0.0.1])
	by wycliff.ceplovi.cz (Postfix) with ESMTP id C45E444B80
	for <git@vger.kernel.org>; Sat, 30 Nov 2013 00:14:40 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:27.0) Gecko/20100101 Thunderbird/27.0a2
X-Enigmail-Version: 1.6
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238543>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rCjbcJfSxp1FNXS5FKFLfnUPcrE7ss9wQ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,



I am trying to git-svn clone
https://svn.calendarserver.org/repository/calendarserver/CalendarServer/
and I cannot say I am much succesful. Every couple of hundred of commits
I get this:


RA layer request failed: REPORT of
'/repository/calendarserver/!svn/vcc/default': could not connect to
server (https://svn.calendarserver.org) at
/usr/local/share/perl5/Git/SVN/Ra.pm line 290.


and git-svn stops. When restarting git svn fetch, it fetches
another couple of hundred commits and then fails again. Given
that there are 11000+ commits just in the trunk, I am afraid of
a long long night. Did anybody managed to clone this repo? Or is
there some way how to make git-svn more patient (this error
means the SVN server is a bit flakey, right)?

Best,

Mat=C4=9Bj
--=20
http://www.ceplovi.cz/matej/, Jabber: mcepl@ceplovi.cz
GPG Finger: 89EF 4BC6 288A BF43 1BAB  25C3 E09F EF25 D964 84AC

A day without sunshine is like night.


--rCjbcJfSxp1FNXS5FKFLfnUPcrE7ss9wQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iD8DBQFSmR/g4J/vJdlkhKwRAtmcAKCBHjFaSyY5iq/bUPLxsmX2gQl6yQCdEBno
Ah6RQ0gkJFUZvxpURkM3XXE=
=L+4D
-----END PGP SIGNATURE-----

--rCjbcJfSxp1FNXS5FKFLfnUPcrE7ss9wQ--
