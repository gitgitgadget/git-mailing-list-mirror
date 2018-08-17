Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D7D41F954
	for <e@80x24.org>; Fri, 17 Aug 2018 14:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbeHQSAS (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 14:00:18 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:52190 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbeHQSAR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 14:00:17 -0400
Received: by mail-it0-f51.google.com with SMTP id e14-v6so11629255itf.1
        for <git@vger.kernel.org>; Fri, 17 Aug 2018 07:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZK/8osFKRPjY0aR95utoxk4Z2sZbZEecw0iXoR2BxPQ=;
        b=VS+LrNKBm1p7LU6WcfBTCiLr2C4sTbmIvCvcGAxSGEhD+jPWmS0fs/wJnlAzfI/a3z
         SbIGV3hEtkOlhjh3uetMA6To1yirKr1JfLPMhdQHXxCnspHEdJ9BWOtE+X9V6EFylSCN
         iL+mu5RrI3KS8V3PH9qwDNEQoQxCdBbcNeatyZMiu05DOaks1vVAB1aFquc021BrS5H6
         tD8MpAA9tGN3ALfAEFzr+l36XrAjrfPTIPK7IwGeHCLPHrYOvwWbXm9cOJNbiizf0hWH
         PERb4xmljYHj8CYgA+0fUrTIOoyDHws6idxjhuG4F4nE6rUoDvvi1/qrNMFzZH0g62MT
         7hKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZK/8osFKRPjY0aR95utoxk4Z2sZbZEecw0iXoR2BxPQ=;
        b=EaxKflw0qa+2Y4Pa9rzpZbFOTP1B+xnCVz70s+bX0PIkx1JdYEbsbbecqbN8oLNWwl
         shJLvYfBJkFEjEKmIcwXd66CoS2mphOFDQ8fR4iWKKSSS5Rb/Lmg7rQoVjiHQrKpK0mG
         CKXVxcknsnfGB4s1u3S21mEieYQp9ACjAQb5zNS7/fJBEyfRcxyVa6MPtOErcjOrA4/F
         pFrXPDV4swtU3HLs6pvR60wFMVNyJRM57fPP04BD5ADpwGbc7JQTQIvdJKD8iuGKbDv0
         EHtX4SYW5xq/VtpbXsiJBlk1U8t05G/yLgcmf+jwQ3VGBeFP/cETLehWSmmK2LKBarNR
         dKVA==
X-Gm-Message-State: AOUpUlHVyZNmp47+aHTiXQHDmfGkB1B9LNYqaE5M/liHRXl/lU3dG/RD
        0eimxNZmUGUdN0eyXDULm2jRAmlgLLLomvkVtRc=
X-Google-Smtp-Source: AA+uWPyBoKI39zt+2n6yit3c663uY9mKIrXn00qhCh+1pZy8emdVkM0PDV7Lxn2DRWwLQGOjwsa3Fz0kjLcKdrc8jq0=
X-Received: by 2002:a24:144:: with SMTP id 65-v6mr4274610itk.62.1534517796310;
 Fri, 17 Aug 2018 07:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqpnyjgroj.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqpnyjgroj.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 17 Aug 2018 16:56:09 +0200
Message-ID: <CACsJy8BG+rYx9Epg6vV+q9+A9Kv09RFhR7VGHEqwYw7wt9KXtg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2018, #03; Wed, 15)
To:     Junio C Hamano <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 16, 2018 at 1:01 AM Junio C Hamano <gitster@pobox.com> wrote:
> * bp/checkout-new-branch-optim (2018-07-31) 1 commit
>  - checkout: optimize "git checkout -b <new_branch>"
>
>  "git checkout -b newbranch [HEAD]" should not have to do as much as
>  checking out a commit different from HEAD.  An attempt is made to
>  optimize this special case.
>
>  So... what is the status of this thing?  Is the other "optimize
>  unpack-trees" effort turning out to be a safer and less hacky way
>  to achieve similar gain and this no longer is needed?

I still dislike the fact that this depends on config keys to tweak
behavior and believe there are still rooms for general optimizations.
But the feeling I have so far is I'm doing all the work for Microsoft
in that direction. So I give up. It's up to you and Ben to decide.
-- 
Duy
