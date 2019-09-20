Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D00641F463
	for <e@80x24.org>; Fri, 20 Sep 2019 02:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437062AbfITCSC (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 22:18:02 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]:46959 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393877AbfITCSB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 22:18:01 -0400
Received: by mail-qk1-f176.google.com with SMTP id 201so5632441qkd.13
        for <git@vger.kernel.org>; Thu, 19 Sep 2019 19:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Op6IpkynF/zCAKibwboT7FvYm4N8VehElrdpGu0BXLs=;
        b=LQxMVqfWAuc4s/nJrl3CmWWNLeXtlPKVsMlkZTtgnid4WasqtCGgldN/+h/cN99TIl
         EGxP/vet3LMo8kYNJ6sxRFkV1A8BBbi0go3jC1dE7fspY9zJudGTX+YDi5GPhmwlA4N5
         buIA+MZXy+smAkUC7ClSrEl2QbleNEPYsumpaQFkVVvB8IyAKe3d/jeHoDRtuMpcpjre
         iTnQX6Phn22KYYo6m1pcTIed5ORYDrkI2xK9oIpiKyuwF+jYuA5DS/mzBtvgkXiaAFuU
         GcT2SQJKRhRB20tOw6wkn2Buug1bxGHiVJ0IPiZvHPi76M1DfF9b67UaxJnie937zfPw
         4d9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Op6IpkynF/zCAKibwboT7FvYm4N8VehElrdpGu0BXLs=;
        b=T4d3IYbdmes6jg/9J+KqLaVIHxOXteGrQ4C9GgPxU+646IkNu36UlS/RLo51NlFWbT
         X53QyGtJvJliDw4dwDJRhftTlB383vrOi+C+nCIcQxSwXYQ1bE2qDdvz55uQmsYVnD7j
         sQwBHGvY1peE6A7Vt+5MbWxfaxakMstB2iyikjFAI4cvdTwDuqXxJpol/gqJA0Nhdsgu
         MmteF84b6vu5smaYiUw23ufVKu36G2sZmVujp/yRlFHUSYp9t0SIQyDrUqGVAoNfHO25
         WUOM+gQV6/U9xTOgWVR1oMagm1JHYdgdSGCwsImlrC7cNZQ1iepYT/TyY2rfXs0Gr42W
         8CaQ==
X-Gm-Message-State: APjAAAXkYBGEgqJWyDBnVheg0NjzIx0okapon6n2opSwNOUq3ZPL7K00
        44YAnXVLhM1SDTol54/4E7Y=
X-Google-Smtp-Source: APXvYqwKtz23Lkn71FAIuSBzgMzTJe4FoBez+2yOXYhAVjzwFDaJv+skZunveCVqMLAOhrzPWee3WQ==
X-Received: by 2002:ae9:f209:: with SMTP id m9mr1153397qkg.388.1568945880421;
        Thu, 19 Sep 2019 19:18:00 -0700 (PDT)
Received: from [10.0.1.19] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id i2sm277940qti.58.2019.09.19.19.17.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2019 19:17:59 -0700 (PDT)
Subject: Re: [DISCUSSION] Growing the Git community
To:     Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "gitster@pobox.com" <gitster@pobox.com>, garimasigit@gmail.com
References: <71fba9e7-6314-6ef9-9959-6ae06843d17a@gmail.com>
 <20190919221615.GA25636@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d13a8d01-065b-bfff-d279-c57cd0c0f7c9@gmail.com>
Date:   Thu, 19 Sep 2019 22:17:57 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <20190919221615.GA25636@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/19/2019 6:16 PM, Jeff King wrote:
> On Thu, Sep 19, 2019 at 12:30:13PM -0400, Derrick Stolee wrote:
>>
>> 5. Advertise that Git wants new contributors
>>
> This point is the one I'm least on board with. Not because I'm not
> thrilled to have new contributors, but that to some degree I think the
> open source system relies heavily on intrinsic motivations like
> scratching your own itch. I'm worried that advertising "hey, we need
> people to work on stuff!" then brings in people who are well-meaning but
> don't necessarily care much about Git in particular. And it becomes an
> administrative headache to try to figure out things for them to do, or
> get them acclimated to the community.

Your concerns are valid.
 
> I.e., I think we want to grow the community a bit more organically,
> which should be more sustainable in the long run.>
> So I think any advertising would be more about making it clear that _if_
> you have an idea, we're very interested in welcoming newcomers. And that
> to me falls under a lot of the points already made above: making the
> process more clear and more inviting to people who are already thinking
> about contributing.

I guess I was vague about this. It's not "we need more people to work on
our (non-existent) backlog" but instead "if you have an interest in
contributing your (existing) ideas to Git, we welcome you with open arms!"

Thanks,
-Stolee

