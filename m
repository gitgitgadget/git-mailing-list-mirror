From: Jelmer Vernooij <jelmer@samba.org>
Subject: Re: VCS comparison table
Date: Mon, 23 Oct 2006 20:44:12 +0200
Organization: Samba Team
Message-ID: <1161629052.27312.13.camel@charis.lan.vernstok.nl>
References: <45357CC3.4040507@utoronto.ca>
	 <200610232021.55625.jnareb@gmail.com>
	 <1161628001.27312.8.camel@charis.lan.vernstok.nl>
	 <200610232031.12399.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-nZr6ccTmzerpnNZZaBeV"
Cc: Linus Torvalds <torvalds@osdl.org>,
	James Henstridge <james@jamesh.id.au>,
	bazaar-ng@lists.canonical.com,
	"Matthew D. Fuller" <fullermd@over-yonder.net>,
	Andreas Ericsson <ae@op5.se>, Carl Worth <cworth@cworth.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 20:45:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc4n2-0006D5-3Z
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 20:44:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965020AbWJWSoo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 14:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965021AbWJWSoo
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 14:44:44 -0400
Received: from smtp-vbr17.xs4all.nl ([194.109.24.37]:30225 "EHLO
	smtp-vbr17.xs4all.nl") by vger.kernel.org with ESMTP
	id S965020AbWJWSon (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Oct 2006 14:44:43 -0400
Received: from rhonwyn.vernstok.nl (a62-251-123-16.adsl.xs4all.nl [62.251.123.16])
	by smtp-vbr17.xs4all.nl (8.13.8/8.13.8) with ESMTP id k9NIiXiF013852;
	Mon, 23 Oct 2006 20:44:33 +0200 (CEST)
	(envelope-from jelmer@samba.org)
Received: from localhost (localhost [127.0.0.1])
	by rhonwyn.vernstok.nl (Postfix) with ESMTP id B402A39A3C1;
	Mon, 23 Oct 2006 20:44:24 +0200 (CEST)
Received: from rhonwyn.vernstok.nl ([127.0.0.1])
	by localhost (rhonwyn.vernstok.nl [127.0.0.1]) (amavisd-new, port 10024)
	with SMTP id 29184-01; Mon, 23 Oct 2006 20:44:05 +0200 (CEST)
Received: from charis.vernstok.nl (charis.vernstok.nl [IPv6:2001:7b8:37b:1:210:dcff:fecb:a9e3])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by rhonwyn.vernstok.nl (Postfix) with ESMTP id 4E05A39A3B8;
	Mon, 23 Oct 2006 20:44:05 +0200 (CEST)
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200610232031.12399.jnareb@gmail.com>
X-Mailer: Evolution 2.6.3 
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29858>


--=-nZr6ccTmzerpnNZZaBeV
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-10-23 at 20:31 +0200, Jakub Narebski wrote:
> Jelmer Vernooij wrote:
> >> By the way, I wonder if accidentally identical revisions
> >> (see example for accidental clean merge on revctrl.org)
> >> would get the same revision id in bzr. In git they would.
>=20
> > They won't. The revision id is made up of the committers email address,
> > a timestamp and a bunch of random data. It wouldn't be hard to switch
> > using checksums as revids instead, but I don't think there are any plan=
s
> > in that direction.
> The place for timestamp and commiter info is in the revision metadata
> (in commit object in git). Not in revision id. Unless you think that
> "accidentally the same" doesn't happen...
The revision id isn't parsed by bzr. It's just a unique identifier that
is generated at commit-time and is currently created by concatenating
those three fields. It can be anything you like. The bzr-svn plugin for
example creates revision ids in the form
svn:REVNUM@REPOS_UUID-BRANCHPATH and bzr-git uses git:GITREVID. Nothing
will break if bzr would start using a different format.

Cheers,

Jelmer

--=20
Jelmer Vernooij <jelmer@samba.org> - http://samba.org/~jelmer/

--=-nZr6ccTmzerpnNZZaBeV
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFPQ18Pa9Uoh7vUnYRAjvFAJ9h5S9rmNKQujp03i3If0a/Ywx30wCgjXmT
WIGoQy9KIILh198H+4I50ps=
=dhez
-----END PGP SIGNATURE-----

--=-nZr6ccTmzerpnNZZaBeV--
