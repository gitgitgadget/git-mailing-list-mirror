From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] setup.c: guard config parser from value=NULL
Date: Fri, 8 Feb 2008 22:29:47 +0100
Message-ID: <20080208212947.GA25954@genesis.frugalware.org>
References: <20080208142702.GY25954@genesis.frugalware.org> <200802081734.24967.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gQt10JDuGyDb0HQ5"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michele Ballabio <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 22:30:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNao2-0007B4-SL
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 22:30:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753111AbYBHVaM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 16:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753519AbYBHVaL
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 16:30:11 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:60405 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752877AbYBHVaK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 16:30:10 -0500
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1JNanG-0000Cz-61
	from <vmiklos@frugalware.org>; Fri, 08 Feb 2008 22:30:04 +0100
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id D72E211901BD; Fri,  8 Feb 2008 22:29:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200802081734.24967.barra_cuda@katamail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -0.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-0.5 required=5.9 tests=BAYES_20 autolearn=no SpamAssassin version=3.2.3
	-0.5 BAYES_20               BODY: Bayesian spam probability is 5 to 20%
	[score: 0.0588]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73150>


--gQt10JDuGyDb0HQ5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 08, 2008 at 05:34:24PM +0100, Michele Ballabio <barra_cuda@katamail.com> wrote:
> On Friday 08 February 2008, Miklos Vajna wrote:
> > diff --git a/setup.c b/setup.c
> > index adede16..361825f 100644
> > --- a/setup.c
> > +++ b/setup.c
> > @@ -346,13 +346,13 @@ int git_config_perm(const char *var, const char *value)
> >  {
> >  	if (value) {
>             ^^^^^
> value is already checked here. No need to check further.

ah, i missed it. should we add some comment about this or just it wasn't
obvious to me only? (same true to the other patch where you pointed out
the check was not necessary)

thanks,
- VMiklos

--gQt10JDuGyDb0HQ5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHrMnLe81tAgORUJYRApAJAJ4xq2sJma2ervcr3b+YjzDHFWKMRACgmpD3
jVxgMP2kvL5tQTf8wSfApiI=
=f8kn
-----END PGP SIGNATURE-----

--gQt10JDuGyDb0HQ5--
