From: Erik Mouw <mouw@nl.linux.org>
Subject: Git string manipulation functions wrong?
Date: Mon, 21 May 2007 15:11:03 +0200
Organization: Eric Conspiracy Secret Labs
Message-ID: <20070521131103.GN8200@gateway.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4IYkFBVPN84tP7K"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 21 15:24:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq7rt-0008RI-9h
	for gcvg-git@gmane.org; Mon, 21 May 2007 15:24:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755110AbXEUNYF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 09:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755334AbXEUNYF
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 09:24:05 -0400
Received: from smtp-vbr3.xs4all.nl ([194.109.24.23]:3159 "EHLO
	smtp-vbr3.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755110AbXEUNYE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 09:24:04 -0400
X-Greylist: delayed 764 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 May 2007 09:24:04 EDT
Received: from gateway.home (a82-92-155-199.adsl.xs4all.nl [82.92.155.199])
	by smtp-vbr3.xs4all.nl (8.13.8/8.13.8) with ESMTP id l4LDB4PA053023
	for <git@vger.kernel.org>; Mon, 21 May 2007 15:11:17 +0200 (CEST)
	(envelope-from mouw@nl.linux.org)
Received: from erik by gateway.home with local (Exim 3.36 #1 (Debian))
	id 1Hq7fE-0003dn-00
	for <git@vger.kernel.org>; Mon, 21 May 2007 15:11:04 +0200
Content-Disposition: inline
X-Eric-Conspiracy: There is no conspiracy!
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48018>


--T4IYkFBVPN84tP7K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I got this forwarded from a friend who is subscribed to the Dovecot
mailing lists (dovecot is a pop3/imap server).

  http://www.dovecot.org/list/dovecot/2007-May/022853.html
  http://www.dovecot.org/list/dovecot/2007-May/022856.html

The Dovecot author claims there are "basic string manipulation errors"
in the git code and that's a reason for him not to use git.

I can see his problem with *snprintf() functions in the case where the
amount of output is larger than the buffer size: *snprintf() will
return the number of characters written if there would have been enough
space to write them, which will lead to problems with code like "len +=3D
snprintf(buf, max, bla, ...)". I don't see his problems with strncpy(),
though.


Erik

--=20
They're all fools. Don't worry. Darwin may be slow, but he'll
eventually get them. -- Matthew Lammers in alt.sysadmin.recovery

--T4IYkFBVPN84tP7K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGUZpn/PlVHJtIto0RAnu3AJ0b3j6E5JBSoV28ihwi1GZH25GgsACfbKKh
YdjxQ6zPmXkbjbeEBXFz094=
=+S9D
-----END PGP SIGNATURE-----

--T4IYkFBVPN84tP7K--
