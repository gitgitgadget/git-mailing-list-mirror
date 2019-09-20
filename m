Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 722E21F463
	for <e@80x24.org>; Fri, 20 Sep 2019 15:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393454AbfITPWj (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 11:22:39 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33141 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393434AbfITPWh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 11:22:37 -0400
Received: by mail-qk1-f196.google.com with SMTP id x134so7731185qkb.0
        for <git@vger.kernel.org>; Fri, 20 Sep 2019 08:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AamKrdvU3BkR873xXo20yAH1NkNPkO6rclG/+77dKl4=;
        b=ZYXKmRvmWqBTDJF1WK5k13igOm9B8+yaqD+Lzs8+DXRJNkUvEpgRuiMNZm2nxZ9An4
         WT+94Yq/Lnol4zwi/RfSLvDZBR1zCLbw4XdfeKak+HXEeXyysQsYxw3Pn/boB175AWF8
         RtjU2dxWUBBfcY4AWfw0qZUclBWJWDix/Z+Z88MrjY5Q32oHnc6BZbIgNb38bdyMgYzM
         AwUH1TU+ijZqJ20MMr+z/g/Da9gxLhm3vfG+ZhdRbOGoA6xJVnyBlKa7weckD6hK3FjG
         pPTdR8bT7B1wi097ErbeiUPPhr7n6kVfrO3h8jYz4910oMaLFN/ZMvvIPnAPipvGJbY3
         y6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AamKrdvU3BkR873xXo20yAH1NkNPkO6rclG/+77dKl4=;
        b=s95PxYsnF4EOW/By3NEW6rbEsRdXYmkxGGZOT9V5ILRg6EIWYMJZuLLLtFNRPL2OFt
         enAey8PHCBVdLMgO3dPCVl6wgaE+Q5Tn8YGowuWwQqrMql8XIu0TlNzlZTPXktUOz2rY
         LC8YxeDtQP8Lnu/LuQGdVNW7E7ClWx9nHgDAbRT39k4+0sTpGCUSzwE37aoqdl792R2E
         tGhdNpJC4IsYVuutV3SOy9vOzPfk0ma1Z67fxSOlyAfMUwZoiJ9GIMvfvOADdvbdsZ+P
         Ur2p6KBc3GbgFZ0oCOszDJrF2uL9Bs+Jze16uN5XWKsjnwxGbqvoCDOHeN6s1AXcNHOK
         eEBQ==
X-Gm-Message-State: APjAAAVr8NVan6OY6B+XpWm+ynZENKkvVtk0nMXjgBi6yI8NfVN2MxKp
        Kf1Svvy1euP1zxmigT07WdY9cgU2dEY=
X-Google-Smtp-Source: APXvYqzLWk2JfZLViqebJsDyxs9nbfVsOE0cvhWyl0cZxFdjoRM4Xe3vFk9s8FkvNkxG1xhcN8/1aA==
X-Received: by 2002:ae9:e817:: with SMTP id a23mr4169484qkg.294.1568992957029;
        Fri, 20 Sep 2019 08:22:37 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:a0ff:8705:33f2:4791? ([2001:4898:a800:1010:5235:8705:33f2:4791])
        by smtp.gmail.com with ESMTPSA id 56sm1866092qty.15.2019.09.20.08.22.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 08:22:36 -0700 (PDT)
Subject: Re: [DISCUSSION] Growing the Git community
To:     Denton Liu <liu.denton@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "gitster@pobox.com" <gitster@pobox.com>
References: <71fba9e7-6314-6ef9-9959-6ae06843d17a@gmail.com>
 <20190919173423.GA70421@dentonliu-ltm.internal.salesforce.com>
From:   Garima Singh <garimasigit@gmail.com>
Message-ID: <7819b52e-9222-8158-d26d-bf4ab2eec498@gmail.com>
Date:   Fri, 20 Sep 2019 11:22:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190919173423.GA70421@dentonliu-ltm.internal.salesforce.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/19/2019 1:34 PM, Denton Liu wrote:
> Another discouraging thing when I was just starting out was sending a
> out a patch and just getting radio silence (especially the first one, I
> wasn't sure if it even sent out properly!). Perhaps in the main list, we
> could get people to tag with [FIRST PATCH] or something when sending in
> their first patch.
> 
> If the patch is not desired, then we should explain why it wasn't
> desired instead of just leaving them hanging. I know Junio is too busy
> to say "hey, I'm picking this patch up" to every single patchset, but if
> a patch is desired, perhaps the rest of us could pick up the slack and
> say, "hey, your patchset was picked up by Junio in his gitster repo on
> this branch".
> 

I absolutely *love* this idea!

Cheers!
Garima Singh
