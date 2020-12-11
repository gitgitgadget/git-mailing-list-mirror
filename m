Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEE0C433FE
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 02:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B517F23E54
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 02:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404734AbgLKC5m (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 21:57:42 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57962 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2403848AbgLKC5S (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 10 Dec 2020 21:57:18 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 96F9460769;
        Fri, 11 Dec 2020 02:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1607655397;
        bh=NQ9kANgg95sthEgPz9h5kp/YJWsSzeNZoUta1Q3w1V0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=DsvuxezHc9NDg61FsXTzNmUmtq+dJaqKz6Mp23JXNKlxCb6dlvXVSaYZsUGUkKCo6
         NmeI52upTGaiAOCsikubUaLtuqaG/sh7LoAhQR61UPaProHSoTafQyCHHgxf/8uW1X
         UcIKbEZq1COMnUXGKR4IoMpBQXFBqLfs7ZQJTSSMfeg7LCg5hljioyJ4Yre7V51OWa
         msE7H2Qu3ybLFIGJ5xYvBdKEq7VoDgOlSAUna3Uny4GgqmvQWQ7qfGRXuYOazyvP1K
         H+KqOOBC71ZpZTRdAhXkRHrlghfJQKUoTlbu42xuxZPmP1ZFlfCCmpF/JMyDzRGPno
         8sbBM93HVliHZ8gACYrbOKa8/vh0Bcl7fZIDeyooJLyu6kjmH5LrnXTJQQsklVwcKu
         +ughwl4yACJqTp4lHiiVc3+fVjBFNLdf9a1mGginACyHIWE95ZiK/c7VblpuYpuMFl
         YEi2jPXYt6RbwiTjdXL5ele4EP4nq+jFP6SqNIRwBLaSlSPaiWL
Date:   Fri, 11 Dec 2020 02:56:22 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        Aaron Schrab <aaron@schrab.com>,
        Denton Liu <liu.denton@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 1/2] Add project-wide .vimrc configuration
Message-ID: <X9Lf1p++YktzZMWe@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Emily Shaffer <emilyshaffer@google.com>,
        Aaron Schrab <aaron@schrab.com>, Denton Liu <liu.denton@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
References: <20201209065537.48802-1-felipe.contreras@gmail.com>
 <20201209065537.48802-2-felipe.contreras@gmail.com>
 <X9GbIG9vZbK1pEoi@camp.crustytoothpaste.net>
 <CAMP44s33J6F60W=2Yd2WSGE78VT0XBkewi8m3unXvathBH2TOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zvyZUAG8fIa2htdR"
Content-Disposition: inline
In-Reply-To: <CAMP44s33J6F60W=2Yd2WSGE78VT0XBkewi8m3unXvathBH2TOQ@mail.gmail.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--zvyZUAG8fIa2htdR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-12-11 at 01:08:00, Felipe Contreras wrote:
> On Wed, Dec 9, 2020 at 9:51 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > On 2020-12-09 at 06:55:36, Felipe Contreras wrote:
>=20
> > I don't think this should go in this location.  It should go in contrib.
> > Here's why:
> >
> > * We should not ship editor-specific files in the main directory of the
> >   repository.
>=20
> Why not?

Best practices indicate that we don't check in files which are specific
to a developer.  Anything that controls the specific editor people use
is by definition specific to the developer.  Checking in these files
leads to conflicts over which settings to apply and whose settings are
better when they could just be avoided.

If we have style policies, those should be expressed in a general,
universal way so that all users can take advantage of them in the same
way.

Furthermore, some editors want entire large directories of configuration
files in order to work correctly, which we don't want to include.

If we treat all editors in the same way, then every developer gets the
same experience when they work on our code.  If that experience is
inadequate, our time would be better spent improving it in a universal
way so that all developers can benefit.

> >   Even though Vim is very popular, it is one of many
> >   editors, and it is not even the most popular editor (which is now VS
> >   Code).
>=20
> Even if vim is not the most popular, it certainly is among the top 3
> (and I doubt VS Code is the most popular, I would like to see some
> numbers on that, but even then; VS Code is not an editor).
>=20
> Nobody is arguing to have editor-specific files for "every editor
> under the sun", just perhaps 2 (or maybe even 3).
>=20
> No slippery slope fallacy here.

Because we don't need them.  Your solution requires the user to
configure Vim with a plugin _and then_ allow the specific directory in
order to be secure, which means it doesn't work with worktrees.  It also
requires that the user never pull an untrusted branch into their
repository.  It also has other undesirable effects which I mentioned in
my original email.

The .editorconfig file also requires a user to configure a plugin, once,
and then things automatically work in a secure way across projects.  In
other words, the existing solution requires a user to affirmatively act,
but with less effort, less potential for security problems, and better
cross-project support.

So the .vimrc solution requires more effort, has more potential security
problems, is less flexible, is less like how other projects solve this
problem, and is less general.

> >   We have editor-independent files, and users can copy this into
> >   the root of the repository and ignore it if they want it there.
>=20
> Which are insufficient. They are certainly better than nothing. Plus,
> it's unclear how many people are actually using those.

Why are they insufficient?  Multiple developers are using them on Git
already.  They're used on projects from Microsoft[0], W3C[1], and folks
working on JSONPath[2].  They are the de facto standard for this
purpose.

In contrast, searching GitHub commits for ".vimrc" shows overwhelmingly
that the repositories in which these commits are named are called
"dotfiles".  I was unable to find any projects from major organizations
using this configuration style.

My general rule is that when I'm unsure what decision to make on a
project, I should make the decision that everybody else has made,
because users and developers will expect my project to work just like
everyone else's.

> And I'm still waiting for the argument against adding such a top-level fi=
le.
>=20
> What is the harm?

As mentioned, enabling the use of this file is still risky from a
security perspective because it precludes even pulling in an untrusted
branch and then spawning an editor.  We already have a more general
solution that is more widely adopted and has fewer downsides, so there's
no point in adding files which really provide little benefit over what
we already have.

If there's little benefit, we shouldn't carry files which are going to
be subject mostly to pointless arguments over personal preference.  The
fact that two heavy Vim users disagree so strongly over relatively
simple settings is an argument for not adopting this approach as a set
of project settings.

> > * Whether a user wants to use automatic indentation is a personal
> >   preference.  I do happen to like it, but there are others who don't
> >   and prefer to leave it off.  Similarly, whether to use cindent,
> >   smartindent, or autoindent is a preference, as is which cindent
> >   options to use (I use different ones).
>=20
> So?
>=20
> These options will not be forced on users, they have to specifically
> enable them by doing at least two steps, *and* they can still
> selectively override them in their ~/.vim files.

Right, but why are your preferred settings checked into Git as a project
setting?  They are objectively no better than my settings, which differ.
Absent a compelling reason that these settings are objectively better,
we should not endorse them as preferred project settings.

> > * These settings affect every file that's loaded in the same editor
> >   process.
>=20
> That is not true.
>=20
> :setlocal [1] applies the setting to the current buffer only, not
> globally, and *only* when the buffer is of the filetype specified in
> the autocommand.

So if I spawn an editor process using this .vimrc in my Git directory
and then I load an AsciiDoc file from a different repository into that
same Vim process, are you arguing that the Git settings will not be
applied to the AsciiDoc file from other directory?  I'm pretty sure that
Vim will in fact use the Git settings.  It's possible, however, that
I've misunderstood how Vim works.

=2Eeditorconfig doesn't have these downsides.

> > So while I agree that these are common settings, they are not
> > universally applicable, even for Vim and Neovim users, and we shouldn't
> > try to claim that all or even most Vim and Neovim users should use them.
>=20
> We don't. These are defaults, which a) the user must consciously
> choose to apply them, and b) can be easily overridden (as is explained
> in the commit message).

I'm arguing that they are not universal enough to be defaults.
Moreover, a set of defaults for how a user _could_ configure their
editor would belong in contrib, much like defaults for how a user
_could_ configure their MUA to send properly to the mailing list.

We already have files for Emacs and VS Code, and those live properly in
contrib, along with code for Thunderbird and alternative build systems.
If we're treating this proposal like existing code, it belongs in
contrib.

The .editorconfig file, on the other hand, doesn't express defaults.  It
expresses only project standards and doesn't specify any other settings.

[0] https://github.com/microsoft/fabrikate
[1] https://github.com/w3c/specberus
[2] https://github.com/jsonpath-standard/internet-draft
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--zvyZUAG8fIa2htdR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX9Lf1QAKCRB8DEliiIei
gTDYAP9Mqt1mr3WwOPzPOrADjp55+fixIiizeZVqvC/9jBjx1wEAkeslFRfawDZQ
JFnwGwN1A7a7eteNpeHOIhf700eHGgU=
=45Gu
-----END PGP SIGNATURE-----

--zvyZUAG8fIa2htdR--
