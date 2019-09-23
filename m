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
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B9831F463
	for <e@80x24.org>; Mon, 23 Sep 2019 12:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394601AbfIWMg5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 08:36:57 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]:44702 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390719AbfIWMg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 08:36:57 -0400
Received: by mail-qt1-f169.google.com with SMTP id u40so16842039qth.11
        for <git@vger.kernel.org>; Mon, 23 Sep 2019 05:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+j0FNlLhAePzopGFiKeLuYs88F+kwgHeVjpCtOzWAUY=;
        b=EmhcSF+LJul7g3WqUlyjW+dqQXPeUSfz9Xg2tvXZWozYwSQDS6ImQr2/uEdrMUDvcG
         OnYN4i9ozIdJjc/w933df/NDRHIfakU+wtrQQpHjfvu/hYNgI444G30l2uQFpVe0xuLb
         1Tpz0zoSz1hOhCeq8eJBeTYRDGWmPGGJ9oyU407YLC1Kwh2AWrNfbiDjMVz1PxrKdtzY
         LCVWnxE9eIkhgZwKvwIeWcamqgzpzNevKwOBwI7B0EsYMqabIX8o2I3A2i98GCvxlOog
         YHJyJ3/PqHF6JFsVtgm1O/WAQwo6jI00dWOaMW9FmZSOgUxUPbs4Erx3jzj1O5nGO4mo
         CR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+j0FNlLhAePzopGFiKeLuYs88F+kwgHeVjpCtOzWAUY=;
        b=kIGSMdgTTdVG6x8J8ds9QJJ8DikoQR7iNv4rHKAUxQiCxVyEQ3VdmTeDHWtt6WYbi/
         PEjxZCq3LTYHB29jbH8yBB+74hy5VnhJuGisbM9eI3lEIT8+cOcQ7kG195mRxqEDr+DE
         NxBYIJcBg2loLv8Cc0q+5MURXceZFc6KY8oQy/38cNnCbPyNNCw+QoWaosy/atQNENDG
         sgBabnHr/i0VMWizWYzdGQUCu1zz1CA7BOEOuVfJTX7sVHWJYEe4K1Gp3vacioDlp5HG
         9/2zLtAie3Z9FYPv9PxK0VAmWE/88CWz7G8ssjWCPKF14PFE7nhqomiwmxCXl38e/zYY
         SQmg==
X-Gm-Message-State: APjAAAXEF2osFXsDdwgwCL62fD8+bJ1OJDGe8N429e5dmWkn65X5N0C2
        sdacM/lD4WOt80Tn2ehMKu0=
X-Google-Smtp-Source: APXvYqwYQA5x/PMbkUa+COcKi8RnO2TMo1gVKdXUUk7fTdtgVOygc60nkn26U9IXMGjP6CglrwfuEA==
X-Received: by 2002:ac8:1c54:: with SMTP id j20mr16816922qtk.302.1569242216332;
        Mon, 23 Sep 2019 05:36:56 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:8434:a619:c799:e8af? ([2001:4898:a800:1010:356a:a619:c799:e8af])
        by smtp.gmail.com with ESMTPSA id j17sm6692843qta.0.2019.09.23.05.36.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 05:36:55 -0700 (PDT)
Subject: Re: [DISCUSSION] Growing the Git community
From:   Derrick Stolee <stolee@gmail.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     "peff@peff.net" <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "gitster@pobox.com" <gitster@pobox.com>, garimasigit@gmail.com
References: <71fba9e7-6314-6ef9-9959-6ae06843d17a@gmail.com>
Message-ID: <e284245a-8acc-7ec7-c66c-e5b30d25f8a7@gmail.com>
Date:   Mon, 23 Sep 2019 08:36:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <71fba9e7-6314-6ef9-9959-6ae06843d17a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/19/2019 12:30 PM, Derrick Stolee wrote:
> During the Virtual Git Contributors' Summit, Dscho brought up the topic of
> "Inclusion & Diversity". We discussed ideas for how to make the community
> more welcoming to new contributors of all kinds. Let's discuss some of
> the ideas we talked about, and some that have been growing since.
> 
> Feel free to pick apart all of the claims I make below. This is based
> on my own experience and opinions. It should be a good baseline
> for us to all arrive with valuable action items.

Thanks, everyone, for the valuable discussion! I particularly appreciate
that everyone who disagreed with my misguided opinions pointed out the
flaws respectfully and moved forward in a positive direction.

That's a great thing to see in an open community.

Thanks,
-Stolee
