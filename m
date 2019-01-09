Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07BDF1F803
	for <e@80x24.org>; Wed,  9 Jan 2019 10:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbfAIKFL (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 05:05:11 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]:39213 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729148AbfAIKFK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 05:05:10 -0500
Received: by mail-wr1-f42.google.com with SMTP id t27so7003271wra.6
        for <git@vger.kernel.org>; Wed, 09 Jan 2019 02:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=DNZdht3jS2rWgTaoSpy5H2augUR9nVApdtbRiw5jtMo=;
        b=N5MV0Ld9cUOk/rPXG6IQ4tvryrvgsOnoxvCU1F1RLUh1qYwXCVLZvz9a+MBDMHMQbT
         5zNDbHPPug3SbsXHw1jXdP5Tq1F50+nIeTPMDhzxLQs1avUMUftAu0Y4C8AV7rvp/s+e
         gLxR4RxmoARsHPsULt2RHUojSjU6oqwxs1mhFJ8b1MSEd9iYlzsvf2BlB9NK9BZzjKBo
         nuXfLwcu3xW2aumBI0iRV731sz+iiO6laI9/1Ldf6Qvo/wFuTR6XH/+mgwsLIj4imzWJ
         n3IHQSA7CZNsn7e6+zwQ6sDdSW9IlWSL0le4ZWSDuhx42XndtDLBywrTY6unz28FO6vq
         cm4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=DNZdht3jS2rWgTaoSpy5H2augUR9nVApdtbRiw5jtMo=;
        b=WZF967cEOsnWDXCnRddOirh7lW3eEfUqkVJaGZD99YXX+0RyBHVut+67BWdNWJTDkp
         jMifJda0PuXOMv8aW7JpEMTyYud2ws2wkib9qjtzWs4j0G9w/o9vm1naVwEOplAf1fqh
         2EEQEEtAXA3rXaxAZZfowvLA1kj6x7/OPpPsakckZy6NBFkg2Rt9OG8EC6C/2c2pKfqm
         W2/8YzYwDRv1JQ7ueSjKcKkLVh1WkNhIIL+WcaMFLGVmOjW0lofynHNpmiKAygDOQpbm
         3Ng9PClrCsF/UJrhO5XPdsusqi9D0/aQTjGS7lAI1i58BEaiN9JEp+ZO5W78G1xVAuBl
         KGRw==
X-Gm-Message-State: AJcUukev257l8QUm1wWWEoZprWv3PcC3NTx2hByYSV6NVYzqWfrhh6sZ
        VWvbHppHTlrG2hH8xlXN/vM=
X-Google-Smtp-Source: ALg8bN7RxnDwkFo0hR5v28W0IGazmCD7RqBk/s0ABzHgUqaJDsrkvwzyX1IeHYwOdGJj41NPMv2ftg==
X-Received: by 2002:a05:6000:14f:: with SMTP id r15mr4727564wrx.53.1547028308797;
        Wed, 09 Jan 2019 02:05:08 -0800 (PST)
Received: from evledraar (i40217.upc-i.chello.nl. [62.195.40.217])
        by smtp.gmail.com with ESMTPSA id c13sm58862292wrb.38.2019.01.09.02.05.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 02:05:07 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Aleksey Svistunov <aleksey.svistunov@dev.zodiac.tv>
Cc:     git@vger.kernel.org
Subject: Re: Typo in a Windows installer item description.
References: <6412c78a-b09f-0652-26d8-a0a4e80da952@dev.zodiac.tv>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <6412c78a-b09f-0652-26d8-a0a4e80da952@dev.zodiac.tv>
Date:   Wed, 09 Jan 2019 11:05:07 +0100
Message-ID: <87imyy6t9o.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 09 2019, Aleksey Svistunov wrote:

> Hi there.
>
> I could be wrong but there is a typo on one of the installation step's
> text. A word sport instead of support is used.
>
> Here is a screenshot in attachments which shows where exactly the typo is.

It's not a typo, "sport" can be used as a verb meaning to display or
have a notable feature, e.g.[1]:

    Jen's sporting a new pair of shoes; he was sporting a new wound from
    the combat

But maybe that copy should be simplified. I think the GFW bug tracker is
the right place to raise that as a suggestion[2].

1. https://en.wiktionary.org/wiki/sport#Verb
2. https://github.com/git-for-windows/git/issues
