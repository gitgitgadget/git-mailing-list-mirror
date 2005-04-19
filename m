From: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: Re: Change "pull" to _only_ download, and "git update"=pull+merge?
Date: Tue, 19 Apr 2005 16:40:59 +0200
Message-ID: <1113921659.1262.8.camel@nosferatu.lan>
References: <20050416233305.GO19099@pasky.ji.cz>
	 <Pine.LNX.4.21.0504161951160.30848-100000@iabervon.org>
	 <20050419011206.GT5554@pasky.ji.cz> <42646967.9030903@dwheeler.com>
	 <4264CCFF.30400@dgreaves.com> <20050419092812.GE2393@pasky.ji.cz>
	 <1113905110.1262.1.camel@nosferatu.lan>
	 <20050419105008.GB12757@pasky.ji.cz>
Reply-To: azarah@nosferatu.za.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-EKOd6LwUPprqc4E6RVq0"
Content-Transfer-Encoding: 8bit
Cc: David Greaves <david@dgreaves.com>, dwheeler@dwheeler.com,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 16:37:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNtqN-0005tR-Kf
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 16:36:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVDSOk0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 10:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbVDSOkR
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 10:40:17 -0400
Received: from ctb-mesg3.saix.net ([196.25.240.75]:50580 "EHLO
	ctb-mesg3.saix.net") by vger.kernel.org with ESMTP id S261154AbVDSOh3
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2005 10:37:29 -0400
Received: from gateway.lan (wblv-146-254-56.telkomadsl.co.za [165.146.254.56])
	by ctb-mesg3.saix.net (Postfix) with ESMTP id 483543924;
	Tue, 19 Apr 2005 16:37:06 +0200 (SAST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gateway.lan (Postfix) with ESMTP id 1987F3A2430;
	Tue, 19 Apr 2005 16:43:20 +0200 (SAST)
Received: from gateway.lan ([127.0.0.1])
 by localhost (gateway.lan [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 17196-04; Tue, 19 Apr 2005 16:43:14 +0200 (SAST)
Received: from nosferatu.lan (nosferatu.lan [192.168.0.2])
	(using TLSv1 with cipher IDEA-CBC-SHA (128/128 bits))
	(No client certificate requested)
	by gateway.lan (Postfix) with ESMTP id B55DA3A241A;
	Tue, 19 Apr 2005 16:43:14 +0200 (SAST)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050419105008.GB12757@pasky.ji.cz>
X-Mailer: Evolution 2.2.1.1 
X-Virus-Scanned: by amavisd-new using ClamAV at nosferatu.za.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-EKOd6LwUPprqc4E6RVq0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-04-19 at 12:50 +0200, Petr Baudis wrote:
> Dear diary, on Tue, Apr 19, 2005 at 12:05:10PM CEST, I got a letter
> where Martin Schlemmer <azarah@nosferatu.za.org> told me that...
> > On Tue, 2005-04-19 at 11:28 +0200, Petr Baudis wrote:
> > > Dear diary, on Tue, Apr 19, 2005 at 11:18:55AM CEST, I got a letter
> > > where David Greaves <david@dgreaves.com> told me that...
> > >
> > > Dunno. I do it personally all the time, with git at least.
> > >=20
> > > What do others think? :-)
> > >=20
> >=20
> > I think pull is pull.  If you are doing lots of local stuff and do not
> > want it overwritten, it should have been in a forked branch.
>=20
> I disagree. This already forces you to have two branches (one to pull
> from to get the data, mirroring the remote branch, one for your real
> work) uselessly and needlessly.
>=20
> I think there is just no good name for what pull is doing now, and
> update seems like a great name for what pull-and-merge really is. Pull
> really is pull - it _pulls_ the data, while update also updates the
> given tree. No surprises.
>=20
> (We should obviously have also update-without-pull but that is probably
> not going to be so common so a parameter for update (like -n) should be
> fine for that.)
>=20
> These naming issues may appear silly but I think they matter big time
> for usability, intuitiveness, and learning curve (I don't want git-pasky
> become another GNU arch).
>=20

Ok, so 'pull' do the bk thing, and 'update' do the cvs thing.  I think
however you should do either do one or the other.  Maybe drop the
'update', and rather add 'checkout' (or 'co' for short) which will
update the tree (or merge with local changes if needed).  Then you have
two distinct separate things (ok, so pretty much how bk do things).

This will also enable you to make 'fork', 'export', etc just do the
right thing with the database, but leave 'checkout' up to the user if he
wants to do so.


--=20
Martin Schlemmer


--=-EKOd6LwUPprqc4E6RVq0
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCZRh7qburzKaJYLYRAisjAJ9d06BiHmBoA+fM+m/OcRSfg+p6wwCgklfN
fYMXcNOY2JWCfgVK9hLazZk=
=nLDk
-----END PGP SIGNATURE-----

--=-EKOd6LwUPprqc4E6RVq0--

