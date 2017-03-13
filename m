Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD9EE1FC43
	for <e@80x24.org>; Mon, 13 Mar 2017 18:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752493AbdCMSAo (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 14:00:44 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:34500 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751651AbdCMSAm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 14:00:42 -0400
Received: by mail-pg0-f53.google.com with SMTP id 77so66346824pgc.1
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 11:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GsnomfDgZ9YULYvqO5/zBCwOSSsi0EF6MlKdnzX1X+o=;
        b=S+Bvf4vT8QEcS5xXbV1NrbksbeXSU+88F2eTKA96GnDppWxBaInj4uQ6TA4woTicrv
         ZkrtQUF1EydMajpmzJrZGTmfHqjnK0dxjG6dAx8WVQbpG2oiLDofiJmtlossFS43PvoW
         m74gyC3Y84J/DlX1DBC3+b84+viHN5ANuI1wMDDHh5vFsad5N3hEnYh2wx+cy2gOIQgJ
         WOAzQ++ytNFbfPGDThz3gf6HV9Shl3TePYKVcw4onRb17fnLm7SE3eW2SsZ31Ufigtc5
         XVCj7PWBMA0u6w8sg0LDOGP8cu1kQGesJ5xzZV1T4q9sdVTDQ9Z9obwxq3k0HwT9JySh
         9KEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GsnomfDgZ9YULYvqO5/zBCwOSSsi0EF6MlKdnzX1X+o=;
        b=i0WnUvhj0+uqOS4AUdbs/XK/+BwTvl9mTWAWUwBkTybRs1ab8QmYrqK0Ta/tKkDWde
         jafJr+t+IY4pZMLedJiprD3JQzWHO0XmjhMajs6wgsD9k8zSsOa84zKPjwYQkn7eJpaJ
         BrMtJsYCbnJCyMbVJYZrbjYM0tkz+Jm31tgX6Lmx7yHbRIdfmifzu0U+7dN8hrWHV8WZ
         3UwvGA9NnA/ZpvysGolumXH2CrNfJSGhFAl8l+8kj24ZWaBYlTNi6RM/fSV13x++N28C
         JOYt/u+Ht5Z2kSsMMZ9pWn6BzeFbgO/w+AdPwL1/hO68eJjVuq1o/ewAbSRlFdYh6PET
         Xinw==
X-Gm-Message-State: AMke39m3qNCgqd5s11y9TwBX70ZJmV84873qLPasaDwBeuWUtep1L19i5FQeVh1gMjrHLg6k0ZnIqYFtAoXJprRl
X-Received: by 10.84.195.129 with SMTP id j1mr48693337pld.88.1489428041295;
 Mon, 13 Mar 2017 11:00:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Mon, 13 Mar 2017 11:00:40 -0700 (PDT)
In-Reply-To: <20170312124725.ogwame2nm72maffy@sigill.intra.peff.net>
References: <20170309193050.19988-1-sbeller@google.com> <20170310181342.GE26789@aiede.mtv.corp.google.com>
 <CAP8UFD0xCCcmd66ChsfxPBFohekucBx3ib4Ayi+KQOXNZFHMjQ@mail.gmail.com> <20170312124725.ogwame2nm72maffy@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 13 Mar 2017 11:00:40 -0700
Message-ID: <CAGZ79kYedz+r-f7HbDiQR6bfUoUK8LL6g42vO=9uGwHtcPkmhg@mail.gmail.com>
Subject: Re: [RFC PATCH] help: add optional instructions for reporting bugs
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 12, 2017 at 5:47 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Mar 10, 2017 at 10:50:50PM +0100, Christian Couder wrote:
>
>> I don't think it's a good idea to add those "hint: ..." and
>> "reporting-bugs: ..." lines.
>>
>> I think it's better to do things like the following:
>>
>> - add `git version -h`
>> - add proper documentation for `git version` so that `git help version` works
>> - in `git help version` talk about the REPORTING BUGS section in `git help git`
>> - add `git version --full` or other such options to also print other
>> stuff like the current OS, processor architecture, libc, etc
>> - suggest in `git help version` and/or in the REPORTING BUGS section
>> in `git help git` that people just copy paste the output of `git
>> version --full` in their bug report
>
> I wonder if a "gitbugs(7)" manpage would be a good thing. Then "git help
> bugs" would find it.
>
> That still leaves open the question of whether people would find that
> documentation, but at least it is less buried than being at the bottom
> of the git(1) page.

To do it right(tm), I assume we have all of the mentioned ways;
all of them pointing at the same document.

I am on the fence if we want to have a gitbugs and gitversion man page,
precisely because I'd expect these instructions to be overwritten
by downstream users (e.g. all of the 255 linux distributions would put
their own bug tracker there, iff they carry additional patches; so would
we internally as we do have a couple of patches on top of next.)

It might be not as bad for git as it is for the kernel with tainted modules
such that my worries may be unreasonable.

Thanks,
Stefan
