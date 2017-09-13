Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2194C20286
	for <e@80x24.org>; Wed, 13 Sep 2017 12:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751421AbdIMMbp (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 08:31:45 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:43126 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751120AbdIMMbp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 08:31:45 -0400
Received: by mail-pf0-f173.google.com with SMTP id y29so105425pff.0
        for <git@vger.kernel.org>; Wed, 13 Sep 2017 05:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=2LVnp0ynohtf9WWwMDdCR8iSXDonkptTlE9p1h6YVXw=;
        b=mIXTg5ms8e8xT+gmPUJ9d6jgb+d3xQlIf0naes+bukMBoM12/LpWQupgb5C631JZPp
         zo33ZptWuRZvr5G4+NR4rXnTb8H3voS8JulqPjFiUlfmxarGyNPbNQGyMdhYJ8K3J612
         /l6qVUIvHW86Xc9L7M5itN3t3+S1z8kC5kZBVF+2dI9iZ1gQqcqFFBaCK7p8lsMBKq/K
         whtIUdWNb/Nwi+UOwl3TFHuxuxRGftPv8RCd+18+dxrzlLNi8Xiq594BkCUcgppVOVWT
         qe8sQbgjTZuA/W0b2ju7R3ZQggd6z2LdeNVK435bpOxVGtYKbhz1OHF46So9uOpMAdJp
         35iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2LVnp0ynohtf9WWwMDdCR8iSXDonkptTlE9p1h6YVXw=;
        b=il7PNLqJD5Dt+wG3YF10fosdMpw90eWSjKxPfIwvmrFRMbzaZ2RrM54JYZQwwWgcaM
         ZsXnM8yFwTpA6N6Ugfwd6reJcVLCUVZrNOleqphu2XaapZNK9q4HVBxv0lIIsIj5omXf
         WxX2i2xu1yRHYkrkbRNwEUijHj9ZP/obErI+qKgYScoZ/vWu2BwFHrzQA2ONAfB2qC5Q
         9aXvidghlYJPQh79iuu0mblTWCkZ03fDcXfPLyjmAJ543JBsleriHzgs5K61cU/0bRc0
         YNy/oBkwWk+3gT2XBi9lD0FXDcofFsIdjYXBpSLlBnLkwfxoRnAiVxtrMde4aqI1SpfA
         fC6g==
X-Gm-Message-State: AHPjjUijuUqnGtX8JVPGHUvVwwMK5Cxb5h3DKpxXY7PVkFgMvcTakd3J
        4RXsFz21849rsQ==
X-Google-Smtp-Source: ADKCNb6vvrrp5V3iEsAJhRywXVcaDQOVJVCAefnC5oGmgoLWvAfY8KvNvq/xX1K2S8oDuLK0nqZofA==
X-Received: by 10.84.131.101 with SMTP id 92mr13756067pld.97.1505305904653;
        Wed, 13 Sep 2017 05:31:44 -0700 (PDT)
Received: from [10.4.2.238] ([218.248.21.162])
        by smtp.gmail.com with ESMTPSA id f69sm20113860pff.4.2017.09.13.05.31.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Sep 2017 05:31:44 -0700 (PDT)
Subject: Re: [PATCH] commit-template: change a message to be more intuitive
To:     Jeff King <peff@peff.net>, Kevin Daudt <me@ikke.info>
Cc:     git@vger.kernel.org, gitster@pobox.com
References: <20170912105536.6094-1-kaarticsivaraam91196@gmail.com>
 <20170913102915.GA21499@alpha.vpn.ikke.info>
 <20170913112013.sk7bqarq2ktrva67@sigill.intra.peff.net>
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Message-ID: <624d873b-74af-b3e8-714c-8a439f4ee81f@gmail.com>
Date:   Wed, 13 Sep 2017 18:01:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170913112013.sk7bqarq2ktrva67@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday 13 September 2017 04:50 PM, Jeff King wrote:
> I agree with both of your points. It is very clear to me as a native
> speaker, but I can see how it might not be for everyone.
>
> Interestingly, the change here:
>
>>> -	const char *explanation = _("Do not touch the line above.\nEverything below will be removed.");
>>> +	const char *explanation = _("Do not edit the line above.\nEverything below will be removed.");
> actually seems less clear to me. I think of "edit" as "modify". But
> obviously it also should not be removed. Perhaps
>
>    Do not modify or remove the line above.
>
> would be the most clear. Or perhaps it is overly verbose.
>
Seems to be a valid point. Further, it doesn't seem to be too verbose at 
least to me. So, I'll change the
sentence and revert back to the one I use if someone finds it to be verbose.

---
Kaartic
