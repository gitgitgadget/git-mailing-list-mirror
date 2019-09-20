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
	by dcvr.yhbt.net (Postfix) with ESMTP id EB7841F463
	for <e@80x24.org>; Fri, 20 Sep 2019 15:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392205AbfITPUi (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 11:20:38 -0400
Received: from mail-qk1-f171.google.com ([209.85.222.171]:42435 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388863AbfITPUh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 11:20:37 -0400
Received: by mail-qk1-f171.google.com with SMTP id f16so7665290qkl.9
        for <git@vger.kernel.org>; Fri, 20 Sep 2019 08:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NYFcFK3pcrJKJPJmlYeQcmNLhZ4Yylf2GrveAqBsu+Q=;
        b=gPqNLBPakIfLNZtzz+lcbnkB73rLB8spFq2HQd4A1Pzvjfs3b7lgE4Pcu9Qjq/2kkz
         /r/taS6L7IOiQXOicufocehR5qqnomiwcWWVFkPvDA1nTb3J1w1xLRY1Lth5zI/qaKF6
         bpgPOoAFxz877siqpZ1BdvehxY6aFqmwIsx82os3/ssit3N0NkSwBsgi8+jc1CTytnn7
         wOXOlxscFsZZem3ah2enZ5F3Go4EroNHIwVbzB/FnJaTTaawPiigNbnRTnT0SAKkaN3m
         84YJDV7XXROypcSgSV6hIjjh8t2U2WI5pWu91ZX3keRENID2knZb0I2DpwohfRlppr3y
         lWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NYFcFK3pcrJKJPJmlYeQcmNLhZ4Yylf2GrveAqBsu+Q=;
        b=NhxTFdPm4oFpBMo5RHsvZ0oBeNY0itUb8RJVTg2BgrI+8kQN2ve0FN4wwNQCIdooiL
         RqhngKlzpWB/J95Mv75NRpTX+GzCq6XXzbIe3U0QUWLb6QMeuBZNgFNgTDCG0Pyhvx7q
         EMKzVl7spz/xb23KdQoTSdrIfqASDKKxELA9A8jV34oKG9Pg2Mzl3ZHjeS8XYYcvZ2Az
         Tpt6ZOcxfBt4tQ8Cupp/vjPTO/qBpC5/9/gCkwdSJglVSt/0jBo3OeoxaCtOqRub9POI
         xtLDs1jJ8GJvsK+wd9gZ5TkaXnO2o7mVrLqzEDdOnI4xigFMwxtBQQ+8vyxleAGjzpyM
         9GFw==
X-Gm-Message-State: APjAAAWj+PoMtoH/TF45LPYazV9n2lLSYVFDlhj5pDsqi1WSs1y2A1KZ
        rZr///6trUf6OYz2PbNA7dM=
X-Google-Smtp-Source: APXvYqwvQQjTduddjqgC7+K2V0RMBcG+E9a18nLMqwRko1cPk+pK6Bjv1EsQa1uq7wEwiibZOnCZbA==
X-Received: by 2002:a37:af87:: with SMTP id y129mr4066298qke.98.1568992836723;
        Fri, 20 Sep 2019 08:20:36 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:a0ff:8705:33f2:4791? ([2001:4898:a800:1010:5235:8705:33f2:4791])
        by smtp.gmail.com with ESMTPSA id o14sm1353978qtk.52.2019.09.20.08.20.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 08:20:36 -0700 (PDT)
Subject: Re: [DISCUSSION] Growing the Git community
To:     Derrick Stolee <stolee@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     "peff@peff.net" <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "gitster@pobox.com" <gitster@pobox.com>
References: <71fba9e7-6314-6ef9-9959-6ae06843d17a@gmail.com>
From:   Garima Singh <garimasigit@gmail.com>
Message-ID: <e264e5c0-baef-c8b3-8fd8-f186e78572a4@gmail.com>
Date:   Fri, 20 Sep 2019 11:20:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <71fba9e7-6314-6ef9-9959-6ae06843d17a@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for starting this thread. I am glad it is receiving such great 
energy on here. Apart from the some of the statements that sound too 
ideal, I agree in gist with the overall effort this will hopefully set 
rolling.

On 9/19/2019 12:30 PM, Derrick Stolee wrote> 5. Advertise that Git wants 
new contributors
> 
> After we put items 1-4 in place, we should reach out to the
> general tech community that we are interested in new
> contributors. It's not enough to open the door, we should
> point people to it.
> 
> This item is much less explicit about the _how_. This could
> be done at the individual level: posting to social media or
> blog posts. But perhaps there is something more official we
> could do?
> 

One more action item that I should be considered and people agreed to 
during the summit was to "Improve the welcome to the mailing list email"
I believe it needs to be warmer and more welcoming. It needs to break 
through the ice and intimidation that many new contributors feel. A lot 
of the ideas being suggested here can be linked into that email. I have 
a few ideas about what it should like and will hopefully send out a 
draft soon. Feel free to send me any suggestions you might have.

Thanks,
Garima Singh
