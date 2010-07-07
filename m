From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [FAILED] BLD phyCORE-i.MX35 + linux-next git kernel
Date: Wed, 7 Jul 2010 17:15:47 +1000
Message-ID: <20100707171547.822511cd.sfr@canb.auug.org.au>
References: <E1OVsw1-0006iT-LS@himalia.hi.pengutronix.de>
	<20100706152246.GB2502@pengutronix.de>
	<20100707114858.e52cec1b.sfr@canb.auug.org.au>
	<20100707064735.GE2502@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__7_Jul_2010_17_15_47_+1000_+ZgUXNiHtPWXWt7f"
Cc: git@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
	kernel@pengutronix.de
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Wed Jul 07 09:16:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWOrU-0002ja-Pa
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 09:16:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762Ab0GGHPy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 03:15:54 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:48369 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751384Ab0GGHPy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 03:15:54 -0400
Received: from canb.auug.org.au (ibmaus65.lnk.telstra.net [165.228.126.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtps.tip.net.au (Postfix) with ESMTPSA id E8663144003;
	Wed,  7 Jul 2010 17:15:51 +1000 (EST)
In-Reply-To: <20100707064735.GE2502@pengutronix.de>
X-Mailer: Sylpheed 3.0.2 (GTK+ 2.20.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150454>

--Signature=_Wed__7_Jul_2010_17_15_47_+1000_+ZgUXNiHtPWXWt7f
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Uwe,

On Wed, 7 Jul 2010 08:47:35 +0200 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pe=
ngutronix.de> wrote:
>
> > OK, this is only the third time I have seen git mismerge something
> > automaitcally. :-(
> I can reproduce that here[1].  Is this a bug in git?  Can somebody explai=
n?
> I expected a merge conflict or only a single occurence of devices[]

I suspect it is a matter of not enough context (or the context looks the
same after applying one of the updates) for git to realise that both
trees are trying to add the same code in the same place.  There is a
conflict, but the recursive merge decides that each tree is adding
something different and so include them both (or some such :-)).  Most of
the time, git gets this right.

> > I have fixed this up in today's linux-next (and will continue to do so
> > while necessary).
> How do you remember this.  By "hand" or do you have some automatism for
> such things?

In this case, my scripts automatically apply a patch to the merge commit.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__7_Jul_2010_17_15_47_+1000_+ZgUXNiHtPWXWt7f
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMNCmjAAoJEDMEi1NhKgbsPOYH/jxARllpmjQjuG6ZOoo+7Ux8
sdapESCpUcetkEMKFTfTmFTANYco3/TjRx3UofphSvoWEhVbR3BKLq0SOF7AhVjI
sj7TEcTzwW97dlMGYdhDgIfUoC8SHEYtC97P4TIETeFncEXX4BFQ2WYapTtTgRab
HjdVJzq7Y9bSwj/lX83emEAC/UEcwj4dqdtlLGT7TPFvcOSSDWMoCfg6K+XbqEmt
WQqT6kHTfwJLQfexnMwpvEWgTuXfAUJ578XvRdnuUpEUoV9HsP9Dw3ppY3gNCmTg
8VOPbI7brdgBievuRZS0wcXp0RyLcVMuXM7ZLQ9MiTlvgifjW5/oib1RPUTDqjs=
=fnNj
-----END PGP SIGNATURE-----

--Signature=_Wed__7_Jul_2010_17_15_47_+1000_+ZgUXNiHtPWXWt7f--
