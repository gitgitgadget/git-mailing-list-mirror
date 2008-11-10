From: Michal Nazarewicz <mina86@tlen.pl>
Subject: Something like $Id$, $Revision$ or $Date$?
Date: Mon, 10 Nov 2008 01:22:08 +0100
Message-ID: <87ljvsjuq7.fsf@erwin.mina86.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 10 01:23:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzKZ7-00044o-AD
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 01:23:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756321AbYKJAWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2008 19:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756497AbYKJAWW
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Nov 2008 19:22:22 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:20775 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756294AbYKJAWV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2008 19:22:21 -0500
Received: by ug-out-1314.google.com with SMTP id 39so258522ugf.37
        for <git@vger.kernel.org>; Sun, 09 Nov 2008 16:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:x-url
         :x-pgp-fp:x-pgp:date:message-id:user-agent:mime-version:content-type
         :sender;
        bh=E3FrWTbPgYtj5QJQRbnWWeKzw/uLMU2vYz6C5vaPsXM=;
        b=L9EN6EpHqs5P1bd32A4itepdvkk7A4NDN7dKAdSuAjjUTEaZkabtHO08RjUs/j4VUR
         IJMPzB010rslZhmx0SvmluA73D8cLkXV04KjJ2FsCFjeqF1S/vn5Wjb7R0iiwgDX8X8R
         qgcR+EHVdISr/qd1qjS8jFI3P/K8hx7WWwdqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:x-url:x-pgp-fp:x-pgp:date:message-id:user-agent
         :mime-version:content-type:sender;
        b=a6f9HYeNTnWbNnsaBD5eaxQkZKErLeL78r/BSCwDZFpeC+Pglpuw4TZQPC5YIqLvCR
         2peFv7MJxt7okSl01jKiK8VYC80F8MUmL4hoawWFBWXl53T1fkANqggw6QtVmtp8vNUT
         prhheXGwr2ZrA8livkZj1EgEEDL9P8HcZ9Klc=
Received: by 10.67.21.11 with SMTP id y11mr1622269ugi.6.1226276539152;
        Sun, 09 Nov 2008 16:22:19 -0800 (PST)
Received: from erwin.piotrekn (dng132.neoplus.adsl.tpnet.pl [83.24.88.132])
        by mx.google.com with ESMTPS id o7sm2932808uge.0.2008.11.09.16.22.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 09 Nov 2008 16:22:17 -0800 (PST)
X-Url: http://mina86.com/
X-PGP-FP: 9134 06FA 7AD8 D134 9D0C  C33F 532C CB00 B7C6 DF1E
X-PGP: B7C6DF1E
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.0 (Slckware Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100481>

--=-=-=
Content-Transfer-Encoding: quoted-printable

Hello,

as probably many of you know CVS supported some magic tags which were
replaced in committed files to a predefined value.  For instance, if
there was a "$Revision$" string in a file it would get replaced with
"$Revision: x.y $" (or "$Revision: x.y.z.w $" and so on) where "x.y" is
file's revision number.

Now, what I need is such feature in GIT.  Upon committing I would like
some magic string (say "$Date$") to be replaced with some value
identifying uniquely given version of a file (a date of the commit would
be sufficient).

I tried using some hooks for it but couldn't came up with anything that
would actually work.

=2D-=20
Best regards,                                         _     _
 .o. | Liege of Serenly Enlightened Majesty of      o' \,=3D./ `o
 ..o | Computer Science,  Michal "mina86" Nazarewicz   (o o)
 ooo +--<mina86*tlen.pl>--<jid:mina86*jabber.org>--ooO--(_)--Ooo--

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkkXfrcACgkQUyzLALfG3x5JhwCgquZB/NV1yagF5Un4iPR92KOk
PBkAniGbG6cic5vu+7pcce6iSQ9fC9sf
=dao+
-----END PGP SIGNATURE-----
--=-=-=--
