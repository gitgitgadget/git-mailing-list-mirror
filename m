Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8081D1F404
	for <e@80x24.org>; Sat,  9 Dec 2017 03:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753548AbdLIDon (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 22:44:43 -0500
Received: from mail-pl0-f52.google.com ([209.85.160.52]:45707 "EHLO
        mail-pl0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752960AbdLIDom (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 22:44:42 -0500
Received: by mail-pl0-f52.google.com with SMTP id o2so140026plk.12
        for <git@vger.kernel.org>; Fri, 08 Dec 2017 19:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c/fmazF8ZQPkR5tc/+4FKApYSKLxOYwBQQrcYwbsEoU=;
        b=xyUUYY9Ym14AY5VgS0MX7GX/zSHb+EriXC2doSNfMRwQC6s+FEO1UvrEzz6bPHfPq6
         Q0+by94tRTfB+M4FlL8axHsTVJC2SaorkSCKNkKTWcL1RziQo4bsHKyVI/cX31WXEaSa
         6frx3A0+hIo4Bikx+2I06DCS3S2SGZFhuqr52QTMuJPr3uocYvqRjIbVAxND16KZGAc6
         B0z+NxRAxQc++cIqOuXzkxWKyybOdaAlRy/MMqLYNv9J1Ww0Nl48Us2LySXVn85LhaGi
         +b7jgEwmvQY9cuBl6ueOvWo3F86aXHxHIzSuEm7/eiWv1poSoMU5w7fRNNfbKoauGt/U
         XJRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c/fmazF8ZQPkR5tc/+4FKApYSKLxOYwBQQrcYwbsEoU=;
        b=PvespepgZhF4K12FmCsRvxOWcNTO5c78/JvsTtbwEkzdiuYxI1wH4TQk5RtXKhFpHP
         nTdxCvvh3mkSoq5WxXlB6jFTyzlf6HzRo1p7Lty/p4PIw5p6vBYmKmgUQuwucqOY1z0y
         TeBddYKVcCl4Dk3RLfsuHPNRMYjHT3atNCUwvHSJLjQcUAhDed74+YcIWkaJk4MYi2w5
         FrNgJNhDk65yYs0QhvWGHlKM3p0B/rH2MxfIrW8Q3+YkpkDQsHxfuQGZdICbsU0dAZyY
         +fMWcrYcx+CSFt/IPeb6SWGVJ9ILjRqGRell/JefhZhuqxj+MpMKm1sH2w3+/n3tFIvQ
         ksOw==
X-Gm-Message-State: AJaThX6Gmox+VSB/h6LHURh2H+8LAPUZMezMx8ieMQOr//51mWX6NjOb
        LJFZO9cTlQDmQX6PsIOXDWJrYaOCyxU=
X-Google-Smtp-Source: AGs4zMb86DieYjZfp/pM06sQF4FHp/f6k2HgEs3OO6Y2F1jtod8SzcjMCFRalimBEgEaMTbWQQhvLw==
X-Received: by 10.159.233.198 with SMTP id b6mr33254784plr.350.1512791081390;
        Fri, 08 Dec 2017 19:44:41 -0800 (PST)
Received: from localhost ([205.175.97.239])
        by smtp.gmail.com with ESMTPSA id t4sm15402119pfd.110.2017.12.08.19.44.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Dec 2017 19:44:39 -0800 (PST)
Date:   Fri, 8 Dec 2017 19:44:36 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] docs/pretty-formats: mention commas in %(trailers) syntax
Message-ID: <20171209034436.GA43611@D-10-157-251-166.dhcp4.washington.edu>
References: <20171208051636.GA24693@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171208051636.GA24693@sigill.intra.peff.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 08, 2017 at 12:16:36AM -0500, Jeff King wrote:
> Commit 84ff053d47 (pretty.c: delimit "%(trailers)" arguments
> with ",", 2017-10-01) switched the syntax of the trailers
> placeholder, but forgot to update the documentation in
> pretty-formats.txt.
>
> There's need to mention the old syntax; it was never in a
> released version of Git.
>
> Signed-off-by: Jeff King <peff@peff.net>

My mistake, and thank you for giving this your attention.
