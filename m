Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 926CC1F461
	for <e@80x24.org>; Thu, 20 Jun 2019 21:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfFTV33 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 17:29:29 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37742 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfFTV33 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 17:29:29 -0400
Received: by mail-pf1-f193.google.com with SMTP id 19so2388689pfa.4
        for <git@vger.kernel.org>; Thu, 20 Jun 2019 14:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TK3PS3Mru2Hks8ATMIiWMCC1woelEFdfROGRHUpmsgY=;
        b=WGkyrJZjzUUq6GCED7KIPTs7A4Qs6sdKeIe+1gOkpRbfm7PzLlCepfTCXP/FwvZ6JS
         C8VzVHz6Jw/y3aeHnKt1uSjp7is5iB7RqYouBGfNa3ECiD4fDfbrQVJo6r8J34pNI8CA
         9ZtyUVdXLFDUjcNVp+IBEbg5dOFzLzOMbMSCDZWfiLUfZYOtOLZ98c9xCx0sEtTnIwH+
         zNVZktWXq0lKakusqIQKme7inBd1Ha5DClcj3hdQN5YHQai+sKffAgUEUoUm/UsgVjMb
         a4RR0Il1Cq5hXmM6e0n1tMKyotR/iESN1giDD15cINF2Tl9EkLFemuKZWB0oImgdkWge
         v8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TK3PS3Mru2Hks8ATMIiWMCC1woelEFdfROGRHUpmsgY=;
        b=V9Pis4msY5TNgBBoRYNDK0uPmro9TMt/6f/jbvtspE56Mg4VZBJJdfa4EXa/Jn4Ql0
         k0XCOv4IpXhR3EBHhLscQ0Kr6t1plpSvZbnWZrZyhm377xC0U0a03G7kzlbx4DvNVtQq
         3g/MOeqafZ13+JUNiOn/iSHfS2D+2nxce6+t93rc727k3e16yN4q32vMU9k1cRi1r+fV
         SV2Xp4Cs+L4s2JUrsnTr5ReirEbFUmqSLs+LA3QMMYxqOixo1J39HQUPBnMULmmWDC+d
         5455OFHNVdBazm6DRsJLJ+1NV9jyO+WuVIj0nLyWMSlycm0JwF3qfAcOnCSAXS1ojSCH
         ITew==
X-Gm-Message-State: APjAAAVr8z0oVO0PB5NRJgRjRK0vo4udWUazsrdeQ2y74H8IC6C1/TzM
        w/q7Eky0FdZ75ZzVmvwGbv4pvA==
X-Google-Smtp-Source: APXvYqyjwmXTkL7spzXHtrYx2tFjH1obmhcfsD33UiBozXNuJE2yoK1gbPI623rlUwYKw4OMKBZHDw==
X-Received: by 2002:a17:90a:d814:: with SMTP id a20mr1823958pjv.48.1561066168229;
        Thu, 20 Jun 2019 14:29:28 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:b186:acdd:e7ae:3d4c])
        by smtp.gmail.com with ESMTPSA id d187sm419317pfa.38.2019.06.20.14.29.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 14:29:27 -0700 (PDT)
Date:   Thu, 20 Jun 2019 14:29:22 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] doc: improve usage string in MyFirstContribution
Message-ID: <20190620212922.GB87385@google.com>
References: <20190619221315.7343-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619221315.7343-1-chriscool@tuxfamily.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 20, 2019 at 12:13:15AM +0200, Christian Couder wrote:
>  SYNOPSIS
>  --------
>  [verse]
> -'git-psuh'
> +'git-psuh <arg>...'

It doesn't require 1 or more args - you can run it with no args. So it
might be better suited to state the args as optional:

  'git psuh [arg]...'

>  ----
>  static const char * const psuh_usage[] = {
> -	N_("git psuh"),
> +	N_("git psuh <arg>..."),

...and here too.

 - Emily
