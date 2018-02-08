Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2672D1F404
	for <e@80x24.org>; Thu,  8 Feb 2018 23:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752192AbeBHXOI (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 18:14:08 -0500
Received: from mail-qt0-f176.google.com ([209.85.216.176]:35998 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750961AbeBHXOH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 18:14:07 -0500
Received: by mail-qt0-f176.google.com with SMTP id q18so1643838qtl.3
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 15:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=DkTRfg1apzmj0fA50i3gFNWaxyV6vHgd4ttmstZQ/lo=;
        b=HJ7xYiB/AowRkHxdgMF2mqkt20E2B7COaB9xdQUizbYkoh2kM//ume+3ylPJeChppI
         piU6CIIb/w1hGzRnzV30/7J3RE9GMUML5G7EJ0UgctOjC4JmEWq/DmcCvaWA9sw+rotA
         kX9y3n1S8oC67UpP7ehzt2LVwfzngKHhyZI/X+xBcvg2GWyPd9WPGLDoWmTHzjYtFkiB
         VqrN6mH66mSUyz10j0tAnwJErCqfi52XzPOw4N9fTCbFuj9kP0Jv3HLnaL28azXWOp7m
         dkSCLYbQuqWDRjiTFQ1LteXJucjVkpI9/ti/MOte6unUwToi/uDJlVKqLl5erBPtqE3O
         o+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=DkTRfg1apzmj0fA50i3gFNWaxyV6vHgd4ttmstZQ/lo=;
        b=nysbPyM/so8p4PaeI/Ldhi8aMtMJKkhViGHvOVKpwBZblphLNimp1UF9qDHOZ8uRAN
         yx+QOainVAIN8D11Yo+tzWjhB0uczETVy6Bc9FKIq5jEurDQgjKaRrEC9pRvi3lFLo9z
         aA9xTlT4KQ7jPUm9RcKjUJZsAf6lp2Hp14e+sP54DsOzC2i/PMx57hFXNjvWKGRV0HzT
         fJzueLRzjhhvDuXzz6NMXgDYaioaYhD1jqrYpgydCSPjKy9NwvpTOyF8sXC9yqvzmZ2l
         xoYGth+wn58lY2GnDvtufE98gPlAcEhk5nkeZ/r+FY0LK6P8sXzX+6Lc3rNz7YrT0HUG
         ErTw==
X-Gm-Message-State: APf1xPB7fcZ9CRSuCgqJMxIFx4eUQI2tD+Z2X9B7+fWP4mnuWMEVeaAx
        fbKhdZw7ERtO2tjDJ6/MdWbexToqWawj71RBPBI=
X-Google-Smtp-Source: AH8x226scsDhBXdWA56+EJwmPPOUeFmLIoCZnnBO/NBaOvpNVCTciOBERsQaUlsiPUdsloRTXvq8oPIKoqVBWpm2GVU=
X-Received: by 10.237.51.199 with SMTP id v65mr1463003qtd.184.1518131647203;
 Thu, 08 Feb 2018 15:14:07 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.137.133 with HTTP; Thu, 8 Feb 2018 15:14:06 -0800 (PST)
In-Reply-To: <20180208213806.GA6381@sigill.intra.peff.net>
References: <20180208201546.194935-1-sbeller@google.com> <20180208204309.GA4541@sigill.intra.peff.net>
 <CAGZ79kb+xEVZagqqNCHCPQUbfH89N7fdrO7dp6WHRGgJJje28Q@mail.gmail.com> <20180208213806.GA6381@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 8 Feb 2018 18:14:06 -0500
X-Google-Sender-Auth: 7YuggX7ermqvS7Cwx98mcaU8RVk
Message-ID: <CAPig+cT_ddVSEvdnMTNhtxWJMm4=DLyq8-hSDXa5X0i6rXa3xA@mail.gmail.com>
Subject: Re: [PATCH] CodingGuidelines: mention "static" and "extern"
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 8, 2018 at 4:38 PM, Jeff King <peff@peff.net> wrote:
> Subject: [PATCH] CodingGuidelines: mention "static" and "extern"
> [...]
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> @@ -386,6 +386,11 @@ For C programs:
> + - Variables and functions local to a given source file should be marked
> +   with "static". Variables that are visible to other source files
> +   must be declared with "extern" in header files. However, function
> +   declarations should not use "extern", as that is already the default.

Perhaps:

    ... as that is already the default, unless declarations in the
    header are already "extern", in which case consistency
    may favor mirroring existing usage.

or something.
