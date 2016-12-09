Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 994B01FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 12:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933227AbcLIMnM (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 07:43:12 -0500
Received: from mail-io0-f179.google.com ([209.85.223.179]:36064 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932945AbcLIMnM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 07:43:12 -0500
Received: by mail-io0-f179.google.com with SMTP id a81so50500554ioe.3
        for <git@vger.kernel.org>; Fri, 09 Dec 2016 04:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EUUeh+mJS3U0qOUgmHmwDDXtoDZzyHB6d2/2M7enueU=;
        b=sB0HBqEsRsMejy0Dj2Jm/oc+cC+05v7GjrQAd/LlsI+17RTgE0q9Zv/BopecNp8fY2
         /w1Mync6eu1T5Gpt9xWisOiHRlRGjmN27LO77b00NaQjW+SR9sbNVDPrZi+5eqWYu3jF
         2lFirq4RUI6cS0RcXhRPF+R9pTTSiB9rB7+GffEN/1C0rc4nx+/64+6+BEWC/QOBV3X8
         2f2ANv4WUfe9s7fPql85oPHf+M/ZQSDXTNmIGRjYrnOn626LiSp5z7imSOO7vg5CCiPu
         8vH29/Ub5YG00mymzckiCA3OuLk5gPxGAnttm+yrgdELaDOxW8B4YW330WIJRWa/NdTr
         XwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EUUeh+mJS3U0qOUgmHmwDDXtoDZzyHB6d2/2M7enueU=;
        b=jAxPdJ2xA8YzYyDZcnw4T/p1PfUXtGst1AM9aiRcbDTWwZoMZZrptHmXmd/9TuA0Sp
         52Fn7cJA4b+atzdnHs1qLt96jztUnMHTI0ScGZNyeZSh5tsNgoMb2n9Y3K4i8IU9Brwy
         6ePQqCI8pSF12XrMdP1hUDgtaXpBVLPPS0hbzoU3O9vLwEJoPw5IBbShRPVjNNUKDvP6
         bQRrXEcDA4KS3MAfoMHF0J5M0GCbrdtRgnlP3PQ1xFMBnw1DmDkTjbNcwdxC51X2TJ7G
         v+WIHTTPtgni5UwTdbfxns5FmWM++bwJI5Ij1m+aYXi/soCQZAwnqjxiUWoTXrpgeFoL
         9ubA==
X-Gm-Message-State: AKaTC01Zo+1JsXvcLiPCLju3zWHaiOcBYwiRVCH2tt4pUwsT+9pAphOTspvR9bjzPqoBB4uwAeXzJ9dxjbknfw==
X-Received: by 10.107.44.137 with SMTP id s131mr64810943ios.212.1481287390488;
 Fri, 09 Dec 2016 04:43:10 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Fri, 9 Dec 2016 04:42:40 -0800 (PST)
In-Reply-To: <cover.1481211338.git.johannes.schindelin@gmx.de>
References: <cover.1481211338.git.johannes.schindelin@gmx.de>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 9 Dec 2016 19:42:40 +0700
Message-ID: <CACsJy8DDwKhOBOxD_yOf2MfhxP4_TDDj3AwCf25ct6YH3TGp6g@mail.gmail.com>
Subject: Re: [PATCH/RFC 0/7] Pie-in-the-sky attempt to fix the early config
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 8, 2016 at 10:35 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Hopefully these patches will lead to something that we can integrate,
> and that eventually will make Git's startup sequence much less
> surprising.

What did it surprise you with? Just curious. I can see that I
disrespect the ceiling directory setting, perhaps that's that.
-- 
Duy
