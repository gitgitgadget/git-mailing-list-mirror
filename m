Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D794A1F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 23:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730396AbfJUXEf (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 19:04:35 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46731 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730069AbfJUXEf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 19:04:35 -0400
Received: by mail-ot1-f65.google.com with SMTP id 89so12497130oth.13
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 16:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=elK4UeOeZ4LVwS6B7VhUAHxx4kmlm+5bWivfVjxUuj8=;
        b=DULwQ9yF2BUSsGUGqk+gJfgI06S7SRJlzd/Eumq52E2foXDmRLd7m9/qg/wnIx8U1u
         N51lw0YCPCifRSTwM/YjecJl3pe2JWyc4Y3VOtk6lfo1Sgl/Q97mKHupBFHCYMwvm6wl
         PCHt+uQ7UdnJHdO1pYr8V5HoawGsOqM9755WjPTIprIdnBsFT6YpNATDNkxQc4luu0l+
         xUIENXx1HIqM2h69wPvdKggPz7DXRLzYpV5EQx+fT5hDYN5GdTQtBVh63v6/agpEaRv/
         OwOCHoCDHOMsyseBQWFwWjg5fLrICALhGuEIZ7XPQuRnfVnlLcBXfgK/GXG22VIoYDie
         iC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=elK4UeOeZ4LVwS6B7VhUAHxx4kmlm+5bWivfVjxUuj8=;
        b=uZGIrL6LSET3DZTEUwIJbtQXHGleWc3DW7/rkVY0bxHBXnQy3KQLqxXvVI9Ac0y7CO
         ISaDUPKInkRBkLBGkX1iS1evH4GSd835U1fAkFvA9qRDSxTo4K56EWkNtL4XNYTsb8Pn
         xyZX2IBnXWNaTWT3u4gqlOXaFzhhQ652wWHe8cr5fUzbT2GJUvqqU8w9edjJ9RLRbTQP
         RTiYPGJOoRt1NpggZQQaoK8uIEQwCfzHQm2gBpt0D0RBgzx/dO6YrGsljQwxwkhLAjVL
         p2iHxkDh7LLO5vLr9LXWA2pojWtGHqn44Hxv9e7vZnsjjEx3XoBbgFvVaC1Lyp/7ladc
         B05A==
X-Gm-Message-State: APjAAAWWkxztEl/V94l+vfACRI6Mmq151YV0+p++702pFK86/mqm/MpK
        DRp/VdwjQkdkBbiznbmCwn1RfJdCU0njJkfTTrw=
X-Google-Smtp-Source: APXvYqxrF6XbJVhDN6C3hVtYcx9I5gGaF9txp9vojW3PNTPzvHPlP76tkv8ODWZ6g2BSqJue9B9jNZ+C5jkICiRvRZ8=
X-Received: by 2002:a9d:4591:: with SMTP id x17mr298384ote.112.1571699073654;
 Mon, 21 Oct 2019 16:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq4l065zx5.fsf@gitster-ct.c.googlers.com> <c554383b-b569-79f8-88f6-7017be76da9d@gmail.com>
In-Reply-To: <c554383b-b569-79f8-88f6-7017be76da9d@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 21 Oct 2019 16:04:22 -0700
Message-ID: <CABPp-BG0Vrdo_w-e270oauLwHoLyaiTHKpfOwgLNBoeikoqq-g@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.24.0-rc0
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 On Mon, Oct 21, 2019 at 1:50 PM Derrick Stolee <stolee@gmail.com> wrote:
> I ran a few of the performance tests against the Linux repository
> using v2.22.0, v2.23.0, and the new v2.24.0-rc0. I thought it worth
> pointing out that the drastic performance improvements are due to
> turning on the commit-graph by default. I had computed a commit-graph
> for my Linux repo, but used my global config to enable core.commitGraph.
> The global config is ignored by perf tests, so v2.22.0 and v2.23.0 were
> operating without looking at the commit-graph.
>
> (These were run on my old dev machine, which is now running Ubuntu on
> bare metal. No VM this time!)
>
> Test                                                          v2.22.0               v2.23.0                     v2.24.0-rc0
> ----------------------------------------------------------------------------------------------------------------------------------------
> 0001.1: rev-list --all                                        6.01(5.73+0.28)       5.99(5.73+0.25) -0.3%       0.97(0.80+0.16) -83.9%
> 0001.2: rev-list --all --objects                              40.40(39.86+0.54)     40.22(39.59+0.62) -0.4%     35.28(34.75+0.52) -12.7%
> 0001.3: rev-list --parents                                    6.11(5.83+0.27)       6.07(5.82+0.25) -0.7%       1.03(0.86+0.16) -83.1%
> 0001.5: rev-list -- dummy                                     0.64(0.58+0.06)       0.66(0.59+0.07) +3.1%       0.34(0.29+0.05) -46.9%
> 0001.6: rev-list --parents -- dummy                           0.66(0.60+0.05)       0.67(0.62+0.05) +1.5%       0.36(0.32+0.03) -45.5%
[...]
> 4211.2: git rev-list --topo-order (baseline)                  6.32(6.04+0.28)       6.30(6.09+0.21) -0.3%       1.15(0.96+0.19) -81.8%
> 4211.3: git log --follow (baseline for -M)                    8.58(8.43+0.14)       8.56(8.41+0.15) -0.2%       3.67(3.53+0.13) -57.2%
> 4211.4: git log -L (renames off)                              32.79(30.68+2.10)     32.80(30.69+2.11) +0.0%     27.17(25.24+1.93) -17.1%
> 4211.5: git log -L (renames on)                               212.64(210.39+2.24)   213.48(211.26+2.20) +0.4%   27.38(25.53+1.84) -87.1%

Many nice speedups here, not just commit-graph (the rev-list cases)
but also log -L (from sg/line-log-tree-diff-optim, I believe), and log
--follow.  I'm curious if the log --follow speedup comes from sg's
series or something else...

> 0001.9: rev-list --objects $commit --not --all                0.08(0.05+0.03)       0.08(0.05+0.03) +0.0%       0.09(0.07+0.02) +12.5%

Looks like this one increased too, with a similar magnitude to the
7300.2 you pointed out.  But the base is kinda small; is this just
noise?

> The tests below are some that I don't run very often, but seemed
> interesting. Interesting that rebase got a lot faster!
>
> Test                                                            v2.22.0               v2.23.0                     v2.24.0-rc0
> -------------------------------------------------------------------------------------------------------------------------------------------
> 3400.2: rebase on top of a lot of unrelated changes             18.86(17.80+1.71)     18.80(17.80+1.66) -0.3%     2.63(2.49+0.79) -86.1%
> 3400.4: rebase a lot of unrelated changes without split-index   68.00(62.32+5.04)     68.50(62.34+5.30) +0.7%     45.25(41.37+4.18) -33.5%
> 3400.6: rebase a lot of unrelated changes with split-index      46.39(44.89+2.19)     46.24(44.66+2.30) -0.3%     25.00(24.49+1.23) -46.1%

I'm also curious what change it was that made these rebase tests faster.

> 7300.2: clean many untracked sub dirs, check for nested git     1.36(0.54+0.81)       1.35(0.51+0.82) -0.7%       1.53(0.62+0.90) +12.5%
[...]
> Any thoughts on 7300.2? Seems to not just be noise, or maybe it is?

Well, en/clean-nested-with-ignored is a very likely the cause of any
performance difference here, but given the nasty bug it was fixing
(see sg/clean-nested-repo-with-ignored topic), the performance change
is totally warranted if necessary for the fix.  And it looks like that
test is exercising one of the areas of logic that my series was
modifying (namely the clean -fd case in conjunction with the
possibility of nested .git dirs).

That's enough for me to accept the performance change.  If soemone
else wants to dig a little further to determine whether this perf
change was part of the important fix or just due to a separate change,
I'll provide a few pointers.  Assuming it's one of my commits, I think
it has to be one of the following three:

404ebceda01c ("dir: also check directories for matching pathspecs",
2019-09-17): if this one causes the perf change, I think we just suck
it up.

89a1f4aaf765 ("dir: if our pathspec might match files under a dir,
recurse into it", 2019-09-17): if this one causes the perf change, we
might be able to do something by somehow rearranging the if-block
logic.  Checking bits is going to be faster than calling the
get_dtype() function, but calling get_dtype() should be much faster
than calling do_match_pathspec().  Any change here would probably make
this if-block harder to read, but on the off chance it's the one
responsible for most the change, maybe it is worth it?

09487f2cbad3 ("clean: avoid removing untracked files in a nested git
repository", 2019-09-17): if this commit causes the perf change, I
think we could change the "else" block to "else if (force > 0)".
Actually, wait, 7300.2 uses -f so I don't think this can affect this
testcase.  If someone finds it strongly affects some other testcase,
we could look closer at that change.


Elijah
