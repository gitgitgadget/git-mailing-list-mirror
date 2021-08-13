Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8120C4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 18:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEACA60C3E
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 18:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbhHMSDo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 14:03:44 -0400
Received: from out1.migadu.com ([91.121.223.63]:49979 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229607AbhHMSDn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 14:03:43 -0400
X-Greylist: delayed 361 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Aug 2021 14:03:43 EDT
Subject: Re: send-email issue
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=benaaron.dev;
        s=key1; t=1628877795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s59wRu1PTw2CFoFKP7X9vBL1NfcXWMbuWpiNDofcFkc=;
        b=K/DPnp9RujxptDPxIS8vZ378KlxdD0XFsob3kv/0GNPAe8gKx+2la9scFRVUfzNKltXD4U
        sEpGmfU8ycmbKpag890hg45Q5bOWY8QjhAAa1WStqrmXSrXLbd+UeJ1E1VuuI4pTaQ4eIp
        3/6YiLWl8HdWXMWT7FSNtfGKN7UkbHy90rbtW4L1xafi8JRl9H3lZtHWlDd/bqyxyjM7U1
        pnlGYyb0ji3iYV3sNlYYZUlbJUyRy8wZqz7qqqYZejmEG4pCeg25Bp20ybHFaKGOKfHuzo
        6n4OjtgIvPLXI+8iPb2Vwxphay5BqbqQMbWUaSKmXkXpvT1fIFKf5HE09Tvr0g==
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     git@vger.kernel.org
References: <24a88faf-5339-8449-80c4-f6085bd1e098@benaaron.dev>
 <b4b1dda4-6bf7-f4b1-88c5-9d579a7c56d3@benaaron.dev>
 <20210813180056.ctzivmakj4bj5apa@nitro.local>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Ben Goldberg <ben@benaaron.dev>
Message-ID: <f7ee6a03-74f2-152e-5158-4103c744595a@benaaron.dev>
Date:   Fri, 13 Aug 2021 14:03:13 -0400
MIME-Version: 1.0
In-Reply-To: <20210813180056.ctzivmakj4bj5apa@nitro.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: ben@benaaron.dev
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> 
> You should use:
> 
> port=465
> encryption=ssl
> 
> OR
> 
> port=587
> encryption=tls
> 
> I know that this is confusing terminology, but "tls" stands for "StartTLS",
> which works on port 587, and "ssl" starts for "smtps" on port 465.
> 

That worked! Thanks so much for your help!

