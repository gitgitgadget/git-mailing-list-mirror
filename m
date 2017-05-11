Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA9E12018D
	for <e@80x24.org>; Thu, 11 May 2017 17:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933071AbdEKR0g (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 13:26:36 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34285 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932906AbdEKR0e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 13:26:34 -0400
Received: by mail-pf0-f171.google.com with SMTP id e64so17081520pfd.1
        for <git@vger.kernel.org>; Thu, 11 May 2017 10:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bnkjXO9d5JUSU06sntVtIJD3bStOnGa3L24NSSSQs4g=;
        b=JJKT+CpltC5oUiaS02omhqupHMohKaKdlFI3QNjaDc2olRi8MnGCnrNLvTyEt35IvY
         lyYj+kY96BTQeXsv2jmxfYp4y+J4VfIs5P2HiHnhfcvI6lk1mZa+NpH+ZMl/TTY4uq5b
         UEDa24z+pnkHSuASUA8sSu31zarJwuhbutHqPeYDeivQGdP629cjX3sEt4KzLzRpOUeZ
         BydDarQN/327EWZ7qaWYoAgFRr/fTMrx3dEvtF6p7Q5NXqVnQ9pX6DpY9itZb0Y3rf+d
         4Fpcz1kmj+SKhvaKQ97QO0KHpHQzXgWyjEFEw2IvgQlQEaKbLwmU3OXJ7pUZv6iRrKEh
         6yWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bnkjXO9d5JUSU06sntVtIJD3bStOnGa3L24NSSSQs4g=;
        b=cmE8e/Jr3p1fGAsNZFZJJo9+b1yTItOaBa27zw/f0gGKe2fFaUl/AnriYqkATmzYd9
         B/HKEs1EfoH0wsyYA3qaiZ+RyM6g8KBGHBwrVNUJxekEkPB1PsII/6lvp/lCKMsz6Ch1
         VlHSAKy+Zr8DfYNXPZ+1+8gHC2Dy3D6WWtHcetEiqK7Q+BRbl58E0wQ/0kmoCTEVjxQl
         hOxe3CcQB2/PHfZz9VHknQv3Gph5TJB8WWZxh2ErW2lqEXe+Ibrxu9GKG+vFxtOCfxjj
         k0MHWE3G214usXduwgPBY4QUOx4YGfDUGupKt+o2FhbEZkNtNZuTJBckEG1vEdOHQ1xL
         OdQw==
X-Gm-Message-State: AODbwcBd7U5U/EZcd+zaWCActmyYTgQ0C6tm30OXIB37zOV3v//ryKjG
        rBuhDQ2168vaP07HMeSIqMlQeRIqR793
X-Received: by 10.99.60.81 with SMTP id i17mr119989pgn.183.1494523594088; Thu,
 11 May 2017 10:26:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Thu, 11 May 2017 10:26:33 -0700 (PDT)
In-Reply-To: <32d64bd3716c6f7a24877535330b7ac754eb117c.1494509599.git.johannes.schindelin@gmx.de>
References: <cover.1494509599.git.johannes.schindelin@gmx.de> <32d64bd3716c6f7a24877535330b7ac754eb117c.1494509599.git.johannes.schindelin@gmx.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 11 May 2017 10:26:33 -0700
Message-ID: <CAGZ79kbAVt0xMDKmsTG-9cUx7Uj3jCY4-ma__BDokALMX8jz3g@mail.gmail.com>
Subject: Re: [PATCH 05/11] Revert "Revert "Don't create the $GIT_DIR/branches
 directory on init""
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2017 at 6:47 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> A long, long, long time ago, we stored the "upstream" information of
> branches in files inside the .git/branches/ directory. We don't do this
> anymore, though. Since 5751f49010e (Move remote parsing into a library
> file out of builtin-push., 2007-05-12), to be precise.
>
> This is sort of a sibling to 75c384efb52 (Do not create $GIT_DIR/remotes/
> directory anymore., 2006-12-19).
>
> The tests t5505-remote and t5516-fetch-push need to be adjusted now, as
> they expect to find a .git/branches/ directory.
>
> This reverts c8a58ac5a52 (Revert "Don't create the $GIT_DIR/branches
> directory on init", 2009-10-31).
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

This (and the previous patches) makes sense to me.

Thanks,
Stefan
