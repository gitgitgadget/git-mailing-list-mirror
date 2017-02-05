Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD6C81FAF4
	for <e@80x24.org>; Sun,  5 Feb 2017 22:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752581AbdBEWp5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Feb 2017 17:45:57 -0500
Received: from mail-lf0-f53.google.com ([209.85.215.53]:36577 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752166AbdBEWp4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2017 17:45:56 -0500
Received: by mail-lf0-f53.google.com with SMTP id z134so35723472lff.3
        for <git@vger.kernel.org>; Sun, 05 Feb 2017 14:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ybno8L1iH2KHlOUGyWoj4hTljLVCYTXyMDkop5JLGSA=;
        b=qJR7dd7P+VuRHs4m3uoU4MBqmjc1SmvenLcxE46nldbV3sxRSGtTQgb/uwbWXA63cf
         3NW78uvsUwRz58T/6KXqw0H+nU2wOdnsSxy/yMrAWcB0pG7Mbt8Ns3pxhvRGB2TORCta
         I6+PSaAGxQwy+SWuhBftDgv5cpUmXQ7rM3fWIAZSmUHpxnzUTTTaqss+V9WFHzg+aus/
         Erv8B7RiLik4PZcoxaHiLXihq3/+nQcSAO9iorjxIOQuaQO5HMYS/fLbL4Qg6FKLfrDj
         u7BQUW0IBHg2a85/J4MQZQUHMWso5K3C6+uH0YMRy1p0gN61f+3yWugH4HtvS0y+npZW
         bVTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ybno8L1iH2KHlOUGyWoj4hTljLVCYTXyMDkop5JLGSA=;
        b=fFLmZxc5rAy0e7Z2wvFOpP4V7w3MC6b2d4ttr3ZhB2jTsIQTER9T9zdDrmwKEDLc8W
         AnfETvGdd9l1a6E7u/kkXtkD50t+bRDCjNUcSstBebomBS4dgyOOh0fQh0Ys5MMlS+qX
         lgcNAslrITe33BnX9wFCFBn8LpDPdu9Xqf/JtSdnipOKMxBujcc/pcyn6y0nAW/BYOSr
         xEtyuWNCQ7qmN+LtWfdoi/vphoIuNvtgCzviwS3HkA/x3bX2bsyOFqB89Vx8CNhs5i4Z
         RB/SvWBBdtdO2MwFbha23gv1aPOCqGRwEfC8jv2ylk/8FbM510PCHstIrjKiu1xFJPnT
         4/fw==
X-Gm-Message-State: AIkVDXIsZliqxUdNFWKt/Dzal4T3NjwUGZH+cel3mZ4RyNRDcCUK4ehlxt8ev0OJPFThuwvh4e4uIH/BAIhRrw==
X-Received: by 10.25.79.79 with SMTP id a15mr2575188lfk.58.1486334754252; Sun,
 05 Feb 2017 14:45:54 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Sun, 5 Feb 2017 14:45:33 -0800 (PST)
In-Reply-To: <CACsJy8CTRcDuRiNeutG82iAj8qQFp+z2nadFfdkkHQGk6GKppA@mail.gmail.com>
References: <20170120102249.15572-1-pclouds@gmail.com> <20170120160942.srqf4y5w5r6feidw@sigill.intra.peff.net>
 <CA+P7+xoMTX5n_h+5MytZwVqKjqa0wdNKCeDtH29A_+WSfr6gTQ@mail.gmail.com> <CACsJy8CTRcDuRiNeutG82iAj8qQFp+z2nadFfdkkHQGk6GKppA@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sun, 5 Feb 2017 14:45:33 -0800
Message-ID: <CA+P7+xr3e4ER_p-Y8+A+3zE9-cgWEBBi1N9fsHRXKxNz+vd6=w@mail.gmail.com>
Subject: Re: [PATCH/TOY] Shortcuts to quickly refer to a commit name with keyboard
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 5, 2017 at 2:39 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, Jan 21, 2017 at 2:16 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
>> I would be interested in the code for this.. I'm curious if I can
>> adapt it to my use of tmux.
>
> I stumbled upon this which does mention about git SHA-1. Maybe you'll
> find it useful. Haven't tried it out though.
>
> https://github.com/morantron/tmux-fingers
>
> --
> Duy

This sounds almost exactly like what I want! :)

Thanks,
Jake
