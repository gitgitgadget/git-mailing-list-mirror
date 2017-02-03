Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B9921F9AF
	for <e@80x24.org>; Fri,  3 Feb 2017 10:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753106AbdBCKcS (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Feb 2017 05:32:18 -0500
Received: from mail-pg0-f47.google.com ([74.125.83.47]:35246 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753096AbdBCKcR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2017 05:32:17 -0500
Received: by mail-pg0-f47.google.com with SMTP id 194so5808615pgd.2
        for <git@vger.kernel.org>; Fri, 03 Feb 2017 02:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8fQU5zdapOfofATLBQvp+FM7RlFyUGtNsuft4xAA3yA=;
        b=KlqQmCTz+glvUsklfphzZeGmiGpIVYSzt4SpcXDLFfyV6G0EZWgj/Kmknic4yGVp9N
         9F5l/DkUu1cXUVgyIg8uyHL4vlyX785EtYykf8Y+lNRPTOildSRl1RzBvZ97Ke1VCK9Y
         tSnEUXhbNotI8iRZNGS6oIl+l8YSm+BmRh26zT3kr4iooE+cK2q0TkKuwyRymXpSqsy2
         3GAYMhlcsMrTaosFvry2g0R1Y14xXGVBa6KpwqthCqr7Ws7qsAA8aa0W+R1Fx4k56Qdi
         CEjpmLNs8mPPDRhw4XHc0KQluI1K9/k92I105DOrSf6toN4hDAlBV5hvaExYs8aBk6Fo
         h6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8fQU5zdapOfofATLBQvp+FM7RlFyUGtNsuft4xAA3yA=;
        b=Uxok9UFkCIlwbDvQPg0eaV3wBZsg9V0R/V8SCLucYDrQDNuEkikhM1i52rdHPtkHLW
         6lcpa+U5LbScoFPcp0vKOQuewXNHqym6UlRQ/llp4EgJWfj/MCw4x01LvzDpeZE33VCL
         cIWE43T+Rh/e7g+Vw3kpYbkZSa1ebXhaDvbgK/4Krj04bvp4IgbqRgUZTD4oRH/yVpWn
         e11DcLnCFlXyyCRd0nrTzLz7hhzg9TiCtwEIr59b/mXHvuO5woNwu9SGJ3KW0Eg3ZJM3
         l7OWzhQG73js2kSdSZRVO0ZxNYZF+Zevv+9RQMfSdwQvau3OQSQ90NY5HCnvzGhjlp1x
         jbFw==
X-Gm-Message-State: AIkVDXLgc5flxtgsN4mxr9iVM+sFmuMgEhux9me1c30Or3BnW8Y8NLiR5XIMke8TYz24UQ==
X-Received: by 10.84.218.5 with SMTP id q5mr19822736pli.80.1486117936352;
        Fri, 03 Feb 2017 02:32:16 -0800 (PST)
Received: from gmail.com (50-1-201-252.dsl.static.fusionbroadband.com. [50.1.201.252])
        by smtp.gmail.com with ESMTPSA id c204sm65758840pfb.51.2017.02.03.02.32.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Feb 2017 02:32:14 -0800 (PST)
Date:   Fri, 3 Feb 2017 02:32:11 -0800
From:   David Aguilar <davvid@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: mergetool and difftool inconsistency?
Message-ID: <20170203103211.fnwdbm7shxduj2pn@gmail.com>
References: <20170126025810.GA3020@arch-attack.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170126025810.GA3020@arch-attack.localdomain>
User-Agent: NeoMutt/20161126 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 25, 2017 at 06:58:10PM -0800, Denton Liu wrote:
> Hello all,
> 
> I was wondering if there is any reason why 'git difftool' accepts the
> '-g|--gui' whereas 'git mergetool' does not have an option to accept
> that flag. Please let me know if this is intentional, otherwise I can
> write up a patch to add the GUI flag to 'mergetool'.
> 
> Thanks!

Hello,

The difference was not intentional.  The "--gui" feature was
added to difftool because that's where the feature was
originally requested, but there's no reason why mergetool
couldn't have a similar option.

cheers,
-- 
David
