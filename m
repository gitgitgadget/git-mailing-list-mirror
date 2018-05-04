Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37AF31F42E
	for <e@80x24.org>; Fri,  4 May 2018 06:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750866AbeEDGwn (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 02:52:43 -0400
Received: from mout.gmx.net ([212.227.17.22]:60467 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750707AbeEDGwm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 02:52:42 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M1WHV-1eLz9Y0go5-00tWUq; Fri, 04
 May 2018 08:52:37 +0200
Date:   Fri, 4 May 2018 08:52:37 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH 02/18] Add a new builtin: branch-diff
In-Reply-To: <CAPig+cQv7tNCNhDdThhhDYEE=XmB0xO35Qjvpw+-MgCg0W3ovQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1805040843050.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <8bc517e35d4842f8d9d98f3b99adb9475d6db2d2.1525361419.git.johannes.schindelin@gmx.de> <CAPig+cQv7tNCNhDdThhhDYEE=XmB0xO35Qjvpw+-MgCg0W3ovQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:6go4kctTvaXTX3Hj4NakKuLZB4OFEUraRZ/X19p/VTKo/SkRSEj
 e9fVQAeKT7BGRbZ32KlAn+C/B6LTm6xkYEfNuU09yjgcJmz9KFiVdByXZ6cx4ESbW3vpTg3
 ByuvzY/xjwPpb/TrVPjecVjjRJp1iLA2Bp5li/rT5ZfglStn053v0CriEhbW24cSugcpTj+
 gK2R/PLOvXjAiDWx8tDtA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZG/6UBbEGHo=:rEcx0Q/90DX/71bmsYP0RL
 NyR0BVuxKwt7Z0ozL1SYVJXR5Aw1NWgE9gq9u+OzRsB5eX8wXYVVD2DFUMWGEOnaiunxsYBkD
 lrbCflDARX6eOZCA0vBPH9JRAq3eSLM+5iE38I2C+qt/cLrkS9xipreSFKnS8fHrc50aX77yr
 OwjIzKP0xP3ZtjOQigbGDwBHkqmFbQlypMAxQJfdeoolvC+SbVBYHk0kgQPf82+jRqYHvSYJj
 L0TKE5TrQkUhn2clVU07J9tMLMRx4CCB6N/3ChtkGlL8sUKN+Px/udMchq8Z+GrEeKaj5//5u
 Be4wUlp06L8qY935K/1rybnKdtX4Gs18W17I70PaDNk3eG9R/iCY6D3S99wYtUgeF7qtpNycD
 8zkJ/Ojvea+ZCTh8mf4u7leXnHzpNS2CD7UKIMExEBcEY5K6JSdk312ozdSfgeuo1o+wDJJfc
 fd5hHx/zkPJDx/IAZ6OgvRVmR1qXyic9sQnlpEB3qb68Nlh3xURlL9EvpkAozSmCutEyHB/Ue
 PBbj+4hLoPXxqXi6cGITD0/RsG8h8ZVgb5pLU02UNUoU+nIkXyx6RMfJJvZCnZnuRxe3gICxT
 8BBEa6GrvePiYuQYW+FX2YhgVoIwKmC5cUVWTtUlr1bYFcwDR+RvKzgU4rF/GAYCtJkaZMqZS
 TYGpoyRbjEME5oiQxY5wsXwPkQtF85S5PjSgKTT7dy/V9IL5O8kjSFEae4yxTBjPGyzl1PtKd
 QqVWR8675XTmFtOYU2B+FXoApUCcbuq19cQfDWE8mRyRahrjLxd7iSWl8WTNoZYiFhVAyMm+L
 azprRpU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Thu, 3 May 2018, Eric Sunshine wrote:

> On Thu, May 3, 2018 at 11:30 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > This builtin does not do a whole lot so far, apart from showing a usage
> > that is oddly similar to that of `git tbdiff`. And for a good reason:
> > the next commits will turn `branch-diff` into a full-blown replacement
> > for `tbdiff`.
> >
> > At this point, we ignore tbdiff's color options, as they will all be
> > implemented later and require some patches to the diff machinery.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > diff --git a/builtin/branch-diff.c b/builtin/branch-diff.c
> > @@ -0,0 +1,40 @@
> > +static const char * const builtin_branch_diff_usage[] = {
> > +       N_("git rebase--helper [<options>] ( A..B C..D | A...B | base A B )"),
> > +       NULL
> > +};
> 
> The formatting of "<options>" vs. "base" confused me into thinking
> that the latter was a literal keyword, but I see from reading patch
> 3/18 that it is not a literal at all, thus probably ought to be
> specified as "<base>".

Good point. Or maybe BASE?

Or I should just use the same convention as in the man page. Or not, as
the usage should be conciser.

This is what I have currently:

static const char * const builtin_branch_diff_usage[] = {
N_("git branch-diff [<options>] <old-base>..<old-tip> <new-base>..<new-tip>"),
N_("git branch-diff [<options>] <old-tip>...<new-tip>"),
N_("git branch-diff [<options>] <base> <old-tip> <new-tip>"),
NULL
};

Thanks,
Dscho
