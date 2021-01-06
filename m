Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4268AC433E0
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 00:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 120D722D74
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 00:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbhAFA0F (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 19:26:05 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47186 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726192AbhAFA0F (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 5 Jan 2021 19:26:05 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CB46360810;
        Wed,  6 Jan 2021 00:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1609892693;
        bh=FpIXmKPoZOWTKVF7s407Khyn9Rp88MJpwYEbKOWFF7E=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=trvjw540CTTzeinpqBC/RB7Js1Fz0tcIEA3GF5f8MoOsJHbDuOPaUN+eAHW4YWeWm
         zVhrj/fP0o4U5R+HCeUOSRULP2tOv9BdPHrGVFdSAh3yUOUvEeS5+xO5SQdcxeg4oy
         u3xYBhobehC9c9pKm9NPkDlEUy35pftkFKlfPQsLAEJlLa9qBitnM5bLqoq+9k1elE
         09RxQwJRaNWfGwTQVKerqg8pIxjNllIUyatLg3PlGaaFuloQNSni/mylrVoBQv+xZJ
         SfmqcGqZdOKO5HWGqtwBorTosvB/gz+2C6iifhSiwnrKqz8r8H4I5cbEzk04tdOcq6
         dIWYPx5YxU7wgiLXhMzKdKTOD6RENnXozjm2uG8V1pwdedajwvdWpqD2RWNS859BFy
         cMIcFMY/0T/BhdA7OZoBLwLC7h1t9MD4mjIj5FXIalEtKWDX+ZPMfS2RqJkxqJRwdm
         Nh+4jYI4zAoTwBBXJrKTshwnZsAy/I2VLMlBp0vljONdCV4J51a
Date:   Wed, 6 Jan 2021 00:24:47 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 5/5] mailmap: support hashed entries in mailmaps
Message-ID: <X/UDT/oLKNQmxBXR@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <20210103211849.2691287-1-sandals@crustytoothpaste.net>
 <20210103211849.2691287-6-sandals@crustytoothpaste.net>
 <875z4bsbuz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sz0IGPO53E/11uA6"
Content-Disposition: inline
In-Reply-To: <875z4bsbuz.fsf@evledraar.gmail.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--sz0IGPO53E/11uA6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-01-05 at 14:21:40, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>=20
> On Sun, Jan 03 2021, brian m. carlson wrote:
>=20
> I think it makes sense to split up 1-4/5 here from 5/5 in this series
> since they're really unrelated changes, although due to the changes in
> 1-4 they'll conflict.

Okay, I'll drop them.

> In v1 I pointed out you needed to read some combination of the cover
> letter & the patch to see what this was intended for (see [1]). I think
> for v3 the commit itself should summarize the trade-offs & design
> choices.

I can do that.  It's a very long commit message anyway, but if you think
it would be better in the commit message, I can add it.

> > For projects which wish to support this, introduce hashed forms into the
> > mailmap.  These forms, which start with "@sha256:" followed by a SHA-256
> > hash of the entry, can be used in place of the form used in the commit
> > field.  This form is intentionally designed to be unlikely to conflict
> > with legitimate use cases.  For example, this is not a valid email
> > address according to RFC 5322.  In the unlikely event that a user has
> > put such a form into the actual commit as their name, we will accept it.
>=20
> We'll emit the commit author information as-is in that case under "git
> show", or run the mapping and map it via mailmap? Anyway, it seems
> there's a test for this. Probably better to just point to it.

It will be handled correctly via the mailmap code, in which case we'll
make a no-op transformation.  If the user is not using the mailmap, then
it will be handled trivially.

> > While the form of the data is designed to accept multiple hash
> > algorithms, we intentionally do not support SHA-1.  There is little
> > reason to support such a weak algorithm in new use cases and no
> > backwards compatibility to consider.  Moreover, SHA-256 is faster than
> > the SHA1DC implementation we use, so this not only improves performance,
> > but simplifies the current implementation somewhat as well.
>=20
> I agree with most of this aside from the "weak algorithm" part. That
> seems like an irrelevant aside for this specific use of a hashing
> algorithm, no? We could even use MD5 here, so SHA256-only is just
> setting is up for not needing to deal with SHA1 forever in this one
> place in some SHA256 future repo.

One should avoid the use of weak algorithms when possible even if they
are not being used in a way that makes them weak because it incentivizes
others to use them, often in a way that is insecure.  I had a
conversation with a junior candidate during an interview who said they
used SHA-1 in a particular case "because Git uses it."  That's why I
mentioned it.

> > Note that it is, of course, possible to perform a lookup on all commit
> > objects to determine the actual entry which matches the hashed form of
> > the data.  However, this is an improvement over the status quo.
> >
> > The performance of this patch with no hashed entries is very similar to
> > the performance without this patch.  Considering a git log command to
> > look up author and committer information on 981,680 commits in the Linux
> > kernel history, either with an unhashed mailmap or a mailmap with all
> > old values hashed:
> >
> >                                    Shortest  Longest  Average  Change
> >   Git 2.30                         7.876     8.297    8.143
> >   This patch, unhashed             7.923     8.484    8.237    + 1.15%
> >   This patch, hashed               14.510    14.783   14.672   +80.17%
> >   This patch, hashed, unoptimized  15.425    16.318   15.901   +95.27%
> >
> > Thus, the average performance after this patch is within normal
> > variation of the pre-patch performance.  It's unlikely that users will
> > notice the difference in practice, even on much larger
> > repositories, unless they're using the new feature.
>=20
> Am I reading this right that if there's a single hashed entry in
> .mailmap anything using %aE or %aN is around 2x as slow?

No, that's not the case.  As soon as we see every hashed entry, we will
stop hashing new entries.  Linux is not necessarily the best case for
this because it has a long history with many one-off contributors long
ago in the history.

I'll explain that further in the commit message and add some more
metrics.

> Your v1 mentioned that a project might "insert entries for many
> contributors in order to make discovery of "interesting" entries
> significantly less convenient." which is gone in the v2 patch. As noted
> in [1] I don't see how it helps the obscurity much, but if that's still
> the intended use we'd expect to get more slowdowns in the wild if users
> intend to convert their whole mailmap to this form if they want a single
> entry to use the form.

Peff objected to that text, so I removed it.

As mentioned above, it depends on who you put in the mailmap.  If
they're the most recent 50 contributors, it'll probably be pretty cheap.
If you put the oldest contributors in there and they've not sent any
recent commits, it will be more expensive.

> Anyway, as you might have guessed I'm still not a fan of this direction.

I've got that impression pretty strongly.

I do want to point out that generally I'm pretty willing to change
approaches and do things differently.  I've completely redone a decent
number of patches in the past in response to feedback on the list.

I'm not changing the approach here because, as mentioned below, I don't
think that just encoding meets the use cases I'm targeting here.  So I
have heard your suggestions and to be clear, I do value your input on
this (and on other topics), it's just that I disagree that such a change
is one I should make.

> So the new->name/email mapping (as opposed to new->email) is really only
> needed for some really obscure cases where two people shared an E-Mail
> or something.

That's unlikely, but it does happen.  That's why we have it.

> So we're talking about hiding the old E-Mail, presumably because it was
> joe@ intsead of jane@, so in that case we could just support URI
> encoding:
>=20
>     Jane Doe <jane@example.com>
>     <jane@example.com> <%6A%6F%65@%64%65%76%65%6C%6F%70%65%72.%63%6F%6D>
>=20
> Made via:
>=20
>     $ perl -MURI::Escape=3Duri_escape -wE 'say uri_escape q[joe@developer=
=2Ecom], "^@."'
>     %6A%6F%65@%64%65%76%65%6C%6F%70%65%72.%63%6F%6D
>=20
> Which also has the nice attribute that people can make it obvious what
> part they want to hide, since this is really a feature to enable social
> politeness & consideration:
>=20
>     Jane Doe <jane@example.com>
>     # I don't want to be known by my old name, thanks
>     <jane@example.com> <%6A%6F%65@developer.com>

I don't think this feature is going to get used if we just encode names
or email addresses.  In the United States, when someone transitions,
they get a court order to change their name.  I don't think a lot of
corporate environments are going to want to just encode an old name or
email address in a trivially invertible way given that.  This is
typically a topic handled with some sensitivity in most companies.

I will tell you that I would not just use an encoded version if I were
changing my name for any of the reasons I've mentioned.  That wouldn't
cut it for me, and I wouldn't use such a feature.  The feature I'm
implementing is a feature I've talked with trans folks about, and that's
why I'm implementing this as it is.  The response I got was essentially,
"It's not everything I want, but it's an improvement."

If the decision is that we want to go with encoding instead of hashing,
then I'll drop this patch.  I'm not going to put my name or sign-off on
that because I don't think it meets the need I'm addressing here.

The entire problem, of course, is that we bake a human's personal name
and email address immutably into a Merkle tree.  We know full well that
people do change their names and email addresses all the time (e.g.,
marriage, job changes), and yet we have this design.  In retrospect, we
should have done something different, but hindsight is 20/20 and I'm
just trying to do the best we can with what we've got.

> 2. Hiding from your enemies
>=20
> For the other use-case of "abusive family or partner" I had the comment
> in v1 of "but not so much that you'd still take the risk of submitting a
> patch to .mailmap?".

No, my use case isn't "hiding from an abusive family or partner".  It's
"I'm finally free of that **** and I never want to hear their name
again."  (I've known people in this situation.)  Also, the similar use
case of, "my family member, with whom I share an uncommon name, murdered
someone, which I obviously found abhorrent, and I would like to not be
associated with them when my name is Googled."  And yes, I knew an
acquaintance many years ago whose family member murdered someone.

In other words, the person changed their name to disassociate
themselves, not to hide from their abuser.

> 4. Spam
>=20
> You mentioned this in your [2] (but not as a use-case in the v2
> re-rolled commit message):
>=20
>     And we know that spammers and recruiters (which, in this case, are
>     also spammers) do indeed scrape repositories via the repository web
>     interfaces.
>=20
> Surely these people are most interested in the current E-Mail addresses,
> which if they're scraping the common web interfaces (e.g. Github,
> GitLab) are easily accessible there. It doesn't seem very plausible that
> someone would care enough to scrape .mailmap for old addresses but not
> just update their scraper to clone & run "git log" for the purposes of
> e.g. their recruitment E-Mails.

Unless the user is using the GitHub-provided noreply address or a
similar address, which is common.  This allows people to map all of
their old addresses to such an address, which, judging from
StackOverflow, is a thing people want to do.

I can tell you from dealing with abuse that raising the bar even the
tiniest bit is very significant to stopping it.  Most recruiters are not
developers and they and spammers don't have Git installed.  They're
going to rely on Googling or other public search functionality, and this
makes that harder.

Greylisting is exactly raising the bar the tiniest amount and it's
extraordinarily effective.

> 5. Interaction with other systems
>=20
> Something I mentioned in the last 3 paragraphs of my [1]. I think you're
> only considering the cases where git itself does the mailmap
> translation, but we have 3rd party systems that make use of the format
> in good ways (also doing the Joe->Jane mapping). Making it a hassle for
> those systems makes it more likely that Jane doesn't get the mapping she
> wants.

This is an argument for never changing the format.  Sometimes things
change, and I don't want to avoid making a change because other
implementations haven't implemented it yet.  Under that approach, we'd
never have the SHA-256 work.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--sz0IGPO53E/11uA6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX/UDTwAKCRB8DEliiIei
gVx2AP4jw0eUv4fFL9Dh9JEa5dLE9JyPpmElfsvC9q2r4Hj6MwEAwneF6Qmb/DUW
VEaoO1U6BoiZRFK1gda+B9AgJlP54AI=
=XUHU
-----END PGP SIGNATURE-----

--sz0IGPO53E/11uA6--
