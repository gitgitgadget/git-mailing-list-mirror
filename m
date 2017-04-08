Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B1EE20970
	for <e@80x24.org>; Sat,  8 Apr 2017 16:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752500AbdDHQFD (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Apr 2017 12:05:03 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:38567 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751428AbdDHQFC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2017 12:05:02 -0400
Received: by mail-it0-f47.google.com with SMTP id y18so7567295itc.1
        for <git@vger.kernel.org>; Sat, 08 Apr 2017 09:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1nDlEthL8yB4xZ69BlHvvQrezZyoMTqlYyDj0l9Ks78=;
        b=nXOAhnxwRg5MBMotLJhplQDHvpHMBNS3V+s0UiPywQf2uc9ui4vKxdx0Cjy+HJ5Rmq
         6xkytoWrGEgJM2h5biNe8GqPHK+nAB4q4vajOgoQKjQn4M3znXDEGk1FcQ8kPB04N2Yk
         rWqV8IDS3gtDgZaTN2e+3YFpNSLNo+gdZVlJiOeqArPdFUiUCPwVcWpNsGYQ/wr/TAri
         jeubIu+baTIH2ATZHSLHBaoIyzQVEAESuWQGjqM2T2Q3BZnoI+4agwEq4K9Jhw3CCddM
         feqEwNQI8nfVCbxs7Krmwo5lMoBM/1QDO6Iz2izMiprcHe4kq/Q8NNZ3XL7WuqHdN0iI
         U8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1nDlEthL8yB4xZ69BlHvvQrezZyoMTqlYyDj0l9Ks78=;
        b=gupUjHcIxw9POWABmFsEqZ3eaz2+1MkN6DJXILh74GZPawDzbOuwMA0eS9g5XA1Oqo
         /uCRe8+ddLaC9J8rzAapyyG/Jq+d36r82Q8blC5spoBt08se/eBxNvSXMbas64dec0QT
         jjYKSR1UfutS88TUBafo6q4E6mEQKMoCudfH9cykzVDGhx/XwuJdYiIs2lNJrfC0KR1Q
         fLAEsKIAxosU0bH5yOoq514P6ogvnkMMZLF9y/qDMzAzaU8exg5XUGmzQbhR6hcVcTGx
         q12WSDvnKPDS19c1/xMVjMWe3U2mjrJv5meVp23FFidIYHW6Xn2XZqHjsQuiCt4cq9qa
         crmw==
X-Gm-Message-State: AN3rC/5/b3yVJFNyzxBt7k9qGxDhiuXsaGFKfp/2Kd52GfWqkKHuF6M4
        cUiT1tCL/L0KxelVKKFRtr0HrcFkGXM7kfM=
X-Received: by 10.36.173.91 with SMTP id a27mr4947182itj.60.1491667501702;
 Sat, 08 Apr 2017 09:05:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Sat, 8 Apr 2017 09:04:41 -0700 (PDT)
In-Reply-To: <1n468u6.1jrwr611bokgfiM%lists@haller-berlin.de>
References: <1491617750.2149.10.camel@mattmccutchen.net> <1n468u6.1jrwr611bokgfiM%lists@haller-berlin.de>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 8 Apr 2017 18:04:41 +0200
Message-ID: <CACBZZX4x0kJVWSkmQa+j6yn-w3m-u8ZiXDPZ60KG+ruvhejqNQ@mail.gmail.com>
Subject: Re: Tools that do an automatic fetch defeat "git push --force-with-lease"
To:     Stefan Haller <lists@haller-berlin.de>
Cc:     Matt McCutchen <matt@mattmccutchen.net>, git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 8, 2017 at 5:03 PM, Stefan Haller <lists@haller-berlin.de> wrote:
> Matt McCutchen <matt@mattmccutchen.net> wrote:
>
>> When I'm rewriting history, "git push --force-with-lease" is a nice
>> safeguard compared to "git push --force", but it still assumes the
>> remote-tracking ref gives the old state the user wants to overwrite.
>> Tools that do an implicit fetch, assuming it to be a safe operation,
>> may break this assumption.  In the worst case, Visual Studio Code does
>> an automatic fetch every 3 minutes by default [1], making
>> --force-with-lease pretty much reduce to --force.
>>
>> For a safer workflow, "git push" would check against a separate "old"
>> ref that isn't updated by "git fetch", but is updated by "git push" the
>> same way the remote-tracking ref is and maybe also by commands that
>> update the local branch to take into account remote changes (I'm not
>> sure what reasonable scenarios there are, if any).
>
> Here's a rough proposal for how I would imagine this to work.
>
> For every local branch that has a remote tracking branch, git maintains
> a new config entry branch.*.integrated, which records the sha1 of the
> last upstream commit that was integrated into the local branch.

Can you elaborate on what "integrate" means in this context?

In some ways the entire point of this feature is that you're trying to
push over history that you don't want to integrate.

I.e. you're trying to force push your unrelated X over remote history
A, but not more recent arbitrary history B based on A which someone
may have just pushed.

I'm having a hard time imagining how anything merge/rebase/whatever
would place in branch.*.integrated wouldn't just be a roundabout way
of recording the info we now record via the tracking branch, or in
cases where that's auto-updated for some reason having another
tracking branch as my "[PATCH] push: document & test
--force-with-lease with multiple remotes" suggests.

But maybe I'm just missing something obvious...
