From: Eric Deplagne <Eric@Deplagne.name>
Subject: Re: Merge conflicts are reported relative to root not cwd
Date: Thu, 14 Apr 2016 09:53:00 +0200
Message-ID: <20160414075300.GA16358@mail.eric.deplagne.name>
References: <CAGZ79kbVfk=yAK3UB=H385_YfAtMHZe-gSE=EYVvvcS8jjy08A@mail.gmail.com> <xmqq4mb5jhm7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0PQOkvCAw33/u/bm"
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 10:35:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqck5-0005N4-Al
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 10:35:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754149AbcDNIfE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 04:35:04 -0400
Received: from goldorak5.eric.deplagne.name ([213.246.56.18]:51767 "EHLO
	exim4.goldorak5.eric.deplagne.name" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753569AbcDNIfA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2016 04:35:00 -0400
X-Greylist: delayed 2514 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Apr 2016 04:35:00 EDT
Received: from [192.168.0.4] (helo=mail.eric.deplagne.name)
	by exim4.goldorak5.eric.deplagne.name with esmtp (Exim 4.72)
	(envelope-from <Eric@Deplagne.name>)
	id 1aqc5E-0004gw-Jy; Thu, 14 Apr 2016 09:53:00 +0200
Received: from deplagne by mail.eric.deplagne.name with local (Exim 4.69)
	(envelope-from <Eric@Deplagne.name>)
	id 1aqc5E-0004gr-J2; Thu, 14 Apr 2016 09:53:00 +0200
Content-Disposition: inline
In-Reply-To: <xmqq4mb5jhm7.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291514>


--0PQOkvCAw33/u/bm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 13 Apr 2016 14:58:40 -0700, Junio C Hamano wrote:
> Stefan Beller <sbeller@google.com> writes:
>=20
> > $ cd t/
> > $ git merge ...
> > ...
> > Auto-merging builtin/submodule--helper.c
> > Auto-merging builtin/fetch.c
> > CONFLICT (content): Merge conflict in builtin/fetch.c
> > Auto-merging builtin/clone.c
> > Auto-merging README.md
> > ...
> >
> > It should say ../builtin/fetch.c IMHO.
> > Any reason to keep the old behavior?
>=20
> I actually prefer to see the "relative to root" behaviour when it
> comes to things like this, that lets you view the things that happen
> in the whole-tree context.
>=20
> I would have to go insane before I start a whole-tree operation like
> "git merge" from deep in my tree, but if I happened to do that, e.g.
>=20
> 	cd perl/blib/lib/Git/SVN/Memoize
>         git merge other-branch
>=20
> I'd rather see that the conflicted path, e.g. builtin/fetch.c,
> reported by showing it like the above output, not happening in
> ../../../../../../builtin/fetch.c which I have to count the
> up-dots to know which file it is talking about.

  From my use of git, I'd really love to be able to copy/paste=20
  ../../../../../../builtin/fetch.c to some vi (or anything else)=20
  command line instead of having vi (or whatever) bark that
  it does not know where builtin/fetch.c is.

--=20
  Eric Deplagne

--0PQOkvCAw33/u/bm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFXD0xcej7DisjVpq4RAjvIAJ4j5q8JhcYhUAvgj2fNgtvXPkkcywCffsB2
9wbXb0C+mFoE+ANa6I7ipmM=
=ubaD
-----END PGP SIGNATURE-----

--0PQOkvCAw33/u/bm--
