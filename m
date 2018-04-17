Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EED8F1F404
	for <e@80x24.org>; Tue, 17 Apr 2018 21:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752647AbeDQVia (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 17:38:30 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:44980 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbeDQVi3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 17:38:29 -0400
Received: by mail-wr0-f177.google.com with SMTP id o15so8382570wro.11
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 14:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=l5ROzvf6ahmWtBV5BBPy0h8o0n8bzgDZLctmxzb55rs=;
        b=nPkYRHGUB6/xEtvMqj+kI5VEXiBufdd8oOdRh6gOMhXRmrQ+QOZvjCTYB+zXp7OoX4
         CBQMfgGYDlww3tlijUZ1XJbZJ54GAl3lC1rwHlqrEaChyOWv12oMBoXLS4dZ79oHkydr
         khMDmcIHgVLwFkhpIl4EXyPABQZGcCMvjUYrmH8Ceqdr2WWGtKTpkyWTRawXX2EcB0rm
         N7G1G8P7/8AwU2oir6Q9oEoxo5Rwn5Mp0FQMJ260P+q93Dh1NVo0pt+AW805ZgnvuHn3
         ebfW1XFF5PDdB1u4Y3NEa1ktCPgPoYAV5NUd4BeUNdD2ycMjUP3X6S/xViuBOWg/Fd30
         DCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=l5ROzvf6ahmWtBV5BBPy0h8o0n8bzgDZLctmxzb55rs=;
        b=DTgeApjsp+qxHQZoqREmp9bGCVjCcS+MRMNuL4/rD//rf1TImB9TFkIfe42XNbqZA8
         w0g1Sn0RegVEPArqc/CGGqwtVZgxXPo+na4avteJFBL0hej4JOmKBqdzAuuiyILXuMY1
         c1KiQBCoptqrzgZZyLZUo1AIQawnITcCErPESWROqZ4c6+J+vPvK7Dohgwyrdwx4Jjcg
         XjmoFOh/BuyhIm3FaaZFTVJXWEm5eTH0sTsgdiNDVPuEP0bqUBVLNFIxmsxmQ9I/b0Sq
         2LWjM3O/P3L91lZj11qW1ZpS1OovYFru+TerK0iJzZzcEmXQUbM4/R6UbXF+r2gPr8Yf
         PIpA==
X-Gm-Message-State: ALQs6tDVUyDyUPHZwQgilOkBf/D3ZAcYBTysU4kkfT5tO61/quBZ6wXa
        hczmysminHkEZts0MSl75tc=
X-Google-Smtp-Source: AIpwx49yKSCDE140hPFwuGMEWnqmVLZWEYekyBcPbbweLLqac375LadqY44AHky5Y7MsQEaN9hvDkw==
X-Received: by 10.80.216.67 with SMTP id v3mr5122067edj.193.1524001108537;
        Tue, 17 Apr 2018 14:38:28 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id b48sm4550934ede.16.2018.04.17.14.38.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Apr 2018 14:38:27 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Peter Backes <rtc@helen.PLASMA.Xg8.DE>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: GDPR compliance best practices?
References: <20180417191549.GA1199@helen.PLASMA.Xg8.DE>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180417191549.GA1199@helen.PLASMA.Xg8.DE>
Date:   Tue, 17 Apr 2018 23:38:26 +0200
Message-ID: <87y3hlecod.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 17 2018, Peter Backes wrote:

> I'd like to ask whether anyone has best practices for achieving GDPR
> compliance for git repos? The GDPR will come into effect in the EU next
> month.
>
> In particular, how do you cope with the "Right to erasure" concerning
> entries in the history of your git repos?
>
> Erasing author names from the history changes the commit hashes.  It is
> well known that this leads to a lot of problems.  So I don't consider
> this a workable solution.
>
> And how do you justify publishing your employee's name/email as part of
> a git commit under GDPR rules in the first place?
>
> github has the following page mentioning the "Right to erasure" but
> AFAICS nothing about how it will be implemented
> https://about.gitlab.com/gdpr/
>
> Here are discussions I found but they do not really provide a solution:
> https://law.stackexchange.com/questions/24623/gdpr-git-history
> https://news.ycombinator.com/item?id=16509755

[Not a lawyer and all that]

I've been loosely following a similar discussion around blockchains and
my understanding of the situation is that for a project such as say
Linux the GDPR gives you this potential out for that[1]:

    "the personal data are no longer necessary in relation to the
    purposes for which they were collected or otherwise processed"

I.e. you understand that when you submit a patch to linux.git how it's
going to get used, and that it's in a storage system that isn't going to
be pruned just because you ask for it.

In combination with the "Conditions for consent"[2] this becomes a bit
more tricky. I.e. "The data subject shall have the right to withdraw his
or her consent at any time".

You can make a compelling case that for say submitting your data to the
Bitcoin blockhcain the above quote from article 17 overrides it, but can
you for other hash-based-on-hash systems like linux.git? Maybe, maybe
not. I think nobody really knows at this point.

What I do think is for sure is that there's not going to be any one size
fits all solution based on the underlying technology.

If I start storing my webserver access logs with IP information in a git
repo, I don't get to say "sorry git stores stuff this way, I don't want
to rebase it". No court's going to buy that, I've just gone out of my
way to use technology that circumvents the GDPR for no particularly good
reason.

This is very different from you say joining a company, committing to its
internal git repo, and your name being there in perpetuity, or choosing
to submit a patch to linux.git or git.git.

I'd think that would be handled the same way as a structural engineering
firm being able to record in perpetuity who it was that drew up the
design for some bridge. I don't think it's plausible that the GDPR,
which is probably mainly going to be about consumer protection, is going
to concern itself with that in practice.

There's a lot of middle ground in between those two
though. E.g. children are specially protected under the GDPR. Is Linus
going to say he doesn't want to rebase linux.git after some 14 year old
who regrets submitting code doesn't want his name there anymore? Who
knows.

Depending on such common cases maybe git itself should eventually
support some ways to work around the issues. E.g. we could have some
mode to always supply a fake name/e-mail, or make the notice
implicit_ident_advice() spews out somewhat scarier.

1. https://gdpr-info.eu/art-17-gdpr/

2. https://gdpr-info.eu/art-7-gdpr/
