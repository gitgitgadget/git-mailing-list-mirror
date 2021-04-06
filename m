Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CEFC433ED
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 23:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D456061002
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 23:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237496AbhDFXPX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 19:15:23 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55992 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232039AbhDFXPW (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 6 Apr 2021 19:15:22 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B5E6D60422;
        Tue,  6 Apr 2021 23:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1617750914;
        bh=LAXuoZ3U1Ne3tdPo60IYAUHDrm7FVbqQoXjyGnywCvg=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ek8X8WYt/JlBKrEYbiY/MgKc4uFI8w1Mjq1PPmHGTL9aIBhVi+jhlZlgHBZbLaStI
         XyeBMf4Aw0+YePgSwU7+Wvv83L5pIScdXmrKnU8qQHDE6Tl9tlEDVlJxpTapE6QUXz
         ADdmAHV9nEmbMT71NBV3UGkhGammnEqDdokMbZDxNElf8O+3G8h0V4saRePJozvUK2
         OAFHU/f6GQ53nWkToeAl0daSopFZu5v3jpTYJbSW/r3NKMpHyqtYmeM5q+E/F6PaNw
         DGblg3MtoQO8nfuu8Zn2aMFudrG1Fp1dsWSiV50Gg084P/72FHzGgMQe1P4Qmz2hPv
         8kAliKZwjRQOtcikXqfTzCU2ghcli/JFYSkkNcakJzv6ePeeL9uuEqXrv3CKhPnRXD
         wz0XBK5F3CwR4ZxXoXJkNMcYwqAhOiCjcpwBYpLyG5roF2PwAjBAKl30xM4hpm4lLQ
         Q7H8k+zr8AA4lmu9J4wsIZoNDNaJ4mcb0O2gd5yCFKpBYw8Z8KU
Date:   Tue, 6 Apr 2021 23:15:09 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Albert Cui <albertqcui@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Albert Cui via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] hooks: propose project configured hooks
Message-ID: <YGzrfaSC4xd75j2U@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Albert Cui <albertqcui@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Albert Cui via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
References: <pull.908.git.1616105016055.gitgitgadget@gmail.com>
 <pull.908.v2.git.1616723016659.gitgitgadget@gmail.com>
 <ec031dc8-e100-725b-5f27-d3007c55be87@gmail.com>
 <CAMbkP-S-9cccMpU4HG0Wurqap-WkTmD2zk50nKd9kJ_oWO__qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0j8bA8SpW4tyKTHE"
Content-Disposition: inline
In-Reply-To: <CAMbkP-S-9cccMpU4HG0Wurqap-WkTmD2zk50nKd9kJ_oWO__qw@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--0j8bA8SpW4tyKTHE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-04-05 at 22:45:10, Albert Cui wrote:
> Right, this entire proposal is trying to get to a "Git-blessed" solution,
> and I should make the need clearer. A few reasons for standardizing
> this come to mind:
>=20
> 1. Many existing "standard" solutions. A multitude of existing solutions =
for
> this use case speaks to the fact that a basic config script is not suffic=
ient.
> I mentioned Husky above, but here are a few more; basically each
> popular programming language environment has a solution for this.
>=20
> https://github.com/sds/overcommit - Ruby
> https://github.com/pre-commit/pre-commit - Python
> https://github.com/Arkweid/lefthook - Go
> https://github.com/shibapm/Komondor - Swift
> https://github.com/typicode/husky - Node
>=20
> These solutions all handle the installation and updating of hooks. A
> "configure-hooks.sh" script doesn't handle hook updates, unless you go th=
rough
> the trouble yourself of implementing and maintaining that.

I think part of the problem is that an automated process to update hooks
is generally a security vulnerability, since it means that untrusted
remote code will automatically run on your computer.

I want to be clear that I understand the desire for this feature, even
though it's not a feature I would personally use, and the fact that
there are many approaches means that clearly there are many people that
do want this functionality.  I have in the past shared hooks with others
and we have mutually benefitted enormously from that fact.  My concerns
here are solely about the security aspects of this feature.

> 3. Improving security. As you mentioned, hooks are difficult to get
> right from a security
> perspective, and standardizing on a single implementation allows us to
> give developers
> a well-vetted solution with a better security model than what exists
> today. For example,
> we're proposing making it very clear to users whenever there's a hook
> update. This isn't
> something that existing solutions do.

I don't think this materially improves security.  All of these options
have the same security problems, and that's inherent in the solution.
What we're doing here is basically giving people a built-in feature that
is the equivalent of piping curl to bash and blessing it as secure when
it's not.

> I'll also say in general, the Git project is much more likely to get
> security right than smaller
> projects, where oftentimes even popular projects end up unmaintained.

I agree that Git tries to be careful about security.  It is for these
reasons that I think Derrick and I have provided you the feedback we
have here.

> Agreed. We already did a security review internally at Google. The main
> feedback was:
>=20
> * We need an explicit opt-in opposed to setting hooks up automatically,
> e.g. a command line flag like --accept-hooks at minimum. This is primarily
> to distinguish people who are just cloning a repository to browse the code
> from people who are developing.
>=20
> * The average user doesn't have the ability to review hooks in general
> (security is hard and obscuration is easy), and if the user has
> already opted into
> this feature because they are engaged in development, it's very likely
> that they're
> already running build scripts, so the additional attack vector here doesn=
't seem
> like a big issue.

I think you've hit the nail on the head here, but drawn a mistaken
conclusion.  The average user doesn't have the ability to review hooks
in general and therefore cannot make an informed decision about whether
to enable them, so the behavior we need to have is not to lead them to
doing things which are risky from a security perspective.

If my goal is to just build a product and not to run its tests, which I
do with a decent number of projects, then I can audit a Go or Rust
project trivially and determine if it executes arbitrary code or not
during the build process and if so, inspect it and gain confidence in
it.  In fact, there are many projects which don't execute build scripts
during the process, and therefore which are completely safe.  This hook
design changes that calculus dramatically.

I also want to point out that people clone repositories for a variety of
reasons.  At GitHub, every team has its own repository with
documentation.  Literally every employee at the company, regardless of
role, interacts with a Git repository, even people who do normally
nontechnical tasks such as our in-house lawyers and our event planners.
Many of these people are nontechnical, and almost none of these
repositories has any software development involvement.  There are also
numerous people elsewhere who may work on projects such as books or
other non-software in repositories who are nontechnical.  Under the
current model, the biggest problem these people face is accidentally
corrupting their local repository and losing data.  With a design that
prompts them to install hooks, they face the possibility of arbitrary
code execution.

The reason I proposed the FAQ we have in our documentation is because I
answer a decent number of questions on Stack Overflow, in addition to
questions that involve users that I get pulled into at work.
Overwhelmingly, the vast majority of users, even developers, are not
completely comfortable with Git and are unsure about how to use it
effectively (cf. https://ohshitgit.com/).  If we propose to a user that
they should do something like enable hooks by adding a prompt, many
users will automatically say "yes" because (a) they don't understand and
they trust that Git is prompting them to do something beneficial and (b)
because they don't know or care and just want to get on with their
lives.  As a result, we're exposing people to giant social engineering
attacks on behalf of potentially unscrupulous repository maintainers.

This is made worse by the fact that we will prompt users even when
cloning a repo that they have no intention of performing development on
means that we will have users who are misled here where otherwise
nothing would happen.

There is a huge problem with social engineering attacks and phishing on
the Internet today and I'm concerned that this is going in exactly the
wrong direction.

I would want to see a comprehensive security analysis feature taking
into consideration social engineering attacks, the skill level and
comfort with Git of the majority of Git users, and the fact that people
clone repositories for many reasons other than software development.
It's easy to look at this from the perspective of the typical employee
at a major tech company and assume that users are generally security
conscious, comfortable with Git, and primarily engaged in software
development on the projects they clone, but I'm not sure any of those
cases are generally true, and anyway there are many counterexamples in
the real world whose use cases we need to take into account.

I continue to have serious reservations about this series and approach,
and I'm not sure that any proposal we can adopt here will address the
security concerns.  To be frank, I don't think this proposal should move
forward in its current state or otherwise, since I think the security
problems are inherent in this approach and fundamentally can't be fixed.

This is, as should be obvious from my email address, my personal
opinion, despite my reference to my employer above.  Unless otherwise
stated, I don't speak for my employer and they don't speak for me.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--0j8bA8SpW4tyKTHE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYGzrfAAKCRB8DEliiIei
gWvaAQDqXSfcsdcfnpO6Vv4EmVykaWlvxHmcmeIGRAfOn55ulAD+K8uJAXXYOaZS
po8Kn7O8xiCoSWyZvGNYbDyyivJM6Ac=
=Z7/e
-----END PGP SIGNATURE-----

--0j8bA8SpW4tyKTHE--
