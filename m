Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A1A320966
	for <e@80x24.org>; Fri,  7 Apr 2017 19:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933742AbdDGT1F (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 15:27:05 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:33669 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933573AbdDGT1C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 15:27:02 -0400
Received: by mail-pg0-f44.google.com with SMTP id x125so75038902pgb.0
        for <git@vger.kernel.org>; Fri, 07 Apr 2017 12:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4h5owbPR5Fl7MVLdK6f5SC05Ar21gSR3RDvZpDEpBRs=;
        b=iUhfrOO5t0x/1tmbyxbPFLCbG8oJAiWOPpgNPtT0TYcNLr93vATY53RO3zO2EKR7OA
         zyKQhIMJrbTXHGTXmQ6JFi4jfpQoDYlr1pIhKSVzbwWZC7dAIP3UB//FHSoQ7MJ6L058
         ev0JlyNfuySJ8zmuNmJtO7mXkzTkUA26SPYch/Z6vFA6N5ZL61z5QOt3A5tp6VKNQwwB
         Q0j7sMfwdjiA5CXdCTQ/okCySXiGGkWDABu2RVoQIbrs2ZYidtj70pDnkUrEGco4Tnwv
         xPJNl/s/KUmdEcdoKXzWRPZI1qU/7zMKij7p+yRxgGKrjDIIpd+TpkiAAQ/xlAcE4TUJ
         7BuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4h5owbPR5Fl7MVLdK6f5SC05Ar21gSR3RDvZpDEpBRs=;
        b=TOQ3VP78YgNFSXA/cWMKELUxcED2vKYfoaYiQVc+XKbPlTVyPKsgDTO0WTQbFta7dT
         yhQrbHwwpbDfKYniUPswdmMT/PeYDNhRScFW78i5BtRRnMd1Q+YTctI2ctb4QX+Qt0pR
         uPXq4BVk4y/zxvG80mTQf4H5jNTSyuz3tSZK73v3lrLRA1DAq/eZuhIRImUWBPP+KrlM
         ruoviwuPOdzYLjlgzx8xFXFFPju2DLIW2ypuK3tweslcnE3F+PF7HjXxJP3sLrqJljwc
         zGsQJqrVQ1dn9RR2ey5J+8CngS04DrdkzO5MX6CDdZ5khxf9oHqpGF5T4NDuBBwqa9iZ
         lbrw==
X-Gm-Message-State: AFeK/H3nNXVWz301YHCGro5LSj9E/l4qa8N8cMF8Wbvzl7kQvoPMPqv2EoA7g8ctF1UEM5zhTPOkVe4xqUJTeVYz
X-Received: by 10.98.204.25 with SMTP id a25mr42047048pfg.6.1491593221840;
 Fri, 07 Apr 2017 12:27:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.163.239 with HTTP; Fri, 7 Apr 2017 12:27:01 -0700 (PDT)
In-Reply-To: <20170407192357.948-1-kewillf@microsoft.com>
References: <20170407192357.948-1-kewillf@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 7 Apr 2017 12:27:01 -0700
Message-ID: <CAGZ79kZg+QpQ73i2=boGTDAhdtfkrbA8ijNEf2pmanNhiiLwmA@mail.gmail.com>
Subject: Re: [PATCH 0/3] fix working directory file issues while using sparse-checkout
To:     Kevin Willford <kcwillford@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Kevin Willford <kewillf@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+ Duy, for sparse checkout

On Fri, Apr 7, 2017 at 12:23 PM, Kevin Willford <kcwillford@gmail.com> wrote:
> While using the sparse-checkout feature there are scenarios where
> the working directory should and should not be updated.  This patch
> series addresses issues found in reset, apply, and merge conflicts.
>
> Kevin Willford (3):
>   merge-recursive.c: conflict using sparse should update file
>   apply.c: do not checkout file when skip-worktree bit set
>   reset.c: update files when using sparse to avoid data loss.
>
>  apply.c                          | 18 +++++++++++++
>  builtin/reset.c                  | 34 +++++++++++++++++++++++
>  merge-recursive.c                |  8 ++++++
>  t/t7114-reset-sparse-checkout.sh | 58 ++++++++++++++++++++++++++++++++++++++++
>  t/t7614-merge-sparse-checkout.sh | 27 +++++++++++++++++++
>  5 files changed, 145 insertions(+)
>  create mode 100755 t/t7114-reset-sparse-checkout.sh
>  create mode 100755 t/t7614-merge-sparse-checkout.sh
>
> --
> 2.12.2.windows.2.1.g7df5db8d31
>
