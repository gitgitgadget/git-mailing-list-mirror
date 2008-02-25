From: "Alxneit-Kamber Ivo" <ivo.alxneit@psi.ch>
Subject: Re: unexpected behavior of 'git rebase'
Date: Mon, 25 Feb 2008 09:37:16 +0100
Message-ID: <1203928636.29205.2.camel@pc6411.psi.ch>
References: <1203693047.6429.11.camel@pc6411.psi.ch> <m3ejb3dejg.fsf@localhost.localdomain>
Reply-To: "Alxneit-Kamber Ivo" <ivo.alxneit@psi.ch>
Mime-Version: 1.0
Content-Type: multipart/signed;
	boundary="=-uf9CLnBKZHtIzwgjOLqU";
	protocol="application/pgp-signature";
	micalg=pgp-sha1
Cc: <git@vger.kernel.org>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 09:37:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTYqS-0001MS-Ge
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 09:37:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753792AbYBYIhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 03:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753809AbYBYIhU
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 03:37:20 -0500
Received: from mailsend02.psi.ch ([129.129.191.54]:20140 "EHLO
	MAILSEND02.psi.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752997AbYBYIhT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 03:37:19 -0500
Received: from MAILBOX0A.psi.ch ([129.129.190.193]) by MAILSEND02.psi.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 25 Feb 2008 09:37:17 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Received: from 129.129.206.141 ([129.129.206.141]) by MAILBOX0A.psi.ch ([129.129.190.181]) via Exchange Front-End Server mail.psi.ch ([129.129.191.53]) with Microsoft Exchange Server HTTP-DAV ; Mon, 25 Feb 2008 08:37:16 +0000
Received: from pc6411 by mail.psi.ch; 25 Feb 2008 09:37:16 +0100
Content-class: urn:content-classes:message
In-Reply-To: <m3ejb3dejg.fsf@localhost.localdomain>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: unexpected behavior of 'git rebase'
thread-index: Ach3iaCCv/ln1yNsQemnniBe7eRmQw==
X-OriginalArrivalTime: 25 Feb 2008 08:37:17.0355 (UTC) FILETIME=[A0E387B0:01C87789]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75013>


--=-uf9CLnBKZHtIzwgjOLqU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2008-02-23 at 04:48 -0800, Jakub Narebski wrote:
> "Alxneit-Kamber Ivo" <ivo.alxneit@psi.ch> writes:
>=20
> > I found that 'git rebase' does not include stashed stuff.
>=20
> This, I think, is caused mainly by the fact that stash is currently
> global per repository, and not per-branch thing.
>=20
> You can always rebase stash on top of after-rebase branch.
>=20

ok, thanks. so it sounds like an intended behavior (maybe the
documentation should mention this explicitly).

moving the stashed stuff to the correct place and removing the
left-behind unnamed brach is no problem.

--=20
Dr. Ivo Alxneit
Laboratory for Solar Technology   phone: +41 56 310 4092
Paul Scherrer Institute             fax: +41 56 310 2688
CH-5232 Villigen                   http://solar.web.psi.ch
Switzerland                   gnupg key: 0x515E30C7

--=-uf9CLnBKZHtIzwgjOLqU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBHwn48Ad7CE1FeMMcRAhLqAJ9j8dZ1TwFIz2TTqZIP+Wij2anZnwCgnWpX
zv3llqvTOZyUBn9ZSs6JHBg=
=05vp
-----END PGP SIGNATURE-----

--=-uf9CLnBKZHtIzwgjOLqU--
