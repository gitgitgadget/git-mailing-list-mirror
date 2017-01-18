Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17FDE1F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 23:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751489AbdARXGe (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 18:06:34 -0500
Received: from mail-pg0-f49.google.com ([74.125.83.49]:36296 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751443AbdARXG3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 18:06:29 -0500
Received: by mail-pg0-f49.google.com with SMTP id t6so8098436pgt.3
        for <git@vger.kernel.org>; Wed, 18 Jan 2017 15:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Mew+vV2wiSNCJSzn/dewKfO1WfiivEBeLRmCj4l0hNs=;
        b=goVayr1udQa+HwGoxXu7eaM5bIsQ85wmt+yyxfMTyY1Fpr1fa5b7Ye8DYlRojP//st
         GzDHRWNMEnHgf90JTNZImnbxUG4faVqWYLQxrOgD7CRoEFHC7ZdMVTbrHxpl9Sa5QJig
         dPWic5QmOb89+WBRKRzSTWHIDcPbG+2tMsoJUysPvNrf9KNwuLhFnzCZ7tf+YJyvxfXl
         L+AcOL7gNl28tiZglAbLyLv2+/8jbAIIIuVX0qsdLqrxhfpaZRZ/GCzWDCMMZwve26vv
         UjVBWPUC2lOWc4girC1bBvVXE9diflGa0+p0shYmx6i6U1nVviG/bSZxomxmlqh0SD+1
         DMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mew+vV2wiSNCJSzn/dewKfO1WfiivEBeLRmCj4l0hNs=;
        b=TL7/2Mpv4jX1bxHDT2lJksycuCVtWhGb/gwZ3xm99NsdpiVeqjkAL2r4Otum+5jXy4
         PeGIBEVmyybhxVxZ/EC4gm51N3KOUlTGhE7dVwQ+tK39P2djYdv40l7M629/OiTdAuPu
         LPypaVUbo2zRZ1SUAugifK2njJ3P6lAaLuK7am61rKSYKsQM2Kel5jjVQCdkCJpSSEY7
         g+yZqcnjRuXZOA5alCQesy21h0nuaomRb7hse5R7Ys/ujg1bUtEpTx/AadPYdNKIohZR
         fIsCIPL4mWxMaREV33JMO2IfN7v59qer0/I2PmnRei3omHeSId0qu7rM2xuf+iNYFSRq
         bVbg==
X-Gm-Message-State: AIkVDXJ4BZfkthiDPyv8I3tZsOws1/VjqEwc0HHKmDjY/Cbfdu3EypRZZ359AdqR9NDePk+c
X-Received: by 10.98.133.202 with SMTP id m71mr6669058pfk.102.1484780743357;
        Wed, 18 Jan 2017 15:05:43 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:1d68:bc5d:3a1b:2ccb])
        by smtp.gmail.com with ESMTPSA id u124sm3235049pgb.6.2017.01.18.15.05.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 18 Jan 2017 15:05:42 -0800 (PST)
Date:   Wed, 18 Jan 2017 15:05:41 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] attr: mark a file-local symbol as static
Message-ID: <20170118230541.GE10641@google.com>
References: <89290015-7c5f-1a5d-e683-59077ae55bf5@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89290015-7c5f-1a5d-e683-59077ae55bf5@ramsayjones.plus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/18, Ramsay Jones wrote:
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
> 
> Hi Brandon,
> 
> If you need to re-roll your 'bw/attr' branch, could you please
> squash this into the relevant patch (commit 8908457159,
> "attr: use hashmap for attribute dictionary", 12-01-2017).
> 
> Also, I note that, although they are declared as part of the
> public attr api, attr_check_clear() and attr_check_reset() are
> also not called outside of attr.c. Are these functions part of
> the public api?
> 
> Also, a minor point, but attr_check_reset() is called (line 1050)
> before it's definition (line 1114). This is not a problem, given
> the declaration in attr.h, but I prefer definitions to come before
> use, where possible.
> 
> Thanks!
> 
> ATB,
> Ramsay Jones

Yes of course, I believe Stefan also pointed that out earlier today so I
have it fixed locally.

For attr_check_clear() and attr_check_reset() the intent is that they
are the accepted way to either clear or reset the attr_check structure.
Currently most users of the attribute system don't have a need to clear
or reset the structure but there could be future callers who need that
functionality.  If you feel like they shouldn't be part of the api right
now then I'm open to changing that for this series.

Thanks!

-- 
Brandon Williams
