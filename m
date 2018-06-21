Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C29791F516
	for <e@80x24.org>; Thu, 21 Jun 2018 20:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933282AbeFUUeR (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 16:34:17 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:35229 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933022AbeFUUeQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 16:34:16 -0400
Received: by mail-ua0-f195.google.com with SMTP id s13-v6so2902065uad.2
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 13:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Sr8AAe1SiJyDOe4UZ/RyP09WZLsGGfP/YRzIXCV3Wl8=;
        b=kKpCCr1HLEZc1o+nqqt5llheL/wZ1XgIUFuB7fa+zQOMcy330ax4ILLq1eyqSXxZBs
         FL36YRyMtEQm1PiPNosWp4UVgwty5SqD3RSrjO9h6Tj4s2rXSg+Pikv6vsZiWCcHg9R4
         A3JhlRE969N3YvmM6tFk1yUx2jCc7jL7gXFSu1qGR4Cq8vX+45ZbkMK4Ov5/JkQnsQj9
         9VFiWWWKqqy75DkNzXDa033lGIdfIhp6gzDomCdf1GEaD2soC2gG3Y+py6FX3T2Frtld
         8DLZUqumMWgjqBw2+dUEim5/ph6Xa80Sd5bmTfEl9GKoNTIqkxnc0EmRDYv8c5VneW9o
         SDJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Sr8AAe1SiJyDOe4UZ/RyP09WZLsGGfP/YRzIXCV3Wl8=;
        b=h5YwfG+aTeWal5wOtjUsgpTsVK392CUqCER1reClcVmIVJvry57uO+rbrqgUdulUaM
         OSv8gIPpLbB9y5hNDaW1KwAlro/DDvSQmtQU91GHXRlRIkO1P4FeXb+YjkAAO9Yk4Ykn
         1rsxAgECRMAPUaZlVF+VmvoesX+fWYcYujICN9jxYpLO5KZ1TMJ+VtK9yHtDXB+o7Unx
         7KR7KZlZEuBSdyAU8wH3bY5BcwVZXWRTqRr5jOXzjwXYPDCdx5KQLvreZtWJ9lj32EwM
         xDV/0qm94Xi43VAZZW3KMpYEZMZHueZRwyOPLi5a7J92t4L34oi5JB9GU6ZdxXgVJHlB
         B7Sg==
X-Gm-Message-State: APt69E0jX0ooeiyYgkaq5N/6nB5O68BSBDlYLcUQjnWY+rg1P9qsP0S9
        i4o3569xDjSbs7VBlmp19M9TzQdsTu2vTez5BNA=
X-Google-Smtp-Source: ADUXVKLxmGOglqsZi8sUG0E49qdzvTNprVWHxgSJ8Aab0ofbE22upOgrHggsum16xvC8dJdahANVXM4FPI5yecIClhM=
X-Received: by 2002:a9f:3091:: with SMTP id j17-v6mr17331376uab.23.1529613255745;
 Thu, 21 Jun 2018 13:34:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5f28:0:0:0:0:0 with HTTP; Thu, 21 Jun 2018 13:34:15
 -0700 (PDT)
In-Reply-To: <xmqqzhznsyi2.fsf@gitster-ct.c.googlers.com>
References: <20180617055856.22838-1-newren@gmail.com> <20180621150023.23533-1-newren@gmail.com>
 <20180621150023.23533-3-newren@gmail.com> <xmqqzhznsyi2.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 21 Jun 2018 13:34:15 -0700
Message-ID: <CABPp-BEgdK1e_rtk4u=9Anc2OBVtehTnC6Ow=HWhA9Q5sT6SBw@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] git-rebase.sh: update help messages a bit
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 21, 2018 at 12:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Elijah Newren <newren@gmail.com> writes:
>
>> signoff is not specific to the am-backend.  Also, re-order a few options
>> to make like things (e.g. strategy and strategy-option) be near each
>> other.
>> ---
>>  git-rebase.sh | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> Missing sign-off, but otherwise looks good.

Oops.

Signed-off-by: Elijah Newren <newren@gmail.com>
