From: Jelmer Vernooij <jelmer@samba.org>
Subject: Re: VCS comparison table
Date: Mon, 23 Oct 2006 20:56:41 +0200
Organization: Samba Team
Message-ID: <1161629801.27312.22.camel@charis.lan.vernstok.nl>
References: <45357CC3.4040507@utoronto.ca>
	 <200610232021.55625.jnareb@gmail.com>
	 <1161628001.27312.8.camel@charis.lan.vernstok.nl>
	 <200610232031.12399.jnareb@gmail.com>
	 <Pine.LNX.4.64.0610231134450.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-XVJiKPoMbtobrpSg2huf"
Cc: Jakub Narebski <jnareb@gmail.com>,
	James Henstridge <james@jamesh.id.au>,
	bazaar-ng@lists.canonical.com,
	"Matthew D. Fuller" <fullermd@over-yonder.net>,
	Andreas Ericsson <ae@op5.se>, Carl Worth <cworth@cworth.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 20:57:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc4zA-0000uY-Dw
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 20:57:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965040AbWJWS5Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 14:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965043AbWJWS5Q
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 14:57:16 -0400
Received: from smtp-vbr9.xs4all.nl ([194.109.24.29]:4366 "EHLO
	smtp-vbr9.xs4all.nl") by vger.kernel.org with ESMTP id S965040AbWJWS5P
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Oct 2006 14:57:15 -0400
Received: from rhonwyn.vernstok.nl (a62-251-123-16.adsl.xs4all.nl [62.251.123.16])
	by smtp-vbr9.xs4all.nl (8.13.8/8.13.8) with ESMTP id k9NIv4FT066294;
	Mon, 23 Oct 2006 20:57:05 +0200 (CEST)
	(envelope-from jelmer@samba.org)
Received: from localhost (localhost [127.0.0.1])
	by rhonwyn.vernstok.nl (Postfix) with ESMTP id 3024139A3C1;
	Mon, 23 Oct 2006 20:56:56 +0200 (CEST)
Received: from rhonwyn.vernstok.nl ([127.0.0.1])
	by localhost (rhonwyn.vernstok.nl [127.0.0.1]) (amavisd-new, port 10024)
	with SMTP id 29184-04; Mon, 23 Oct 2006 20:56:34 +0200 (CEST)
Received: from charis.vernstok.nl (charis.vernstok.nl [IPv6:2001:7b8:37b:1:210:dcff:fecb:a9e3])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by rhonwyn.vernstok.nl (Postfix) with ESMTP id DAF2D39A3B8;
	Mon, 23 Oct 2006 20:56:33 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610231134450.3962@g5.osdl.org>
X-Mailer: Evolution 2.6.3 
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29861>


--=-XVJiKPoMbtobrpSg2huf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-10-23 at 11:45 -0700, Linus Torvalds wrote:
> On Mon, 23 Oct 2006, Jakub Narebski wrote:
> > The place for timestamp and commiter info is in the revision metadata
> > (in commit object in git). Not in revision id. Unless you think that
> > "accidentally the same" doesn't happen...
> Well, git and bzr really do share the same "stable" revision naming,=20
> although in git it's more indirect, and thus "covers" more.
>=20
> In git, the revision name indirectly includes the commit comments too (an=
d=20
> git obviously also distinguishes between "committer" and "author", and=20
> those end up being indirectly credited in the name of the commit too). Bu=
t=20
> in a very real sense, the bzr stable ("real") revision name does=20
> effectively contain the same things as a git ID: it's just that it's a=20
> small subset (only committer+date+random number) of what git includes in=20
> its names.
There are no requirements on what a revid is in bzr. It's a unique
identifier, nothing more. It can be whatever you like, as long as it's
unique for that specific commit. The committer+date+random\ number is
just what bzr uses at the moment to create those unique identifiers.

> So you could more easily _fake_ a commit name in bzr, and depending on ho=
w=20
> things are done it might be more open to malicious attacks for that reaso=
n=20
> (or unintentionally - if two people apply the exact same patch from an=20
> email, and take the author/date info from the email like hit does, you=20
> might have clashes. But with a 64-bit random number, that's probably=20
> unlikely, unless you also hit some other bad luck like having the=20
> pseudo-random sequence seeded by "time()", and people just _happen_ to=20
> apply the email at the exact same second).
Bzr stores a checksum of the commit separately from the revision id in
the metadata of a revision. The revision is not used by itself to check
the integrity of a revision.

Cheers,

Jelmer

--=20
Jelmer Vernooij <jelmer@samba.org> - http://samba.org/~jelmer/

--=-XVJiKPoMbtobrpSg2huf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFPRBpPa9Uoh7vUnYRAhSTAJ9WTc3ibICjFK0evybDl52hPU8hegCcCRdL
tti6FobrjilFTj+Uy9OCbfs=
=7wsu
-----END PGP SIGNATURE-----

--=-XVJiKPoMbtobrpSg2huf--
