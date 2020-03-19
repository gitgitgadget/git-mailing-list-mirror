Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EBBC4332B
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 23:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59FAC20740
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 23:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="mSzMDgo+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgCSXtl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 19:49:41 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57636 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726663AbgCSXtl (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 19 Mar 2020 19:49:41 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4CB276077C;
        Thu, 19 Mar 2020 23:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1584661779;
        bh=FNvPga+JmqAlSkmRZyAxirDrMlVr46QsTtA/vFeJ9Is=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=mSzMDgo+4j7xzV1UpXIKwOY1WQhJ04bBINI3j1kRjj9s+JOGlF81J4QX3iMtE+Ym8
         bqACYeb52V342r1RZe41TuXjEu1xaErVpf/DGYk2lUcWxUmM15Qd2C1LEkE0VsltgY
         kH1mhqVsAo/gfko2ZcFDsBiC8mT5V9HccG7AO3wNijttVin39ozCGrpp+c75CiSQ/k
         ij/jT/8aJyBf+Jsm0euEphi2mjl8xeCzosZEOeNBcRs+KCCguermWbnsD6xWqaFAvQ
         2MDAlzJpnZIR4/2FngcZunhYdq/ZSyry2jn11AmXgb5K7+VVhKGcDVRYYsC2YuuIXT
         eL7ucRW5Pbl6BcwuVXrlHzw4hyXT04Gnk3wz+tZgcaVsFW3hL/fefCQEL7aB1/cYj7
         BixvnimsqzPSB8hHXH6Mt80iU9zdkjBtPco+Mp3GVApXpJD1KgX6O8zj3E4estyYg3
         x6WKFzoFg7M72O3qbUck+WrsYRpXJhtbet1NcUKgHlbL/UihMCO
Date:   Thu, 19 Mar 2020 23:49:34 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/1] docs: add a FAQ
Message-ID: <20200319234934.GF366567@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20200315223923.170371-1-sandals@crustytoothpaste.net>
 <20200315223923.170371-2-sandals@crustytoothpaste.net>
 <20200318230030.GA45325@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ls2Gy6y7jbHLe9Od"
Content-Disposition: inline
In-Reply-To: <20200318230030.GA45325@google.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Ls2Gy6y7jbHLe9Od
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-03-18 at 23:00:30, Emily Shaffer wrote:
> On Sun, Mar 15, 2020 at 10:39:23PM +0000, brian m. carlson wrote:
> > Git is an enormously flexible and powerful piece of software.  However,
> > it can be intimidating for many users and there are a set of common
> > questions that users often ask.  While we already have some new user
> > documentation, it's worth adding a FAQ to address common questions that
> > users often have.  Even though some of this is addressed elsewhere in
> > the documentation, experience has shown that it is difficult for users
> > to find, so a centralized location is helpful.
>=20
> It's true that some of it is duplicated; if we're worried about the info
> getting out of sync, we might be able to do something like
> Documentation/config so we're pulling in a single piece of text to both
> places.

I'm not worried about this, since most of it has been this way for a
long time.

> > +[[user-name]]
> > +What should I put in `user.name`?::
> > +  You should put your personal name; that is, the name that other huma=
ns call
> > +	you.  This will be the name portion that is stored in every commit yo=
u make.
>=20
> I like the direction but I think it is still a little unclear. Other
> humans call me Emily, but I want to put "Emily Shaffer" in my user.name.
> I wonder how we can suggest full name in a way that's as universal as
> "the name that other humans call you"? I think I got around to this
> point by using examples when covering the SOB in MyFirstContribution, so
> I don't have a good answer off the top of my head.

Yeah, this is tricky, since in many contexts the phrase "full name"
implies using the entirety of every part of your name, and most people
with middle names don't put them in the "user.name" entry.  Yet we want
it to be appropriate for people across a wide variety of cultures.

Maybe we should say something like this:

  You should put your personal name, generally a form using a given name
  and family name.  This will be the name portion that is stored in
  every commit you make.

Many cultures have a given name and a family name of some sort.  If we
wanted to provide an example, we could use Junio:

  For example, the current maintainer of Git uses "Junio C Hamano".

> > +[[http-postbuffer]]
> > +What does `http.postBuffer` really do?::
> > +	This option changes the size of the buffer that Git uses when pushing=
 data to
> > +	a remote over HTTP or HTTPS.  If the data is larger than this size, l=
ibcurl,
> > +	which handles the HTTP support for Git, will use chunked transfer enc=
oding
> > +	since it isn't known ahead of time what the size of the pushed data w=
ill be.
> > ++
> > +Leaving this value at the default size is fine unless you know that ei=
ther the
> > +remote server or a proxy in the middle doesn't support HTTP/1.1 (which
> > +introduced the chunked transfer encoding) or is known to be broken wit=
h chunked
> > +data.  People often suggest this as a solution for generic push proble=
ms, but
> > +since almost every server and proxy supports at least HTTP/1.1, raisin=
g this
> > +value usually doesn't solve most push problems.  A server or proxy tha=
t didn't
>=20
> This might be burying the lede a little for someone frantically skimming
> for an answer. If I was really spinning my wheels I might read "People
> often suggest this as a solution for generic push problems" and go try
> it. Is "People often (erroneously) suggest this ..." too verbose?

No, I think that's a good answer.

> > +If you want to configure a general editor for most programs which need=
 one, you
> > +can edit your shell configuration (e.g., `~/.bashrc` or `~/.zshenv`) t=
o contain
> > +a line setting the `EDITOR` or `VISUAL` environment variable to an app=
ropriate
> > +value.  For example, if you preferred the editor `nano`, then you coul=
d write
> > +the following:
> > ++
> > +----
> > +export VISUAL=3Dnano
> > +----
>=20
> I'll swallow my pride as a Vim user here and say that I think 'nano' is
> a good choice to reference directly here; it seems to fit right into the
> experience level this particular Q is targeting. Nice.

I'm also a Vim user, but I took this idea from Debian, which uses the
options nano, nano-tiny, and vi (in that order) for its sensible-editor
utility if the user hasn't specified an editor any other way.  In any
event, the user can extrapolate from the example if nano isn't to their
tastes.

> > +[[ignore-tracked-files]]
> > +How do I ignore changes to a tracked file?::
> > +  Git doesn't provide a way to do this.  The reason is that if Git nee=
ds to
> > +	overwrite this file, such as during a checkout, it doesn't know wheth=
er the
> > +	changes to the file are precious and should be kept, or whether they =
are
> > +	irrelevant and can safely be destroyed.  Therefore, it has to take th=
e safe
> > +	route and always preserve them.
> > ++
> > +Some people are tempted to use certain features of `git update-index`,=
 namely
> > +the assume-unchanged and skip-worktree bits, but these don't work prop=
erly for
> > +this purpose and shouldn't be used this way.
>=20
> Not really on topic for this particular paragraph, but there are a lot
> of instances of "Some people ..." - in general, would it be less
> combative to say something like "It's tempting to..." or "It might seem
> like a good idea to..."? That way it feels less like "there are people
> who do X and they are wrong" and more like "X might seem like a good
> idea but it isn't". Or to put it another way, let's attack the bad idea,
> not the people who suggest it.

Sure, I think that's a good idea.  Thanks for the suggestion.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--Ls2Gy6y7jbHLe9Od
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXnQFDAAKCRB8DEliiIei
gRtsAQCEVKlH6QJHzPg5ExNckyOPXbYdMx99mDcqR6f3IQo37gEAvuXj5/F7eI7a
jwNiHcA6O9HYd74bDlSVX+4BZRC9TQw=
=OHHA
-----END PGP SIGNATURE-----

--Ls2Gy6y7jbHLe9Od--
