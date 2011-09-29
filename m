From: Michal Vyskocil <mvyskocil@suse.cz>
Subject: Re: [PATCH] show git tag output in pager
Date: Thu, 29 Sep 2011 11:37:49 +0200
Message-ID: <20110929093749.GB27152@zelva.suse.cz>
References: <20110927134235.GA27478@zelva.suse.cz>
 <vpqehz2cbk4.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8GpibOaaTibBMecb"
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Sep 29 11:38:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9D40-0002Lt-D1
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 11:37:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755303Ab1I2Jhw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Sep 2011 05:37:52 -0400
Received: from nat.scz.novell.com ([213.151.88.252]:48467 "EHLO zelva.site"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755091Ab1I2Jhv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2011 05:37:51 -0400
Received: by zelva.site (Postfix, from userid 10112)
	id 3BD4842F3A10; Thu, 29 Sep 2011 11:37:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <vpqehz2cbk4.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182389>


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 27, 2011 at 04:19:39PM +0200, Matthieu Moy wrote:
> The commit message should explain why this is needed, and in particular
> why you prefer this to setting pager.tag in your ~/.gitconfig.

Opps! I read a documentation, but I did not realize this works for all
commands and not only for them calling setup_pager(). Then sorry, no
change is needed.

>=20
> Michal Vyskocil <mvyskocil@suse.cz> writes:
>=20
> > --- a/builtin/tag.c
> > +++ b/builtin/tag.c
> > @@ -147,6 +147,8 @@ static int list_tags(const char **patterns, int lin=
es,
> >  			struct commit_list *with_commit)
> >  {
> >  	struct tag_filter filter;
> > +       =20
> > +        setup_pager();
>=20
> Git indents with tabs, not spaces, and does not leave trailing
> whitespaces.

OK, thanks for the feedbac. I will try to be more carefull in the
future.

Regards
Michal Vyskocil

>=20
> --=20
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/

--8GpibOaaTibBMecb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk6EPG0ACgkQGwzgx2QvQgQ8QwCfbjmHF7hw/8oayklM/L7Zz8WZ
GJsAnifSDSmVEIPxLIRqFruD6dYxh/xW
=/4kp
-----END PGP SIGNATURE-----

--8GpibOaaTibBMecb--
