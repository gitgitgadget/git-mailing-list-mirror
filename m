From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [Newbie] How to *actually* get rid of remote tracking branch?
Date: Sat, 17 Nov 2007 17:56:57 +0100
Message-ID: <20071117165657.GC5198@efreet.light.src>
References: <874pfq9q8s.fsf@osv.gnss.ru> <fhcdpv$9u3$1@ger.gmane.org> <87ve86889o.fsf@osv.gnss.ru> <Pine.LNX.4.64.0711131600590.4362@racer.site> <87prye832v.fsf@osv.gnss.ru> <Pine.LNX.4.64.0711131819490.4362@racer.site> <874pfq7zpg.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Sat Nov 17 17:59:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItR0s-0000uz-UY
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 17:59:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754293AbXKQQ5H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 11:57:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753765AbXKQQ5G
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 11:57:06 -0500
Received: from ns1.bluetone.cz ([212.158.128.13]:33353 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751878AbXKQQ5E (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 11:57:04 -0500
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 48CE25745C;
	Sat, 17 Nov 2007 17:57:02 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id Vl6fEsVYnu43; Sat, 17 Nov 2007 17:56:59 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id E39E857413;
	Sat, 17 Nov 2007 17:56:58 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1ItQyX-0006kA-RE; Sat, 17 Nov 2007 17:56:57 +0100
Content-Disposition: inline
In-Reply-To: <874pfq7zpg.fsf@osv.gnss.ru>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65289>


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 13, 2007 at 21:44:11 +0300, Sergei Organov wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>=20
> > Hi,
> >
> > On Tue, 13 Nov 2007, Sergei Organov wrote:
> >
> >> Sorry, but *I* didn't *explicitly* fetch it _again_!
> >>=20
> >> 1. I cloned git.git repo making no custom steps.
> >
> > Which means that you wanted to track that repository.  Yes, the complet=
e=20
> > repository.  Not a single branch.  Not all branches except a single one.
> >
> >> 2. I decided I don't need to track some of branches.
> >
> > The you should have done that.
>=20
> I think I did my best to try to do that (basing my attempts on current
> git documentation). Isn't it?
>=20
> > But that is different from "I decided to delete the tracking
> > _branch_".
>=20
> Yes, but the question is *why*? Isn't it an obvious application of
> deleting tracking branch?

No, it's not. Fetching has to bring you any heads that were newly created in
the remote repo. It can't tell whether a head is new since last fetch or you
just for whatever reason didn't have the tracking branch before.

> And, as I've already asked in another
> sub-thread of this one, what the following example in the man git-branch
> is supposed to achieve?:
>=20
> <quote Documentation/git-branch.txt>
> Delete unneeded branch::
> +
> ------------
> $ git clone git://git.kernel.org/.../git.git my.git
> $ cd my.git
> $ git branch -d -r origin/todo origin/html origin/man   <1>
> $ git branch -D test                                    <2>
> ------------
> +
> <1> Delete remote-tracking branches "todo", "html", "man"
> </quote>
>=20
> Sorry, but I still believe that it's not me who needs fixing.

That documentation is precise. But it could maybe contain a footnote saying,
that if you remove a tracking branch, next fetch will create it again unless
you reconfigure it not to.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHPx1ZRel1vVwhjGURAluXAJ93beuTpxyk1TIHoYWbCfJC4lJBAwCgwwEO
J9yZ5+KpCX35vTiS/9ICuQg=
=D5WT
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
