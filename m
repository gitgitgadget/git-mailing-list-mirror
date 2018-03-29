Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6B291F404
	for <e@80x24.org>; Thu, 29 Mar 2018 01:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751213AbeC2Bcc (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 21:32:32 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:40567 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751195AbeC2Bcb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 21:32:31 -0400
Received: by mail-pf0-f171.google.com with SMTP id y66so2068610pfi.7
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 18:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LpdbexDGlycJgtmcBwD1Fh5pae9gjzGI7j5a5KA7BTo=;
        b=orF4AlMjk6iyQyvgCBnD43NOkJQuqsTSpES8EjJGzvd3jhG0BLYSavoVYXH6Vk6uOp
         5vcDvoR+rIHSsDKZ7goZki99azBUg40j3keVW9NtekYdRfjyRAilHy8//hwG7y/ZXlB3
         86i5XTwIOjMJNQxRishPDLqRone3l5su35OBE403IevaQrxfNe5RC4r4Gn6NVGBN2FDM
         3xziyKseaa03dUd5mOx5rqo06ZT2oRAC5L/FYBmHynBMk6TEHoK94lh3k/TIrLldjZED
         XQh4Oc9zJqWKdrcWlpMLIjke3+dd3QmBRXVsxK49ifLm2aKR45/LzpAM4DuetN8tosRG
         3LMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LpdbexDGlycJgtmcBwD1Fh5pae9gjzGI7j5a5KA7BTo=;
        b=SuIOs6EvhAyreXLpqkcclBDG8pSE+6xcARLlAro45aZ0ug1dCfq1xwMh0gPT3Z+Kln
         xWy903vMOySr+DieK4F3PzzZRFxE2arKrjD6+1r0aWBuzhf+d+KIIkGeT/leJ/gBxta9
         Dw5ZeVxI5Ba6A8Llv2CDfmZHq0psgd+AwC+Wgg13jEW3Jew7Bc+FIgpI6GsBLG+lW3WS
         epZMgeinX4NA9IgGkqzXTPIg+JCKgHKMNz9wwahA/14Xe17Rbs96Z2JEHI5MIwo+N9rq
         lALDeVPD2WWVte95BgriyabHpNWjiQ1LTitezwvpw7wgeOaMIdjAjUcCMVy5AI7HhabF
         rvAA==
X-Gm-Message-State: AElRT7ETNmuaAW6s79ubXowLCLvNPT6o6xlxu8QF69dhyXlhAGubVP1T
        som+PIOAsxFrab85pqUFQ9hYew==
X-Google-Smtp-Source: AIpwx49dlaRlU9M+s7iEY9+70MKAkcNBLrcJmlJGCqQh8S1YebVC0KI8nIBya9wYH82MyLLdP9TJaA==
X-Received: by 10.98.180.24 with SMTP id h24mr4683690pfn.213.1522287150710;
        Wed, 28 Mar 2018 18:32:30 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:ec10:419d:d341:c920])
        by smtp.gmail.com with ESMTPSA id g67sm8526263pgc.60.2018.03.28.18.32.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Mar 2018 18:32:29 -0700 (PDT)
Date:   Wed, 28 Mar 2018 18:32:28 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com
Subject: Re: [PATCH v2 2/4] Documentation: list all type specifiers in config
 prose
Message-ID: <20180329013228.GC71044@syl.local>
References: <20180306021729.45813-1-me@ttaylorr.com>
 <20180324005556.8145-1-me@ttaylorr.com>
 <20180324005556.8145-3-me@ttaylorr.com>
 <20180326085556.GC18714@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180326085556.GC18714@sigill.intra.peff.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 26, 2018 at 04:55:56AM -0400, Jeff King wrote:
> In fact, that kind of makes me wonder if this "type" list should not
> exist at all. If we instead grouped the options and said "these are the
> type options", then we'd only need one list.
>
> I'm OK to punt on that for now, though, in the interest of not holding
> up this patch series. I do think we should say something like:
>
>   Each type can be specified with the matching command-line option
>   (e.g., `--bool`, `--int`, etc); see <<OPTIONS>> below.

I punted on this for now, since rebasing on
tb/config-type-specifier-option makes this commit a no-op.


Thanks,
Taylor
