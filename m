Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB5821F453
	for <e@80x24.org>; Thu, 24 Jan 2019 18:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbfAXSSU (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 13:18:20 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40510 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfAXSSU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 13:18:20 -0500
Received: by mail-ed1-f67.google.com with SMTP id g22so5358233edr.7
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 10:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YiWLYxdAl0MV4lzJJAxCjEqbqYbzcNgerzn21ZWFoEM=;
        b=byNZucaatPoRy9NeJ7tzoLJfHJrF01WNwU2e9jp4KQXeLoeckh4HmIcJKlHWL9gend
         O32Uiy6Woiu3jk/8jHYCoVjgtwH9Sh7j7vyBV52kAHDvv4grJmAtLG78VOnQTzhktOA7
         8XyPLaikgcBbzgPH30IyantH6/dl0mjgXoerzFhBM8bQzEEPQRhRfLfC8fmgjcWsQdhD
         xkqRLcRqaatoA+P6aXjUxMJaS2hXLFRxnUP6BMLXZM5RF3yFVKMgXp+bbHZ0p2SBcdZ6
         jiCph+4sNrTMgdBecsuQ+reu1bubCGN99Lg4IDabGxupjqAiIh0DfDPnC3c7sdkFheGI
         iwug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YiWLYxdAl0MV4lzJJAxCjEqbqYbzcNgerzn21ZWFoEM=;
        b=NvmTNfrnsbudGdhITiahrxmpT1ri2IPssIghQV0aQdrDctYTrYnLusjIT6fGUxPRtb
         4SshUJDZr7VaroDGjDKcGKqm6HXLKfyyRF2TjsFwQcSMSs+PbWfaFeARu2nfQiPsNByZ
         KTws9Y3MJViVRO4trZ0f0k+KFwkr+2c0f4bQ6qygyqDzSGoso7kzCD5B1reBTjRjm+pq
         TSeWSIvz3Txsj3uXFHg0mrbFun0pCTlXHsoaI2AwXYhaD4fBPC/ZCYNV8My7a9CLL5DL
         x4BSN0ZEnwlUyUU71OdBYL1WRv+ln14YJp/33yCOmXohAPr5yzdhB5nQota+QhmMqQLF
         V1RA==
X-Gm-Message-State: AJcUukfcBWVIUMURpOBEre+xzGv7Ewpkx5GeTSyRLhVkpQZC9UHK5sjk
        Jehsf5d/rKjUQ5Nh7DRrCfm4/wkFySERq1+oRINvBA==
X-Google-Smtp-Source: ALg8bN6/S0Gxr7VTemAMUFN1KopRMUfxcAGeoodspDXx623pjN0lqun1jCWyfwwpT1dNkvugarFrBqKiN85OIuY9qPY=
X-Received: by 2002:a05:6402:1816:: with SMTP id g22mr7828418edy.191.1548353898415;
 Thu, 24 Jan 2019 10:18:18 -0800 (PST)
MIME-Version: 1.0
References: <20190124122603.GA10415@sigill.intra.peff.net> <20190124122728.GA11354@sigill.intra.peff.net>
In-Reply-To: <20190124122728.GA11354@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 24 Jan 2019 10:18:07 -0800
Message-ID: <CAGZ79kZqKQ8KEjn84dr7pB-T==jcMj_z-9MxB8aCrtPfpyzD=w@mail.gmail.com>
Subject: Re: [PATCH 1/6] t4006: resurrect commented-out tests
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>, David Turner <novalis@novalis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 24, 2019 at 4:27 AM Jeff King <peff@peff.net> wrote:

> ---
> Not actually relevant to the rest of the series; I just found this while
> looking for existing --shortstat tests.

Not actually relevant to the review, but my long term vision for
--color-moved would work with this patch, too. ;)

But now that I look at the patch, there are actual changes, as you
indicated in the commit message. Just more than I expected.

This patch is
    Reviewed-by: Stefan Beller <sbeller@google.com>
