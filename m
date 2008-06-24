From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 24 Jun 2008 20:54:03 +0200
Message-ID: <20080624185403.GB29404@genesis.frugalware.org>
References: <7vhccfiksy.fsf@gitster.siamese.dyndns.org> <7vod6k6zg4.fsf@gitster.siamese.dyndns.org> <7v4p7xwsfp.fsf@gitster.siamese.dyndns.org> <7v3anb19n7.fsf@gitster.siamese.dyndns.org> <7vwskjazql.fsf@gitster.siamese.dyndns.org> <20080621121429.GI29404@genesis.frugalware.org> <7vwskfclfs.fsf@gitster.siamese.dyndns.org> <9B8F0B10-F48D-475B-BF59-CEE94222B6E8@ai.rug.nl> <20080624160224.GA29404@genesis.frugalware.org> <alpine.DEB.1.00.0806241709330.9925@racer>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aLWXLejKbYsG67Wz"
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 24 20:55:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBDfi-0006uL-FP
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 20:55:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755697AbYFXSyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 14:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752596AbYFXSyL
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 14:54:11 -0400
Received: from virgo.iok.hu ([193.202.89.103]:55258 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755631AbYFXSyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 14:54:09 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 321801B2555;
	Tue, 24 Jun 2008 20:54:06 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 8E7B744668;
	Tue, 24 Jun 2008 20:29:02 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id A1FCF1770070; Tue, 24 Jun 2008 20:54:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0806241709330.9925@racer>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86103>


--aLWXLejKbYsG67Wz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2008 at 05:25:57PM +0100, Johannes Schindelin <Johannes.Sch=
indelin@gmx.de> wrote:
> > > Vienna:bin pieter$ git --version
> > > git version 1.5.6.129.g274ea
> > > Vienna:bin pieter$ git clone localhost:project/bonnenteller
> > > Initialize bonnenteller/.git
> > > Initialized empty Git repository in /opt/git/bin/bonnenteller/.git/
> > > Password:
> > > bash: git-upload-pack: command not found
> > > fatal: The remote end hung up unexpectedly
> > >=20
> > > I think that is what Miklos meant.
> >=20
> > Exactly. Thanks for the good description.
>=20
> AFAICT these are fixed with ed99a225(Merge branch 'jc/dashless' into=20
> next).

Using fc48199 ("Merge branch 'master' into next", which includes
ed99a225) on the server, v1.5.6 on the client, I get:=20

$ git clone server:/home/vmiklos/git/test next
Initialize next/.git
Initialized empty Git repository in /home/vmiklos/scm/git/next/.git/
vmiklos@server's password:
bash: git-upload-pack: command not found
fatal: The remote end hung up unexpectedly

--aLWXLejKbYsG67Wz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhhQssACgkQe81tAgORUJb3AwCfVDDBJqnrpBddKrLnuwJDVzfO
vyEAoKDuIaSeIvyf4bf0DtGQl3x96iO8
=GYhd
-----END PGP SIGNATURE-----

--aLWXLejKbYsG67Wz--
