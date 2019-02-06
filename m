Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64F5D1F453
	for <e@80x24.org>; Wed,  6 Feb 2019 12:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729063AbfBFMVG (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 07:21:06 -0500
Received: from mout.gmx.net ([212.227.17.22]:36091 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726957AbfBFMVG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 07:21:06 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MZxch-1gYKRZ1PnL-00LjHQ; Wed, 06
 Feb 2019 13:20:50 +0100
Date:   Wed, 6 Feb 2019 13:20:47 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] doc-diff: don't `cd_to_toplevel`
In-Reply-To: <xmqqimxyrs4w.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1902061303570.41@tvgsbejvaqbjf.bet>
References: <20190203230152.GA25608@sigill.intra.peff.net> <20190204205037.32143-1-martin.agren@gmail.com> <20190204233444.GC2366@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1902051050090.41@tvgsbejvaqbjf.bet> <xmqqimxyrs4w.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:L1Ua2+Fn+eOi3PU5GIJwpS0HrciPy6WF/NDJ6AeFhSknapEZUK9
 d75Eb1LyiNlG/UKhVtaHOdKJ4D2T0b9agpevEaZ440koyQYol14/ABHkiAaiE11pm/vBYre
 dQMq/82tydLo2FtPI8NoOLGBYNHB2XjIOiTfCVh9qkxfA2PDeMZYQNQ5NePFUQ1+1s4KwUT
 zMlPRyyE4YXE/mFsu5BWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eCCYbpcBaKo=:V5VQ6pBSSGZ88O0tjjg06g
 lJfk4xbalM8joS5wAdQqc2FgIOFFL7A8PmDszb6ZSp8rp+NwpdcU+ObXrSa11jI4nLBB3+6ZD
 qFb+DaaVrGvBYnV20NLdGLZG9Ff5vgm7TGIBfpSIs7Ym8sGzIF0/2JVeMcBl6EGxgX4L2nTAX
 meADq+smUdVI5IG8Zaa5fXCzXD749/VwgxwolWnKj4qzKKrRZby2GwrfOo1LCQ+5PH2C1KY82
 Ipw9pqV7zvcrYjHZIUb/U+91Sw+V0BiM/BXUWrEp+Kr8Kvk4OXd/3fQ+7999hoSPwqHvDgTt2
 G31pDBq22V8j+pwXeXVRX5S8HeQkruIggusDKdgTA5uJ/Ey6MBb04MZOjWRReCmSjF7dI84ES
 DFqrIKUCXPCoE6YfG9LUAovwOOsWSBybmSoSXPohGi0gOXEcPmV2cK3fck7Kgr7o0Rg4ZtynI
 pXNDqspkCuSHn+NKuWgw4yROlvJejb8P/pa2nFEcCLD9FjOZCCRU+2cj4wu2qHBveLhO8MRm5
 bKbb/B6et7oQaL8t1ra0Epb5bgKO2Jw6eCk2UzWw1HzCg09NTshn2hkIarR8A2jMnv/mFwsGV
 geCYQkEXl4g7UGxDuHfhN7PkpbGlaXLg+YjjUZbbVzZBy5r8G0VuUiG82jjRVCPcc5rv/9lzc
 b1v+8e9GB0MxmubMe/kbj459xl2xUIqxml7lPgZAhLyTqxXQgbFd3BC/KzGndwCSHsL6lygp3
 Sb6OJhQKZGlMJczI6pIBNh9BIKakibG7NNK2ydzGJo0jCH3ltaczYKVtc/5wxJYyY5J8bOjr+
 R0fuJ93G+O/Bw0scJX6X0wnb4OFOy2kBqYPshI5UgRk06cZIqFy9sNe5rxvt73uv8a5agYoXK
 HIwBN4dq0PWNui+pFk6d0LdMYtczgaNQelt2W6GFpocdQOf7B75VowPykHwMcMgK04y2OB6jT
 1KzyT+YBu0g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 5 Feb 2019, Junio C Hamano wrote:

> I am wondering if the automated testing can be made more useful by
> limiting the scope of testing if it is run on individual topic.  For
> four primary integration branches, we do want to ensure all tests keep
> passing (or at least no tests that passed in the previous round start
> failing), but it would match the topic-branch workflow better if the
> automated testing allowed an individual topic to rely on unrelated known
> breakages to be dealt with by other topics and newer integration
> branches.

It is a known technique to use code coverage to inform automated test runs
which tests (or test cases) to run, but our code base is not yet
conducive to that approach: we use too many scripts (try to determine code
coverage for scripts, will ya?), and you cannot really cherry-pick which
test cases to run: despite `test-lib.sh` offering the `--run=<range>`
option, our test cases frequently rely on side effects by previous test
cases in the same script.

So that obvious strategy simply is unavailable to us, at least at the
moment.

> For a topic like doc-diff that is primarily meant for developers and
> documenters, it does not matter much, but for an old but important bug,
> forking the topic to fix it at a point close to the origin is
> crucial---that is what would allow people to merge the fix to an older
> maintenance track, without cherry-picking.  It is especially true when
> the bug being fixed is more severe than unrelated breakages that have
> been fixed since then.

As I said, I understand your reasoning.

> Possible approaches I considered and rejected are:
> 
>  - Perhaps find updated tests in the topic and run only those?  We
>    can complain a topic that is meant as a "fix" to something if it
>    does not have test while trying to find such tests ;-)  But this
>    does not work if a "fix" has unintended consequences and breaks
>    existing tests that do not have apparent relation known to the
>    author of the patch.

Indeed, and the test suite tries to catch exactly those unintended
consequences.

>  - Perhaps find the fork point, run tests to find known breakages
>    and exclude them?  This would simply be not practical, as it
>    doubles the number of tests run, for individual topic branches
>    because there are an order of magnitude more of them than the
>    primary integration branches.

I saw another strategy in action: accept the base commit chosen by the
contributor, and ask to back-port it to previous, still supported versions
(unless an automated rebase managed to back-port already).

> Possibly, if we limit the fork point to tagged releases, the latter
> approach might turn out to be doable.  For ma/doc-diff-usage-fix,
> the base commit ad51743007 was v2.20.0-rc0~232, so we could round up
> and pick v2.20.0 as the base instead (the purpose of picking an older
> point is to allow merging to older maintenance track, and it is
> unlikely that people would keep using v2.20.0-rc0 as the base of
> their forked distribution).  Then if the automated testing keeps
> record of known breakages (whether they are later fixed or still
> broken) for these tagged releases, testing a new topic forked from
> one of them and deciding not to worry about breakages of tests that
> are known to be broken (or perhaps deciding to skip these tests in
> the first place) may become feasible.

I kind of do that already in the CI builds of GitGitGadget, but not for
all known fixed bugs.

The most prominent example is the lack of Windows Vista support in
current the Git for Windows SDK: a *ton* of your branches does not have
that fix, and I still wanted to have test coverage for those branches, so
I introduced this snippet:

  git grep _WIN32_WINNT.0x06 HEAD -- git-compat-util.h ||
  export MAKEFLAGS=CFLAGS=-D_WIN32_WINNT=0x0502

This will let those branches build.

Likewise, I added CI builds for all of your branches in gitster/git to
make it much easier to *act* on regression test failures.

As you can see, I am more than willing to pour an insane amount of time
just for the sake of not forcing you to change your work style, as it
seems to work for you and I would be the last person to ask anyone to
change anything that works for them.

In this instance, Peff remarked at the Contributors' Summit (BTW will you
attend any of those in the future?) that he would love to have "an
automated Ramsay", i.e. a bot that reacts on test failures, notifies the
author of the root cause, preferably with a patch. And all I thought when
I sent the mail that started this here sub-thread was that I could
demonstrate to Peff that it is not that easy (even if writing that script
that would determine the patch author upon a failure would be easy, now
even the bisect would be easy because we are working on linear topic
branches where you do not have to test 10,000 merge bases before testing
the 2 patches that could be the culprit).

Thank you, of course, for detailing your thoughts on that matter.

> I dunno.  Limiting fork points to tagged releases for topics that
> are meant for the maintenance tracks may have other benefits by
> restricting the shape of the resulting dag, so I am willing to try
> it as an experiment, whether it would help your workflow or not.

If you would like to experiment that, I'd like to learn the outcome. But I
do not strictly think that it is necessary.

Ciao,
Dscho
