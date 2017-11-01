Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 304DE202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 18:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933031AbdKAS7y (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 14:59:54 -0400
Received: from mail-vk0-f46.google.com ([209.85.213.46]:50013 "EHLO
        mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932209AbdKAS7x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 14:59:53 -0400
Received: by mail-vk0-f46.google.com with SMTP id t184so2053976vka.6
        for <git@vger.kernel.org>; Wed, 01 Nov 2017 11:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=o5nn0R1WJKmbydfxfBHABSAs4JU5N04B7DfYuPYZ/YY=;
        b=kg3YzI4ppEyz57fpqDxeT5/KiveKr5l7UaoDqD2yMSFY4x46cQ9Tn+lpymKgLLCyCk
         d9H4Ypz42JN2HDvpB9KWrdnLUP9/QTCF35y8/nlZjl98+nIEWlusGVsEfHPBcFWpIdT+
         YIXYNKQ/78Pavd7fPn0erVzYIoPqGXNrCXQow1sSPMxz3iNJJ75Xq0uXSSv8gclVfO6Y
         nM4s01DA2KjnHtrSTx70I04tcVNOmWPyIO78WQ1UukNfOZHlOmVpA/l5nTrsBYlxClSq
         VlELUMB/bqkm1Sud2qdGfHCZ3RkK613Nyc0JPCU0p6O451BbyUYUBNCGW+CzsoI329Op
         I0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=o5nn0R1WJKmbydfxfBHABSAs4JU5N04B7DfYuPYZ/YY=;
        b=P4DyMYnFJ9PRuVHs4rk/n6kU8WCdLPWUkvIV85EeHdUjLTO/HAw0/0WEebOdB6lJAJ
         xajkrTycJeyryMr2oUgVQqJdEBB2lOons8v9clsK/pNFZUpFd2kNZsccQAweYUIghFsQ
         oRFC0F13Ry6HgQW+H9HZXvcQlw2lPs0jgLDP57Hb47I7321HXchS7+CrbU6YCIuGrFpZ
         c8TtJ09PMDKbgy9WuCCfUlhu1Ilr+aVXG+tAJxY6pMdsxvR0CpwguO9nLzCNYE777u7M
         7l4pHMp/wlCOQDYbFym1P6MrRQDCXiphn5I5IvunBzDTFEm/25s5ApYFKDIknZQTyoEp
         M8AQ==
X-Gm-Message-State: AMCzsaXKPFKu0iIH/lXbeRoFOm2mOURCs6Kvowr4vc7HEUY2sDAWpyX8
        RE7HeubDW5KuBrQzj7WIUtmQ1Yh6NVaizWhoqFgXFA==
X-Google-Smtp-Source: ABhQp+SCjFLKSxeCf0uQ0N1L/vgWVEM51cmO2Xizcp4FziTWO5E6eA6N/vUJfTu0uYXcJmyivj1HDs0BCQF3n3O1g3o=
X-Received: by 10.31.16.231 with SMTP id 100mr654941vkq.153.1509562792411;
 Wed, 01 Nov 2017 11:59:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.67.33 with HTTP; Wed, 1 Nov 2017 11:59:51 -0700 (PDT)
In-Reply-To: <20171101183829.mwoi7urka3hze3pm@sigill.intra.peff.net>
References: <CABPp-BF5Aitu05X83Lbm+8rWKojOnNNec_4bf5PRy+hKZGPPHw@mail.gmail.com>
 <20171101183829.mwoi7urka3hze3pm@sigill.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 1 Nov 2017 11:59:51 -0700
Message-ID: <CABPp-BFT+_WXyYFN1t18TLaLzZfJYtGAS3SqK3TxPT6toH-obw@mail.gmail.com>
Subject: Re: Contribution licensing question(s)
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, Nov 1, 2017 at 11:38 AM, Jeff King <peff@peff.net> wrote:

> This was mostly done for the libgit2 project, which uses GPL with a
> linking exception:
>
>   https://github.com/libgit2/libgit2/blob/master/COPYING
>
> When that project started, they asked for dual-license permission from
> various git.git contributors, which is documented in that repo:
>
>   https://github.com/libgit2/libgit2/blob/master/git.git-authors

Ah, thanks, not sure why I had mis-remembered that as being a jgit
thing.  Thanks for jogging my memory.  I think that (and your comment
to just grant other projects a different license) answers the main
question; I'll take it back and see what they say.

Thanks,
Elijah
