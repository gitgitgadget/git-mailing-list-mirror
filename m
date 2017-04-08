Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8246C20970
	for <e@80x24.org>; Sat,  8 Apr 2017 16:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752224AbdDHQ0o (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Apr 2017 12:26:44 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:35104 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751735AbdDHQ0m (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2017 12:26:42 -0400
Received: by mail-it0-f46.google.com with SMTP id y18so8337353itc.0
        for <git@vger.kernel.org>; Sat, 08 Apr 2017 09:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wAsXMc8zuQAJ4WNuKw2jj9Ugd20/Yxe4cVp+hx5+N7A=;
        b=fhHXRZwwj37AhAJYu4J2JvpZWLoYJPN7zt5/zVSGN5yfQh65We7/ze6LjPFxHgxJzf
         B4aZwOAaHTqwd3jbGW6w1Jz5O9GLEl8FhMdoeIOtrMvECYpoUGGWwOUqFYaAb6xkLBmf
         9BIaVJQxiQFefK8jk3F6Cq2hivw3jRQIAFJaQBZCsbgtkZhVQvSkGV8DHcL/w/t0lyR0
         lGPnUfqsvxQwlCOKApVxILEeYYZyY6jk/386faEPbROru8Yxus+JFR3cL3iFF3u2opti
         Vr2NT+cpoD3PaS+wo0E/NQm2mQbG4Q8C/FB9phrZE49R7BAeyTHWg1aQoRkEP1Fuqk/W
         v9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wAsXMc8zuQAJ4WNuKw2jj9Ugd20/Yxe4cVp+hx5+N7A=;
        b=XmAtjxuo1K0RTXFvkQDY9+kVWT9A3v089bW4Nqx+FNzdWl1TmzM3kjrBjdb+bJdu73
         rxbVlqxVx4l44GuBCy1VQAiOjeMECBBwj8Fu8PY4rf8wK8rDWTV0hu2MKdTvePKNYJoW
         L/VqAwT4xjZhtiPlU8aTGw5bMTUYNVdsbiAA4YSqahXdKPo3W6Xu3TbbAI7FRLOAf8EQ
         9uLhNYo1V6Ut1bGQB/LWqXlGyl+XQAgLvJ9mkEWw5LcWvH6Rct0M0WT07XK8hDxlW4fb
         X8Mh/wY8PfIL+HCqW4yVSohxy8u/I6ykXmrJs7n5LDMJkbtH2KjtyhGd6p7+k52C2Fcl
         Q2wA==
X-Gm-Message-State: AN3rC/64THoE1EZJEraYU0SW3+OEBUjLFTCiORFE0VNQzPeQsbpsBTvFFud1FUulxRBsbjECH2AVju6xiZFNyg==
X-Received: by 10.36.43.77 with SMTP id h74mr4417641ita.60.1491668801591; Sat,
 08 Apr 2017 09:26:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Sat, 8 Apr 2017 09:26:20 -0700 (PDT)
In-Reply-To: <CAJgfmqU+1Ex1YkP94H2amXV+oqscbQwvb-CueuCiM7-n0AAP8Q@mail.gmail.com>
References: <CAJgfmqU+1Ex1YkP94H2amXV+oqscbQwvb-CueuCiM7-n0AAP8Q@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 8 Apr 2017 18:26:20 +0200
Message-ID: <CACBZZX4fDu-o+ERiTyjVq2rWkXK6rjErU4KyW33qMx1_6vjMCQ@mail.gmail.com>
Subject: Re: Feature request: --format=json
To:     "Fred .Flintstone" <eldmannen@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 8, 2017 at 6:07 PM, Fred .Flintstone <eldmannen@gmail.com> wrote:
> $ git log --format=json
> [{
>     "commit": "64eabf050e315a4c7a11e0c05ca163be7cf9075e",
>     "tree": "b1e977800f40bbf6de906b1fe4f2de4b4b14f0fd",
>     "author": "Tux <tux@example.com> 1490981516 +0200",
>     "committer": "Tux <tux@example.com> 1490981516 +0200",
>     "message": "This is a test commit",
>     "long_message": "This explains in more details the commit"
> }]
>
> This would make it easy to parse the output.

The git-log command isn't plumbing that's meant for machines, but the
git-for-each-ref command is what you're most likely looking for.

It doesn't have JSON output, but you can make e.g. --format emit
something even more easily parsable, e.g. a version of what you have
with each field delimited by a custom delimiter, and then split on
that.

It does have --perl, --tcl etc. options to make it easy to quote the
fields, however there's no logic to manage the state machine JSON
would need to omit trailing commas, whereas emitting output for
languages like Perl where trailing commas don't matter is much easier.
