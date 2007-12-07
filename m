From: "Alxneit-Kamber Ivo" <ivo.alxneit@psi.ch>
Subject: Re: [BUG/RFC git-gui] password for push/pull in case ofgit+ssh://repo
Date: Fri, 7 Dec 2007 09:57:43 +0100
Message-ID: <1197017863.4672.3.camel@pc446.psi.ch>
References: <1196951517.3294.24.camel@localhost.localdomain> <47582D5F.7070003@gmail.com>
Reply-To: "Alxneit-Kamber Ivo" <ivo.alxneit@psi.ch>
Mime-Version: 1.0
Content-Type: multipart/signed;
	micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-G7JWaW4pQCME2qd/s0uC"
Cc: <git@vger.kernel.org>
To: "Thomas Harning" <harningt@gmail.com>, "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 07 10:14:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0ZIB-0004DH-Ha
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 10:14:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518AbXLGJOH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 04:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbXLGJOG
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 04:14:06 -0500
Received: from mailsend02.psi.ch ([129.129.191.54]:36062 "EHLO
	MAILSEND02.psi.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224AbXLGJOE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 04:14:04 -0500
X-Greylist: delayed 977 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Dec 2007 04:14:04 EST
Received: from MAILBOX0A.psi.ch ([129.129.190.193]) by MAILSEND02.psi.ch with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 7 Dec 2007 09:57:44 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Received: from 129.129.206.99 ([129.129.206.99]) by MAILBOX0A.psi.ch ([129.129.190.181]) via Exchange Front-End Server mail.psi.ch ([129.129.191.54]) with Microsoft Exchange Server HTTP-DAV ; Fri,  7 Dec 2007 08:57:44 +0000
Received: from pc446 by mail.psi.ch; 07 Dec 2007 09:57:44 +0100
Content-class: urn:content-classes:message
In-Reply-To: <47582D5F.7070003@gmail.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [BUG/RFC git-gui] password for push/pull in case ofgit+ssh://repo
Thread-Index: Acg4rzsAINYebKusTPWfPbztntm8xA==
X-OriginalArrivalTime: 07 Dec 2007 08:57:44.0555 (UTC) FILETIME=[3B4F63B0:01C838AF]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67402>


--=-G7JWaW4pQCME2qd/s0uC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-12-06 at 12:11 -0500, Thomas Harning wrote:
> Ivo Alxneit wrote:
> > when i use git-gui (0.9.0) to push/pull to/from a git+ssh://repo i have
> > to supply my password to ssh. i get the password prompt from ssh on the
> > controlling shell. as i often use several shells and git-gui might run
> > in the background it is rather bothering to find the correct shell wher=
e
> > ssh expects the password. could this be changed (in a safe way) in
> > git-gui e.g. like pinentry pops up a window when gpg is used to sign
> > emails?
> >
> > p.s. please cc me. i have not subscribed to the list
> >
> > thanks
> >  =20
> I know this doesn't answer the problem exactly, but if you use ssh keys=20
> and some sort of key management utility (such as Keychain or maybe Gnome=20
> keyring?), you can dodge the password entry problem and never have to=20
> enter a password (pending you register your ssh key with the server [ex:=20
> ssh-copy-id servername])
>=20
>=20
> Another option that might answer your problem (and could be potentially=20
> integrated into git-gui) is the usage of the SSH_ASKPASS environment=20
> variable.
>=20
> SSH_ASKPASS is a program to execute to get the passphrase that works by=20
> reading console output from the program.

thanks to both of you.

in essence you are telling me to use the infrastructure provided by ssh
to ask fo the password. i'll try :-)
--=20
Dr. Ivo Alxneit
Laboratory for Solar Technology   phone: +41 56 310 4092
Paul Scherrer Institute             fax: +41 56 310 2688
CH-5232 Villigen                   http://solar.web.psi.ch
Switzerland                   gnupg key: 0x515E30C7

--=-G7JWaW4pQCME2qd/s0uC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBHWQsHAd7CE1FeMMcRAl2BAKCu4Yu4xnfp9AOH+IJafvnPVcdm9ACeKSlo
SxrEHqaedW2R+CU6covAQ/c=
=20L/
-----END PGP SIGNATURE-----

--=-G7JWaW4pQCME2qd/s0uC--
