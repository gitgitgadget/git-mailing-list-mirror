Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F114C215F4
	for <e@80x24.org>; Tue,  1 May 2018 12:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755845AbeEAM4e convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 1 May 2018 08:56:34 -0400
Received: from mut-mta1-se01a-zose1-fr.yulpa.io ([185.49.21.248]:43736 "EHLO
        mut-mta1-se01a-zose1-fr.yulpa.io" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755015AbeEAM4b (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 May 2018 08:56:31 -0400
X-Greylist: delayed 1952 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 May 2018 08:56:31 EDT
Received: from zose-mx-out01.web4all.fr ([185.49.20.46] helo=zose-mta-hub-out-web-02.w4a.fr)
        by mut-mta1-se01b-fr.yulpa.io with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <matthieu.moy@matthieu-moy.fr>)
        id 1fDUK2-000Izn-3e; Tue, 01 May 2018 14:23:55 +0200
Received: from localhost (localhost [127.0.0.1])
        by zose-mta-hub-out-web-02.w4a.fr (Postfix) with ESMTP id A68B8140EB5;
        Tue,  1 May 2018 14:23:10 +0200 (CEST)
Received: from zose-mta-hub-out-web-02.w4a.fr ([127.0.0.1])
        by localhost (zose-mta-hub-out-web-02.w4a.fr [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id AtjViVmUxuHF; Tue,  1 May 2018 14:23:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zose-mta-hub-out-web-02.w4a.fr (Postfix) with ESMTP id DA187140EBF;
        Tue,  1 May 2018 14:23:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zose1.web4all.fr
Received: from zose-mta-hub-out-web-02.w4a.fr ([127.0.0.1])
        by localhost (zose-mta-hub-out-web-02.w4a.fr [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qi8VrbiGxVNJ; Tue,  1 May 2018 14:23:09 +0200 (CEST)
Received: from zose-store11.web4all.fr (zose-store11.web4all.fr [10.101.13.41])
        by zose-mta-hub-out-web-02.w4a.fr (Postfix) with ESMTP id B6CB0140EB5;
        Tue,  1 May 2018 14:23:09 +0200 (CEST)
Date:   Tue, 1 May 2018 14:23:51 +0200 (CEST)
From:   Matthieu Moy <git@matthieu-moy.fr>
To:     Eckhard =?utf-8?B?TWFhw58=?= <eckhard.s.maass@googlemail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Ben Peart <peartben@gmail.com>
Message-ID: <1652522802.213664.1525177431907.JavaMail.zimbra@matthieu-moy.fr>
In-Reply-To: <20180501114316.GB13919@esm>
References: <c466854f-6087-e7f1-264a-1d2df9fd9b5a@gmail.com> <50c60ddfeb9a44a99f556be2c2ca9a34@BPMBX2013-01.univ-lyon1.fr> <907020160.11403426.1525172946040.JavaMail.zimbra@inria.fr> <20180501114316.GB13919@esm>
Subject: Re: [PATCH v2] wt-status: use rename settings from
 init_diff_ui_defaults
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Mailer: Zimbra 8.8.7_GA_1964 (ZimbraWebClient - FF59 (Linux)/8.8.7_GA_1964)
Thread-Topic: wt-status: use rename settings from init_diff_ui_defaults
Thread-Index: gJxySd6vaUYd+o1z6Ez3ffAVpT+wZA==
X-Originating-IP: 185.49.20.46
X-SpamExperts-Domain: zose1.web4all.fr
X-SpamExperts-Username: 185.49.20.46
Authentication-Results: yulpa.io; auth=pass smtp.auth=185.49.20.46@zose1.web4all.fr
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.02)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5s+9ULsWKKt+g80YTcatJT1602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvOzQLEduLAcXHFw1qMW9qI5OLwc9Rs3iMd1Fy6obyR7hB3lPAJ7ZRYBAhWkUMwqPQ4C5U
 FTSjhxM5VZEuJ30S0veVzQvQj2NFf7qJ00FQaK4gsA8T52BBmstI99Y8QuVwFo8TB9sEhBjsbz+e
 Hypr4QiDfRodGV4O5ypDdTPeO/pizcnIJmV/EOrG3jtoSDbBLR5e973vehgRRMJdd1x498THN+L2
 AkAg9lYWFjNTtussUcju/Fd8gZoUQm8ysuFdGGspIwJnzwlNIWgZJ9f/oRJHkij6DyweSIB+n4RU
 gKg/RWZUep6PQVBxKCMU+7NVjOu2beRqilmjgQ6jA3UwYgk7jX2p2c6GOdi3L3Pzry/TbsR08q9t
 EAjFm2byf+NztHhQoI5t5B02WWv4WCWgmfFdiUlW7tV45H9nCrhB5S7UYEmwoKT+ioWBAn01erfy
 VvaWheN1jZdogD7YCfXh97xQef6Ceaw0tyEeHKZjklTreHL+whhAdKuW1jHRpItetlrVADbHjxX8
 D9l6cvPWmRoveeW/gESan/V7zrfiyk/e91/RgZ/6G91oVgy7k8J6YqsQ8ZpR+9NAPyZNieblXJtY
 FnLudr1cDBCmdxHRG9lwrSOIPpeqwlm2NDGXIJ2x7CjcVfdC5/6qMuamcDy5IyJTwu54QWpbuhaT
 bvr6RLxLefGz0qNnFBlHl+43ri77+ppu+2j1BysaEC8mRErDfRYMfqOjtzuwjS9w63NmUUSmA+el
 3Hvzdw3iJnNgWQhMAwbhzhATAlYMjEocb2uQBsQEJu+PlY4mNgk9NuQxzGuTJJZulemVsWP9wHgr
 uDPX6WqNdgVDBhQX2Bc+ZhzMVyyGrnC47XFeJjjXu8tCsQQMz1LPkHI9Mrzo2c6qohujbISQOLYT
 Ua8ciIUdSU7SuMn1H/aAwarQpYDOYx/6JtUOyhxOMJmVV71jAHZ/eGxt7VMIrZxemgRtia2NRzRj
 IG2JXY9Z0Y7MfWkEfoGtOPo+JEWhXy1Le9Tb2y3Fkij411HsplMkkb/VBGfADMfD+gnvk4xC2BnA
 2wbIfWgFjXcSjNZLbr04EXXkIgRE5hm4oYma6jdGLSzAN9vqTxqZ3CU=
X-Report-Abuse-To: spam@mut-mta1-se01a-fr.yulpa.io
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eckhard Maaß" <eckhard.s.maass@googlemail.com>:

> On Tue, May 01, 2018 at 01:09:06PM +0200, Matthieu Moy wrote:
> > That init_diff_ui_defaults() should indeed have been before
> > git_config() from the beginning. My bad, I'm the one who
> > misplaced it apparently :-(.

> Should I have done this "bug fix" in a separate commit or mention it in
> the commit message?

I'm fine with it as-is. Before your "fix", the config was ignored
because overwritten by init_diff_ui_defaults() after reading the
config, so effect of your change is indeed what the commit message
describes.

I'm often thinking aloud while reviewing, don't take my comments as
objections.

> > This "break_opt = 0" deserves a mention in the commit message IMHO.
> > I'm not 100% sure it's a good change actually.

> Hm, what problems do you see here?

I don't see any "problem", I *think* your change is good, but I can't
fully convince myself that it is without further explanation.

Unlike the other two, this option has no corresponding configuration
variable, so the "let the config" argument doesn't apply. For "git
status", there's actually not even a command-line option. So, this
assignment removed, there's no way in the user-interface to re-enable
the previous behavior. *If* there was a good reason to get "break_opt
= 0", then your patch is breaking it.

Unfortunately, the commit introducing it doesn't help much: f714fb8
(Enable rewrite as well as rename detection in git-status,
2007-12-02) is just a one-liner message with a one-liner patch.

But actually, I never used -B/--break-rewrites, and writting this
message I tried to get a case where -B would make a difference and I'm
not even able to find one. So, as someone who never understood the
real point of -B, I'm not sure I'm qualified to juge on what's the
best default ;-).

-- 
Matthieu Moy
https://matthieu-moy.fr/
