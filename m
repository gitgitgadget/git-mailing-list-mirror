From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH] Documentation/submodule: Fix submodule.<name> -> .<path>
 typos
Date: Thu, 27 Mar 2014 19:06:48 -0700
Message-ID: <20140328020648.GB25485@odin.tremily.us>
References: <f86f6b48f1c840d50d00c591a296821e0a18ee0d.1395954229.git.wking@tremily.us>
 <5334B0F4.60103@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vGgW1X5XWziG23Ko"
Cc: Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Mar 28 03:07:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTMCE-0005DX-JU
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 03:07:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757216AbaC1CG5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 22:06:57 -0400
Received: from qmta02.westchester.pa.mail.comcast.net ([76.96.62.24]:44803
	"EHLO qmta02.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757172AbaC1CGw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Mar 2014 22:06:52 -0400
Received: from omta19.westchester.pa.mail.comcast.net ([76.96.62.98])
	by qmta02.westchester.pa.mail.comcast.net with comcast
	id ipNP1n00327AodY51q6rmc; Fri, 28 Mar 2014 02:06:51 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta19.westchester.pa.mail.comcast.net with comcast
	id iq6p1n00S152l3L3fq6q1S; Fri, 28 Mar 2014 02:06:51 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id D82E410DE0BB; Thu, 27 Mar 2014 19:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1395972408; bh=qHk94Ldx6By4ikLaBOMQVb8shBQ++C4N9s1IH8SE/Fo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eZyvVcu8G7ZgG/AtPvks5Ma0Hw99IvuaDMlyCY7/7cPjewK+MuMzKFaqyN+IQJVgC
	 vVOLBvHyYGki9wwPMfDgTghdJ7bR6c/jC86tfaigkHBoydFoiR/TkNi0FJV7SIMXlb
	 20dsyqt5M2FcLgC3KybZyU3k+8jP5kVBhySVcZG0=
Content-Disposition: inline
In-Reply-To: <5334B0F4.60103@web.de>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1395972411;
	bh=a+Y1XMuu7xVUUY4l4CfP7dOJ4dQ6rgxDz0aXRYqwQe0=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=uGotIwNkp5JTU2n3QedpwT4qo8J6aqZP7J0ZyXTG+4/5L2B7AFYomH3xkGHhnB54F
	 mb24xc45WiIdloBMwywMGSWbaifnJlo6q/2TpinOJF+fdCaPx26unRUkh760x9O3m/
	 I48eqrX4EwvwDiLX5oRjUwWnnk2GOY4i0Hl77efHW3aKscv1LNV2gmI5Bs/JMHn1Bu
	 9Eg08bZe0sX9uOeQgXjzWcowAWJeRQ2HZ2Nvk0swvh52TO+g8GaS2jVSvFL/Gcao5w
	 GmIuRpq8Rt92uQ+Yy1ixJTWsSMDnTD+6ojl+ppn+GRTW+0PNlTvZQaWE+HGlB/Ij6s
	 rcxT157oALx8Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245352>


--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2014 at 12:15:00AM +0100, Jens Lehmann wrote:
> Am 27.03.2014 22:06, schrieb W. Trevor King:
> > The transition from submodule.<path>.* to submodule.<name>.* happened
> > in 73b0898d (Teach "git submodule add" the --name option, 2012-09-30),
> > which landed in v1.8.1-rc0 on 2012-12-03.
>=20
> Nope, the distinction between path and name is way older (AFAIK it
> is there from day one). That was just the point in time where you
> could choose a different name without editing .gitmodules. And the
> fact that the name is initialized with the path confused a lot of
> people.

Before 73b0898d, cmd_add used:

  git config -f .gitmodules submodule."$sm_path".path "$sm_path"

and similar, so I used submodule.<path>.branch in my initial
documentation of this patch (v5 of that series) [1].  By the final v8
(which rebased onto the then-current master with 73b0898d), the
surrounding calls were [2]:

  git config -f .gitmodules submodule."$sm_name".path "$sm_path"

but I missed the update to <name> in my rebasing.  I suppose I could
have used <name> instead of <path> in my initial v5 patch, but I was
one of the folks confused by the old name =3D=3D path behavior ;).

> > This patch is against master, because 23d25e48 hasn't landed in maint
> > yet.  If you want, I can split this into two patches, one against
> > maint fixing the b9289227 typo and another against master fixing the
> > 23d25e48 typo.
>=20
> This fixes the only two usages of 'submodule.<path>.*' in the
> Documentation I can see in current master.

Right.  However, this patch won't apply to the maint branch (where
23d25e48 hasn't landed).  I'm just saying that we may want to split
this patch in half and push the fix for b9289227 in a maintenance
release.  On the other hand, we've survived since 2012 with the
current docs, so *not* splitting this patch apart works for me too.

Cheers,
Trevor

[1]: http://article.gmane.org/gmane.comp.version-control.git/210763
[2]: http://article.gmane.org/gmane.comp.version-control.git/211832

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--vGgW1X5XWziG23Ko
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTNNk2AAoJEKKfehoaNkbtMiYP/ApPKt/NoKK0ykC7x8zxhGF3
tcD4ZyHMWnd7d49fV5dViAdE+EmpcZN8nStECY0QOL9hO/zJdXzOHtP7NTt4VK7j
J69ylpk4myoWZEgDQaUPKppiF4TeAF9sn0Yf0scGnsvWWrcWRiTAJB35JLWnepgD
JOwKGhaF+Vyc0H+AO0UU6PJr8kz3EijVBRVYRaLvAKJZ6jdI1hPfW3QiL03jYzkg
aI9LD+8JwnpzSfH4eno+h3SZqz3gpqNcuOfXXZ1eBm0/bwcfpaVkFbaaV/yYIHan
Atexjt5bqHM1+rONLO0NicPY0fQfGfq0FqhZxuwZ6ascUAzvcKziuWZmpHvoaXjG
wpS5Pn4/s4jFfhYtEeJmBRpSqK373oQf7cWE9yRPLMSQ8zlnRDgVGyUnPppujIXG
hRSobNq1P11P0KFwRKn0NhNN0NCrLiP2LU3v/ANWj5ApeojTFVcnBNCfgFOW5ViM
KCZ2Dv8o6419mXaTB007Ykpr7U9ArRGgv3KrI4B9YreyeAFX36Kas1r611W8CV+K
I9vO4ObHPIUDX1bI9qvggtLftksWf3hf7kK4IbQr733H1XCapqBcaMweIfk5UITU
3t0jTwuHCTgCmvO2GLOhO4vvrYIXv1aM2az0S7SGai8IB2qWJffxalaMZVTN6FM6
pXa9cKZgF/YrEmMqtjFa
=2Oz9
-----END PGP SIGNATURE-----

--vGgW1X5XWziG23Ko--
