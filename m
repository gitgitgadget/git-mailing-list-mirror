Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7CFC433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 01:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF64D61059
	for <git@archiver.kernel.org>; Thu, 20 May 2021 01:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbhETB5D (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 21:57:03 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47326 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230137AbhETB5D (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 19 May 2021 21:57:03 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id AE94460456;
        Thu, 20 May 2021 01:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1621475710;
        bh=fg+9PkMaMFMomupBroLN9LlncxZF0f6te1u8XOANSB8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=HC7e0q04fnmhYA3pqMwH9iBiUt6hgOAR90Bjd5M2/F5+2tOA/bD5hlfbfspRlY3vB
         0jHqtrLBCKrIzE3BUleGMaVFIqmBHR9LA6HoBQIXGNwBR63SET44OmMd7ihiSAxaxS
         psqrrHkGRqG32outuTYmnJxfc/AD+eUCjuE3OgLJ01fjbpO6RzrLI0IxMvdxoUgBVI
         hGQfVnqNZGAVgkeuDmStPzCeifRoCx433dP3u/O/bsRVoZEdfKEmugS+tC74ZBQthf
         VH7JyOG2VykXFsR/jHxKQsQfgT8dtE2xC9eyNsrlx6S1BXGRU4w7RCV7yEuMbHRwKE
         Y3XpQsF6HXa0haiCkVoxR1vdPJshO73YyvOQn9QwmZV/ikOoXtJlUZGJE2P2GVKn+h
         Ea6R11TSMzY8MZ3ul0He392Fhs7GONsACGgJTuqU+Env1iCaVNkUZt6cPeUxv9qWYI
         6eQMkkSo1lh2bnHfebfAYix+EioNGNrD5C9oz8OFxmXm8qb0ErN
Date:   Thu, 20 May 2021 01:55:01 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH] help: colorize man pages
Message-ID: <YKXBdQ36MYz2YG8s@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
References: <20210518010121.1350327-1-felipe.contreras@gmail.com>
 <YKMWL0iZLVl1KTrB@camp.crustytoothpaste.net>
 <60a332fd22dad_14c8d4208ed@natae.notmuch>
 <YKRSlFcFAcHcR3uY@camp.crustytoothpaste.net>
 <87im3fqci9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PQyfAqA7ZR1XFPu/"
Content-Disposition: inline
In-Reply-To: <87im3fqci9.fsf@evledraar.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--PQyfAqA7ZR1XFPu/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-05-19 at 09:26:12, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>=20
> On Tue, May 18 2021, brian m. carlson wrote:
>=20
> > Would you consider various projects coloring their respective manual
> > pages differently to be a desirable state of affairs?
>=20
> I think it's an important distinction that we're not coloring any manual
> pages, it's a question of whether we invoke "man" invoked by "git help
> <whatever>" with the exact same paramaters/options a user would get with
> "man git-<whatever>".

Yes.  I would expect that if the man option is chosen, then we invoke
man without modification.  If I wanted different options, I would have
specified a custom viewer with different options.  For example, I would
be equally annoyed if Git decided to use a completely different pager
for man output than I would normally use to make it "fancy".

The documentation says, "use the man program as usual".  "As usual"
implies the way the user would invoke it.

If we want to add an option for special coloring or modifications, then
we should add an option --fancy-man, where we do something other than
invoking man as normal.

If we were doing our own man-like documentation and not specifically
using man, then I would agree that we'd be free to color it without
relying on the user's expectations about how man works otherwise
(although other objections still apply).

> I don't think it's confusing in that context if we learn to do some "man
> with fancy on top" in this mode.

I think it's confusing if Git does fancy one way, and other projects
which invoke man like cargo do it another way.  It's pretty obvious that
"git help commit" and "cargo help build" both are intended to invoke man
when used in the normal way.

> >> > Additionally, using colors poses accessibility problems.  I know som=
eone
> >> > who, due to his colorblindness, finds terminal colors distracting and
> >> > hard to read, and prefers not to use them at all.
> >>=20
> >>   git -c color.ui=3Dnever help git
> >
> > Yes, but unfortunately, since you've colored the manual pages, they may
> > be hard to read for the user who needs to read them to learn about your
> > configuration.  This is great for you and me, who are already very
> > familiar with Git and know how to do that without looking, but not great
> > for the novice colorblind user.
>=20
> Is the objection here against the use of color, or that we e.g. replace
> grey bold underline with blue bold, as opposed to blue bold underline?
>=20
> I'm not running the patch in this thread currently, but I'm running with
> Felipe's earlier man alias noted in the other thread. So I see how
> losing the underline would be confusing.
>=20
> But if colors only add, but don't substract information by default
> that's not an issue for the color blind, correct? Or at least that's
> been my understanding in helping color blind user in the past (and not
> being color blind myself).

The problem becomes if the color is indistinguishable from other
elements.  For example, I have a friend who has deuteranopia who sees
green as very similar to grey.  Therefore, an environment where a text
is green and the background is grey, without significant differences in
lightness, will likely be illegible for him.

It is _also_ a problem if we have two colors with sufficient contrast
between the foreground and background but those colors look the same and
there is no other distinguishing factor.

So, yes, if the colors only add information and they can otherwise be
distinguished, then it's fine.  However, we're not setting the
background here, only the foreground, and we don't know how the user has
configured their terminal background.

In my particular case, I have a semi-transparent background, which,
because my terminal is often in front of a web browser and many web
pages have light backgrounds is often a medium grey, so a dark red is
illegible here because of poor contrast.  That is true regardless of the
fact that I don't have colorblindness; people with colorblindness just
have more colors (depending on the type) where contrast is poor.

> I.e. issue isn't colors per-se, or even a UI that would make an
> egregious of coloring, rather it's if that UI uses color as a
> *replacement* for showing the same information in another way.

Terminals with colored foregrounds color text, which is the relevant
part, because that's the part people need to read.  I'm less concerned
about us losing the bold or italic nature of text, since that can
usually be ignored without much loss of information.  For example, if a
person viewed all roman, bold, and italic text as uniform but legible,
I'm not worried.

It is fine for accessibility reasons if we color both the foreground and
the background and we ensure they have reasonable distinctiveness.
However, that also results in us breaking the transparent nature of
terminals people have configured that way.

> > For similar reasons, colorizing help output in general is unhelpful
> > because users cannot find the options to disable it.
>=20
> This seems to just be a re-hash of the old argument that git does
> coloring by default, not specifically about "git help <xyz>".
>=20
> I think there's good arguments for/against that, but I do think that
> ultimately it was a good choice, and programs such as hg(1) seemed to
> since have moved to git's more aggressive "color by default" stance.

No, I don't think that's the same thing.  I like that Git does coloring
by default.  I use coloring extensively in Git, and especially the zebra
coloring of diffs.  I also use coloring in my prompt and my editor, and
I like all of that.  I think all of this adds a lot of value, and I like
that Git allows a great deal of customization over this.

What I don't like is when a program colors text in a certain way, I
can't read it, and then I can't read the help output or documentation to
turn it off.  I am specifically arguing against coloring our
documentation and help output because it leaves users with little
recourse to fix the problem.

> > In general, this is made worse because Git doesn't honor the unofficial
> > but widely supported NO_COLOR[0], so reading the documentation is
> > obligatory.
>=20
> I replied about NO_COLOR in
> <87lf8bqdv0.fsf@evledraar.gmail.com>.
>=20
> Regardless of whether or not that's a good idea I don't see how it's
> relevant here. We'd support TERM=3Ddumb, which is *the* standard way to
> tweak this for all programs.

TERM=3Ddumb breaks all addressable cursor support, all use of bold and
standout functionality, and functionality like readline and editline.
Setting TERM=3Ddumb and then invoking man will result in an inability to
page backwards, so that's not a suitable alternative; similarly, it
breaks any sort of interactive prompt (e.g., the shell).

> > The problem is, I don't always.  I am on call for a set of hundreds of
> > servers, only one of which has my shell configuration set up, so
> > defaults here matter.  Moreover, because there are many novice users of
> > Git, we should consider that for a decent number of users, they
> > literally won't know where to look in our documentation to make
> > changes, and therefore the defaults matter for them, too.
>=20
> These servers don't have TERM in their list of AcceptEnv variables, or
> equivalent?

They do support TERM.  I can't set TERM=3Ddumb because then basic prompt
editing doesn't work.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--PQyfAqA7ZR1XFPu/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYKXBcwAKCRB8DEliiIei
gUH8AP9hIiaqNVtMAES8hAvx8l5sqgFRtFitt1EZ4xYPiQDwqQD/ccrOr+DfvLhW
8fKKZWJfYhqOFdzTUEYks1Ht8+jS+gI=
=IrJA
-----END PGP SIGNATURE-----

--PQyfAqA7ZR1XFPu/--
