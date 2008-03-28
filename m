From: "Stefan (metze) Metzmacher" <metze@samba.org>
Subject: git rebase with working tree changes
Date: Fri, 28 Mar 2008 09:36:09 +0100
Message-ID: <47ECADF9.7020207@samba.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig95AE7A5B04DA47145C44911B"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 28 10:00:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfARs-0000z3-KG
	for gcvg-git-2@gmane.org; Fri, 28 Mar 2008 10:00:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754047AbYC1I7u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2008 04:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754041AbYC1I7t
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Mar 2008 04:59:49 -0400
Received: from ip-217-172-181-76.mx-netz.de ([217.172.181.76]:59004 "EHLO
	mail.mx-netz.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753896AbYC1I7q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2008 04:59:46 -0400
X-Greylist: delayed 1382 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Mar 2008 04:59:46 EDT
Received: from [172.30.76.9] (unknown [172.30.76.9])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	(SASL METHOD:[PLAIN] USERNAME:[metze])
	by mail.mx-netz.de (SMTP-MAIL-SERVER) with ESMTP id 6DC9520C54C
	for <git@vger.kernel.org>; Fri, 28 Mar 2008 09:36:39 +0100 (CET)
User-Agent: Thunderbird 1.5.0.14 (X11/20060911)
X-Enigmail-Version: 0.94.4.0
OpenPGP: id=0E53083F
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78393>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig95AE7A5B04DA47145C44911B
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

it's a bit painful to always manually wrap
'git rebase' into 'git stash' and 'git stash apply'.

'git merge' does this on its own, would it
be possible to do the same with 'git rebase (-i)'?

This would unify the behavior of
'git pull' and 'git pull --rebase'.

Comments are welcome.

metze


--------------enig95AE7A5B04DA47145C44911B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFH7K4Hm70gjA5TCD8RAgqoAKC9vJR3s2y51hkQjyQu7D83FswWDACgl3s0
vxx7G40jvG9PPYZimXawAhk=
=tWqQ
-----END PGP SIGNATURE-----

--------------enig95AE7A5B04DA47145C44911B--
