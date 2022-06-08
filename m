Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4F3C43334
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 20:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiFHUwZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 16:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiFHUwO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 16:52:14 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156881B07B7
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 13:52:12 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id y16so17450818ili.13
        for <git@vger.kernel.org>; Wed, 08 Jun 2022 13:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qdM9c/aIIxWVDxvuUkyQOYh3dzzXM12WmBbpWQYLaZk=;
        b=O3yWH+x9Pp0XpGUZQ9zFeRQdUO2dFXSlyRVr+eU4zHmrQoEzcmaiOvuA9gP0F30Du+
         asusRRaKgHBlel1MPA1wpDVmOzQnBhPWlfkcVWozt6qXaX+A4zttyePN28BIhA6oArun
         q8ocOGrtPaOLh5Mul8yZWFX8w8vfDHU1UTtHy2HQ+Tvtt7v88SIERZ5lzsp9qPj0GOEM
         DpOBdoJYogUoyCb6UKbN8oHHVZaqPo63nseWAuk1n5N1zFuo6wXtya/6KtYlkvz76Y2v
         9qxVzAr36AN7Dyf+QZWKt+tIX3ENkgNQVhK6UO23mmu72HmWB1gko2SRowJt112IeRz5
         Mwpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qdM9c/aIIxWVDxvuUkyQOYh3dzzXM12WmBbpWQYLaZk=;
        b=ca4AUkAVMjOiFnClW3Gp7uVshngQyMUO+KylejuuenxBkAH8YOZGSpUxsVUdqRc2KF
         JAB9ji5R7Qlzn33iZP4OA9fLqoBJYqzJBY7A0IrT1ZtULJsNkZ/aLWbhO54owjORfLtr
         b+5+nhgfMTxJlGK+ABOlz0f9ZhqumbHJjZe8D71EfsJCqXQ5nCDWlzYBbUb9RMcGOGKa
         pYGgMOYd0t7e40JEXOAKMLGvlmqTZgL3min/un8edrf6sYYBSt85XqDScMFZ7sL+Xnvx
         anDtmLfdy+716FHVAM+REYwmyx+CpKWg17BmLRTLUVaoYWXbx2etsr6e6mZFlkprvuCw
         Sh3Q==
X-Gm-Message-State: AOAM530I4hdsm7FaVrIWwErD0vrojQgJ7HNMhPyCyc+NCCHolDg+MwKx
        YymSmxCvPgEDvzewjFz7pOkW
X-Google-Smtp-Source: ABdhPJx/WE6uiQtT1XqVvg6ZXAPWUtbqoSeK9TF31hFdtOtaMe6r6x1qy2D46aLi5NLWpx/AyTGh1Q==
X-Received: by 2002:a92:d68f:0:b0:2d3:a05b:6435 with SMTP id p15-20020a92d68f000000b002d3a05b6435mr21025050iln.317.1654721531474;
        Wed, 08 Jun 2022 13:52:11 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:90ef:16b:eb19:f653? ([2600:1700:e72:80a0:90ef:16b:eb19:f653])
        by smtp.gmail.com with ESMTPSA id i12-20020a02ca0c000000b0032e7d0a79basm8444125jak.158.2022.06.08.13.52.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 13:52:11 -0700 (PDT)
Message-ID: <ffc2defe-f6b6-e876-1009-b80a0a9b76e8@github.com>
Date:   Wed, 8 Jun 2022 16:52:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/6] docs: document bundle URI standard
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de
References: <pull.1248.git.1654545325.gitgitgadget@gmail.com>
 <e771b2971d092af5ea8a47eb708d03e34b284a0f.1654545325.git.gitgitgadget@gmail.com>
 <xmqqsfoh4ery.fsf@gitster.g>
 <9244644f-2c80-f23d-f054-3f0c961696af@github.com>
 <xmqqk09qrisy.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqk09qrisy.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/8/2022 4:39 PM, Junio C Hamano wrote:
> Derrick Stolee <derrickstolee@github.com> writes:
> 
>> How about creationToken? That communicates that we don't really care
>> what the number is as long as it comes from an increasing sequence
>> controlled by the bundle provider.
> 
> Is it important for the clients that this value is tied to creation
> time?  I am trying to come up with a word like "serial" that makes
> it clear that the values have no meaning other than that they are
> always growing in one direction to suggest as a replacement, but
> failing to find a good one.  The word should probably not have
> any connotation that they must be consecutive, but "serial" numbers
> are usually dense.
> 
>>> Another thing I noticed.  The above scheme makes it impossible to
>>> have <id> that happens to be "list".  I think the variables that
>>> apply to the entire list should be given two-level names, i.e.
>>>
>>>       [bundle]
>>> 	version = 1
>>> 	mode = all
>>> 	heuristic = timestamp
>>>       [bundle "2022-02-09-1644442631-daily"]
>>> 	uri = ...
>>
>> This then means that <id> can't be "version", "mode", or "heuristic",
>> or any other possible key that we use in the future, right?
> 
> Left ;-).
> 
> Two-level variable names and three-level variable names live
> completely in a separate namespace (there is no D/F conflict).
> 
>     [bundle]
>         version = 1
>     [bundle "version"]
>         url = ...
>         mode = ...
> 
> is perfectly legit.

Then I stand corrected. For some reason I thought this would
cause a problem, but I must have messed something _else_ up in
the process of testing it.

Thanks,
-Stolee
