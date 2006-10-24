From: Jelmer Vernooij <jelmer@samba.org>
Subject: Re: VCS comparison table
Date: Tue, 24 Oct 2006 11:30:33 +0200
Message-ID: <20061024093033.GA23906@rhonwyn.vernstok.nl>
References: <20061022074513.GF29927@artax.karlin.mff.cuni.cz> <200610221105.26421.jnareb@gmail.com> <845b6e870610220256u39d3d06wefd4f71851670812@mail.gmail.com> <87zmbozau2.wl%cworth@cworth.org> <20061022185350.GW75501@over-yonder.net> <Pine.LNX.4.64.0610231018410.3962@g5.osdl.org> <20061023222131.GB17019@over-yonder.net> <ehjgli$lft$1@sea.gmane.org> <845b6e870610231614y681e64eu33bb0806f530c742@mail.gmail.com> <Pine.LNX.4.64.0610231623340.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Cc: Erik B?gfors <zindar@gmail.com>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 24 11:31:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcId3-0003KA-1o
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 11:31:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965096AbWJXJbV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 05:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965104AbWJXJbV
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 05:31:21 -0400
Received: from smtp-vbr10.xs4all.nl ([194.109.24.30]:38158 "EHLO
	smtp-vbr10.xs4all.nl") by vger.kernel.org with ESMTP
	id S965096AbWJXJbU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Oct 2006 05:31:20 -0400
Received: from rhonwyn.vernstok.nl (a62-251-123-16.adsl.xs4all.nl [62.251.123.16])
	by smtp-vbr10.xs4all.nl (8.13.8/8.13.8) with ESMTP id k9O9V1uF062730;
	Tue, 24 Oct 2006 11:31:01 +0200 (CEST)
	(envelope-from jelmer@rhonwyn.vernstok.nl)
Received: from localhost (localhost [127.0.0.1])
	by rhonwyn.vernstok.nl (Postfix) with ESMTP id EB09B39A3B8;
	Tue, 24 Oct 2006 11:30:50 +0200 (CEST)
Received: from rhonwyn.vernstok.nl ([127.0.0.1])
	by localhost (rhonwyn.vernstok.nl [127.0.0.1]) (amavisd-new, port 10024)
	with SMTP id 23664-05; Tue, 24 Oct 2006 11:30:33 +0200 (CEST)
Received: by rhonwyn.vernstok.nl (Postfix, from userid 1000)
	id 364F739A3C1; Tue, 24 Oct 2006 11:30:33 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610231623340.3962@g5.osdl.org>
X-Operating-System: Linux rhonwyn.vernstok.nl 2.6.15-27-server
User-Agent: Mutt/1.5.11
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29954>


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2006 at 04:24:30PM -0700, Linus Torvalds wrote:
> On Tue, 24 Oct 2006, Erik B?gfors wrote:
> > I don't see any problem doing a "gitk --all" equivalent in bzr.
> The problem? How do you show a commit that is _common_ to two branches,=
=20
> but has different revision names in them?
It'll have the same revision name. The revision no's will be
different, sure, but that's not a problem.

> Do you _finally_ see what is so wrong with this whole per-branch naming?
revnos are the only naming bit that is branch-specific.

I guess one way of looking at revnos is to regard them completely as a=20
command-line ui thing.  They're not explicitly stored anywhere on
disk but just an easy way for users to refer to revisions on a
per-branch basis.=20

The graphical frontends to bzr, for example, don't know about revno's but=
=20
only about revids.

Cheers,

Jelmer

--=20
Jelmer Vernooij <jelmer@samba.org> - http://jelmer.vernstok.nl/
Currently playing:=20

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFFPd05Pa9Uoh7vUnYRAlwwAKCHGkYxoaSpRI+lbTx7iga/t9QTEwCeMJCw
kiDJKfApWcAPxM/xuTvYMpo=
=2y2N
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
