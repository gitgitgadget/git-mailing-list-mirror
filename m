Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D13221F404
	for <e@80x24.org>; Wed, 29 Aug 2018 07:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbeH2LOV (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 07:14:21 -0400
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31]:54136 "EHLO
        lb3-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727156AbeH2LOU (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Aug 2018 07:14:20 -0400
Received: from pc09.procura.nl ([188.202.26.81])
        by smtp-cloud7.xs4all.net with ESMTPSA
        id uukbfaVqEF5MQuukcf6OWD; Wed, 29 Aug 2018 09:18:50 +0200
Date:   Wed, 29 Aug 2018 09:18:38 +0200
From:   "H.Merijn Brand" <h.m.brand@xs4all.nl>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: Feature request: be able to pass arguments to difftool command
Message-ID: <20180829091838.2eee8a6a@pc09.procura.nl>
In-Reply-To: <xmqqpny2ffjv.fsf@gitster-ct.c.googlers.com>
References: <20180828175711.3a0aeacc@pc09.procura.nl>
        <xmqqpny2ffjv.fsf@gitster-ct.c.googlers.com>
X-Mailer: Claws Mail 3.16.0git170 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwEAIAAACI8LKTAAAACXBIWXMAAABIAAAASABGyWs+AAAC
 JElEQVRo3u2aMY4CMQxFczZ6RItEzRm4DBINDbRUSPRInIRbsNK6+dJfezN4kokn48IaCSjysL8d
 e9Knoj2fr9f9/gllqQ6U9/vxWK3EdwdIEGjRIVCu18NhuxUfK46SH81+fzrdbuKPx/P5ctHQdAdI
 TKAgpvV6s9ntBEfXEYSGgMQzIHnuFBBjkshCNJ2KtJZ04hHNAugP8bZr3NIHhbcF0AKoK0CoaHXU
 LUWBIs1n+jV+Fl8CVqOApEXAwyMO/DSR4XVntoAYDR7eBjQupuYAYTMph8Rj21D4m7MChN02tpqs
 NSnb/KqU2oHCXu5xDCgflj/RAgBiKBIXnICzAsSjWBsTz5K4/HeXYvb8yK5lY3VGEwPi2aONKT+5
 AlcxrTPOwcTiraGRChgMEKJh0bVVifGVTq6qgBiNVl8QE29EsK6VE+YJAOG2wz5AvsqUS6uqgHCA
 n4NGvBYpnJ64Jgg27sCtxtBk1CJIA4S/GhdWKh07QxUB48jWGhZ4jKamRRr/T8/M0AaEyctry6YB
 4dTGj9iWZNs3DahES5kPCJOu0RQbF/fQOBprsB9gaO9JtPDzII9U5ySXX7AnuIt91y54AAW7rPpT
 LCe5gt3F+CLqr2UarGB3MXvMylWGq4+9RCx3TW1oJq1t3HPQlFs6N1fFNEB4s8dn7Ne7ACSm7TPQ
 I5quAWmw6qBpulHM33B0Csge4Nd8JTTYG2b1XyRe3lH8x34ABJ6aePuQ2N4AAAAASUVORK5CYII=
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/s6Wewg/fhf3mmL1enU7y=nW"; protocol="application/pgp-signature"
X-CMAE-Envelope: MS4wfK28dav4b+/wUWqEfxFxLJz7UNZd9/gmVvbKT1im6909emKJ6H/OqReyTkWpmenALOuPEx+vVmqwePU8HTDDVfg07ZzKWP3DE5m6MBUAKUK+ThH6CKG7
 YCmHvTNuq1x3X7hCkfHbyHuqnE605xgeMa8rpPbwC9aD9H4PuLEfWWAEQBslfDZFw5PSVLgL3O1vpr8EH4uKQIqX4c7Ikc6rzf0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--Sig_/s6Wewg/fhf3mmL1enU7y=nW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Aug 2018 12:37:40 -0700, Junio C Hamano <gitster@pobox.com>
wrote:

> "H.Merijn Brand" <h.m.brand@xs4all.nl> writes:
>=20
> > So, my wish would be to have an option, possibly using -- to pass
> > additional command line arguments to git difftool, so that
> >
> >  $ git difftool $commit~1..$commit -- -m -v2
> >
> > would pass the arguments after -- transparantly to ccdiff (in my case) =
=20
>=20
> At the syntax level passing any option after "--" would be a no
> starter, as I would imagine that "git difftool $revs -- $paths"
> should still be supported.
>=20
> At the concept level, however, I can see why such a feature would be
> useful.  Perhaps
>=20
>     $ git difftool --backend-option=3D-m --backend-option=3D-v2 HEAD
>     $ git mergetool --backend-option=3D--foo

This would mean I can just pass remaining arguments, like this?

--8<--- ~/bin/git-ccdiff
#!/usr/bin/env perl
use 5.18.3;
use warnings;

my $commit;

@ARGV && $ARGV[0] !~ m/^-/ and $commit =3D shift;

my @git =3D qw( git difftool );
defined $commit and push @git, "$commit~1..$commit";
system @git, @ARGV;
-->8---

> with appropriate way(s) [*1*] to make it easier to type (and
> implement) would be an acceptable avenue to pursue, I wonder?

I like it, as long as they are all separate options in the backend and
not available in one single variable that needs to be split

I can envision a configure variable like

  backends.options.separator =3D U+2063

so the backend can safely split on that itself. But I also see this as
overly complex en over-engineering

> [Footnote]
>=20
> *1* There are various possible ways, not all of them are mutually
>     incompatible.
>=20
>     a. Give a short-form synonym, e.g. -X, to "--backend-option";

I like it

>     b. Assume that backend option always begins with a dash and add
>        one when missing, e.g. -Xm becomes --backend-option=3D-m

I guess not: there might be tools that do not work like that, e.g.
xfreerdp changed all their rememberable and logic options to the weird
stupid syntax they use now, including mixing -, -- and +

 rdesktop -u user -p - -g 1280x1024 -a 16 -r clipboard:CLIPBOARD host

->

 xfreerdp -u user --from-stdin -g 1280x1024 -a 16 --plugin clipbrd host

->

 xfreerdp /u:user /from-stdin /size:1280x1024 /bpp:16 +clipboard /v:host

>     c. Allow giving multiple backend options on a single option and
>        split at whitespace, e.g. --backend-option=3D"-m -v2"

That is the weak part in my workaround, as it will break on options like

  --backend-option=3D'--config=3D"/path/to/My Configuration/My Application"'

>     d. Allow difftool.$toolname.opts configuration variable that is
>        multi-valued, so you can say
>=20
> 	git -c difftool.ccdiff.opts=3D-v2 -c difftool.ccdiff.opts=3D-m difftool

Hmm, maybe harder to explain, but why not

>        (of course, not necessarily from the command line but the
>        point is you could configure it)
>=20
>     Some of these (e.g. b, c) may not be desirable, though.


--=20
H.Merijn Brand  http://tux.nl   Perl Monger  http://amsterdam.pm.org/
using perl5.00307 .. 5.29   porting perl5 on HP-UX, AIX, and openSUSE
http://mirrors.develooper.com/hpux/        http://www.test-smoke.org/
http://qa.perl.org   http://www.goldmark.org/jeff/stupid-disclaimers/

--Sig_/s6Wewg/fhf3mmL1enU7y=nW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJbhkjYAAoJEAOhR6E+XcCY3eQIAKcvYl+2XrOhcAW69BoOpG5R
MpuVBWGFZUWD0qowprWgBDhvbyRgZVpGUeYrCErYSMVDXTgIltZrdo4OgJzCI4Gy
gz97Bl6C+4wwjTVrpiS+T3Vg7Talq27YYheySWYthAdmUlBckGS0jCh9APXa3idY
U0vtleYrvFMy+VeMLdCsOZACkqLZdJD3O+Y9qAkVs70UyAfgg6bl968JdQt2veqi
QMa/4jAJql7hW7KjfNee1SzzjYd9ksLfLW5wQksqX4bECnLRzm8gBePdWuEB34aK
WpXme+ny7gXGGLFuRkJxlc7BDpSb+QsVlxHMcUnfAzSY4tVHl/T2e2Wl2w9xGlw=
=HIh2
-----END PGP SIGNATURE-----

--Sig_/s6Wewg/fhf3mmL1enU7y=nW--
