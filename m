Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DEE11F404
	for <e@80x24.org>; Thu,  1 Feb 2018 12:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752062AbeBAMMC (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 07:12:02 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35047 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751916AbeBAMMB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 07:12:01 -0500
Received: by mail-wm0-f41.google.com with SMTP id r78so5260814wme.0
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 04:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=JGXBxgxm0BITlMXRhurevKXqyoPsIAjUP0ADt+gnER0=;
        b=Hxhkq0hm3N+yn2rMbPahAdbkHcbo7w8zWFCMNKvMZL8cw3/MI8GQkwtKM9AVTfVcAl
         opPOEAPeqhOiGAtiAKNnCqTumVBbnHmWMwRGW9ubP7qV7WbS3atAa1DoKlOqkXqQqbiF
         1N6CLMuBxvTmF3JDkqZnYOgaJHl9GjQKyT4TSz0zVehqp3zQ3rC5fDVvvR+y5asTo/rz
         6H6WNtsCc+kgVdV5KpqyhNQNlXaQNhW8ipcBIwSnaFmf0naNLNQfORkJsdyMGigsifZG
         reR1akNRijmasZvTjkrF5DNtMBBoiuYy/7ezZ1BNGxa/Ii1TNZ1k1EJEVeWEb7v668+J
         iM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=JGXBxgxm0BITlMXRhurevKXqyoPsIAjUP0ADt+gnER0=;
        b=qSWjWQIYbIoesIn+vxE2Ebzg9adfmd+x0JNgDKQGVufHQJCFLDQ13OIoc8TEWZxNg/
         l17ra6hce4LpA6La7ZdGPszbVSmFNHJT63+sINTGI1eIgTin1K7PKPFpR54AQlvvOls8
         /RNVb/ln2sf4UnqF0xw3OySsXPS16QYODJ75x1B3v6EWpTz2hwaAYMfZDbNTlPkWLS46
         mqVcs34bxrwnONZUx+ApjY1VJ81vXJt7ehCVN2R1mZwud9wcRG/yz++J50dD0Cwv8gyY
         5s6iyrcHF69tO60ZELzsucSEJp/kJQRfFARmm9RlwqR1p+Ku6bpJLZkFW9TfUrZcn6l0
         BWyA==
X-Gm-Message-State: AKwxyteyysysLbRay/FePE/Ap/ac9GIOOedWmLh8wvvKPn7J5wrLiIC7
        rEakWXQLhX3TAspKZzb30Gg=
X-Google-Smtp-Source: AH8x226oR4e7uoOKm4sB87it2NQSkC4eKRILSCmtWmgJ5WtVFKGOq8hsarAIm5e1xTi1JrSrz1EIUQ==
X-Received: by 10.80.241.89 with SMTP id z25mr31102684edl.104.1517487120398;
        Thu, 01 Feb 2018 04:12:00 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id z8sm9789531edi.11.2018.02.01.04.11.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Feb 2018 04:11:59 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2018, #04; Wed, 31)
References: <xmqqd11pr0he.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <xmqqd11pr0he.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 01 Feb 2018 13:11:58 +0100
Message-ID: <87lggcnc35.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 01 2018, Junio C. Hamano jotted:

> * nd/fix-untracked-cache-invalidation (2018-01-24) 5 commits
>  - dir.c: stop ignoring opendir() error in open_cached_dir()
>  - update-index doc: note a fixed bug in the untracked cache
>  - dir.c: fix missing dir invalidation in untracked code
>  - dir.c: avoid stat() in valid_cached_dir()
>  - status: add a failing test showing a core.untrackedCache bug
>
>  Some bugs around "untracked cache" feature have been fixed.
>
>  Will merge to 'next'.

The "update-index doc: note a fixed bug in the untracked cache" needs to
be amended so it doesn't say "Before 2.16, ":

    https://github.com/gitster/git/commit/b9fc38c9f90b8bf2c9147ad536813b66aa45220d#diff-01fe1588047a177245bfaf82336cdeaeR467

I'm not sure whether you're planning this for 2.16.2, or whether it'll
be in 2.17.0, but the patch should be amended to mention either one of
those.

I can submit a replacement patch, but figured this was trivial enough
(and you know more about the release plan) that you'd like to amend this
locally.
