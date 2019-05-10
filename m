Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF06E1F45F
	for <e@80x24.org>; Fri, 10 May 2019 12:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbfEJMID (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 May 2019 08:08:03 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:36647 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbfEJMID (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 May 2019 08:08:03 -0400
Received: by mail-yw1-f67.google.com with SMTP id q185so4550677ywe.3
        for <git@vger.kernel.org>; Fri, 10 May 2019 05:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=6dqwGZehMidICaDYwZ/0W+hNN1cHtITkOI7G4ENi9Vg=;
        b=hWFg/Bi/8UhXafIE5h22qnVlUCBv7yVmBfYJwYYzoZv0mFOeSy15YyRI/Q3ozOghb+
         5aSDxBB7cbEInL4kwC4ywGg3siiulJBhzKNTWKvIYHRwMg/xZff+YKZlsOJK8OrUqFJj
         8ikc1jdlKRyFb/YaK3FxaIWadV1yRUuOKufdpvDELnA1DvE2PuVsAp/PFj10EmD0FKaE
         /g3AxeqFmNPnqsVJanTQ7N/BLJqEGhobomgsNQ2+H8IhMvbKtTHjjjBAFRTxGjho8dSf
         kbKNwU0TruVzoA42fbKqEEXBF3sh1SK2pwuxAYfTf55C851MfpSbzJH/lhpL+y8hm0Iz
         0WRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6dqwGZehMidICaDYwZ/0W+hNN1cHtITkOI7G4ENi9Vg=;
        b=WRnRUKYh/ICCM+sw3xrSHC1gNa7Okl0ZzR7e27xYQxMf6w21KFUSxlN3uv86uSOYP+
         +w2lgWORSutdkVhal374wYtj5H/8/O/wfsBKHVjC/6KGQYHwl73g4234oLaUIwbDmVdv
         cyPgJuadQZRPaHudighWvPOFrJrgz9PL+IJXRfUNEPlc3mpD16UtBzHuP8mAKkx6/XCo
         Rnh5fRZXBpXz0pmF+SJuDBE01Vwd61/7zHRjWcdYQyI1WposI5EelB6ghAErzdCfqHNh
         iWL32jxrq1AvQkotSpQ3QIjBJANL7FfvzZwYVLqKk45FQEoCUWFIJUuU4+BNA5dSaX2p
         JqFg==
X-Gm-Message-State: APjAAAXYL+SIqzXF7+ucBauJXRRlQhRGpVRC3kGLMnD4a26VrXe2Q4qH
        kiJ0NMnHbNY7NofYK0zQF1neQ9tLV1c=
X-Google-Smtp-Source: APXvYqwQ+0YqV08htI8qH25LGlKXgAZVQH0IN34SA2p6pNOghGGiU+E3qZR8m2BwHaHe1C+0ZUP9oA==
X-Received: by 2002:a0d:e0c3:: with SMTP id j186mr5426491ywe.160.1557490082145;
        Fri, 10 May 2019 05:08:02 -0700 (PDT)
Received: from [10.0.1.13] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id e6sm188682ywe.104.2019.05.10.05.07.59
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 05:07:59 -0700 (PDT)
Subject: Re: [PATCH 01/14] cmd_{read,write}_tree: rename "unused" variable
 that is used
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20190509212558.GA15438@sigill.intra.peff.net>
 <20190509212724.GA15837@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e05b6872-3078-afca-bb12-91d628f9c44b@gmail.com>
Date:   Fri, 10 May 2019 08:07:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <20190509212724.GA15837@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/9/2019 5:27 PM, Jeff King wrote:
> I kind of hate "cmd_prefix"; I was tempted to just call it "prefix" so
> that all of the cmd_* functions were consistent, but I worried that it
> really would get confused with the local variables (even if those
> variables are renamed, as I do here).

cmd_prefix is better than unused_prefix.

The only thing I can think of is "out_prefix" since we are using it
as the equivalent of a C# out-parameter.

-Stolee

