Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 843BD20401
	for <e@80x24.org>; Thu, 15 Jun 2017 21:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751763AbdFOVJM (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 17:09:12 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36113 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750814AbdFOVJL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 17:09:11 -0400
Received: by mail-pg0-f68.google.com with SMTP id v18so2839510pgb.3
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 14:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VII5DLrJaA9eQI0QDOer/QNM3XPbyODOkxjFiYWynoE=;
        b=UKaWgl371vYxPOQOQWiJfHNvUQjWfAxsh/bc/5GWvuTeZA4OQRtqxbtW+3r6elOxjh
         fVhaPRm0yFZehSfZ7ufo0wCy55m4JkpyeSAGwFw8IR0QiNVBOkKBF5knxtSGbsqe4J/f
         XIAZcwvookuZ9SUDAwLgXxsDSDAFscDvJcYkXF4s5FiugF6lsp0acNnsFhwx7Hdft/q5
         YYFgxywCX6U+Yq/q9Xhk2RpIY12DxU7yE1li0CvPpkQwp0WeFwijZIIHwta2Lt8nEr42
         1lxRHu7wFKmxzveFVZE6wWgxBFGMezAOmAqwXn6ySSsoA9Zqhei2zg7kL2e85EyTJgUP
         27uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=VII5DLrJaA9eQI0QDOer/QNM3XPbyODOkxjFiYWynoE=;
        b=Jvkar8VS2kGZGKQVDOWcZywD4aGAK9fYG+NINoD/SUnRK8enM7R4jCrXvQ0J1+4Wun
         JjpKtykvAC1VRP5eg77Xpgyw+1K8HdT5KrYqM6x26bOsMMaZGYN8JACUYAm7WCPIw2XK
         oNsGQ17ugnuXPCAIJqQJFEFiihP83Impng2ov7Cfr+OnnqveSY1rIf0yAOKJdpgZFtSG
         nWygcFY+zjDgiokRe4Q/LUthl3BO98bS+OGNxN/SDu7/9w1r2tLwcEHnooksZQZ/Z8g0
         VxXpICVXEVaN0TgOkLI8CR5tAUowDHcf5JFH53x607VN4S9mJGontWnqbiLtLuufR5ld
         nGdQ==
X-Gm-Message-State: AKS2vOxh1/Co4G7PeFe6Sl4eD2f2B/vFn3sMqDBQgjq85rMg9U9uGcyT
        PwLrd1CEb/9Iww==
X-Received: by 10.98.113.72 with SMTP id m69mr7323478pfc.195.1497560950912;
        Thu, 15 Jun 2017 14:09:10 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:88c8:4433:c52b:12d7])
        by smtp.gmail.com with ESMTPSA id g28sm312902pgn.58.2017.06.15.14.09.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 15 Jun 2017 14:09:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v3 0/6] config.h
References: <20170613210321.152978-1-bmwill@google.com>
        <20170614180739.72193-1-bmwill@google.com>
        <xmqq8tkt10pt.fsf@gitster.mtv.corp.google.com>
        <20170615203332.GB176947@google.com>
Date:   Thu, 15 Jun 2017 14:09:09 -0700
In-Reply-To: <20170615203332.GB176947@google.com> (Brandon Williams's message
        of "Thu, 15 Jun 2017 13:33:32 -0700")
Message-ID: <xmqqzid9yn4a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> On 06/15, Junio C Hamano wrote:
>
>> ... so please eyeball the resulting 12 patches carefully when
>> they are pushed out.
>
> Ugh, I'm terribly sorry.  Completely my bad as I didn't consider what
> you would need to do on your end.  When I built my patches on top of his
> I naively just applied his v4 to what ever the current origin/master was
> at that point in time.  I'll be sure to be more careful with this
> next time.

It's no big deal (otherwise I would have insisted you to rebase so
that the end result can be merged to 'maint', instead of doing it
myself).

But quite honestly, I do not understand why you rebased this on top
of the alias thing.  Help me make sure that I correctly undertand
what these two topics want to do:

 - The primary point of js/alias-early-config is to fix reading of
   pager config from a wrong place when alias expansion is involved,
   and its solution has a nice property that it simplifies the alias
   lookup and avoids the unpleasant save/restore-env dance by
   switching to use the early-config mechanism.

 - Unfortunately, the early-config mechanism is broken with respect
   to multi-worktree configuration because it does not pay attention
   to the common-dir stuff.

 - The primary objective of bw/config-h was to separate out the
   configuration related things out of the kitchen-sink cache.h, but
   as a nice side effect, it also fixes the early-config mechanism.

Assuming that the above reading of mine of these two topics are
correct, we can conclude that even if we merge js/alias-early-config
that forks from v2.13.0 to 'maint', the result by itself would
regress the use of alias in multi-worktree configuration.  For it to
be useful, it must be merged after bw/config-h gets merged.

So it looks to me that it would make more sense to build bw/config-h
on v2.13.0 and then base js/alias-early-config on top of the result.
If Dscho is too busy to rebase and you are volunteering to help,
perhaps the right way to help would be for you to do that rebasing,
not rebase bw/config-h on top of js/alias-early-config, which is
backwards and does not buy us very much.  Of course, we could make
the result of such rebasing into a single topic, but even in that
case, the order of changes feel backwards if bw/config-h comes
later.

Anyway, I think I have to tend to many more patches before I can
push out today's integration result, so ...


