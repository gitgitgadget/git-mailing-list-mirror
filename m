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
	by dcvr.yhbt.net (Postfix) with ESMTP id E06781F461
	for <e@80x24.org>; Wed,  3 Jul 2019 13:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfGCNTI (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jul 2019 09:19:08 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:46424 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfGCNTI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jul 2019 09:19:08 -0400
Received: by mail-qt1-f175.google.com with SMTP id h21so798916qtn.13
        for <git@vger.kernel.org>; Wed, 03 Jul 2019 06:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Wj01CyTsG/lWtIbD62vk0l0EV6ypqc+VLqxHrhqwxks=;
        b=YE3TToEjfocuGFjJyjFiAunnReckdQgGwUnnnHREermEKNo2AwY0XL0ysqCuMLKtxl
         tx71DW9lVxYLfbGJSGxML9hxuR7osBlTvr9w+XaNPb3QgpK23OGB86NHI/8iy6m6cGJx
         8qJVdEVraYHnX4vTfNbuxzQtZroqapNW4HXH4mqpncjhdwOZP1+MpsbJskvq0h0mLVcs
         abDAznz5QEp6bwgNQF/vvEW+LsGf22UaFuXRSwlQMU88kO7A7un+KEuaF5b4ZkaFAW5G
         QpMbaSBCULj6Q81ofugmDxZ7VLNHoXvHSIWWWcxW0sONdykC1W9ukU2uGyYACG80cnzu
         JAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wj01CyTsG/lWtIbD62vk0l0EV6ypqc+VLqxHrhqwxks=;
        b=GeV8pfWNYM2DTZlfdZdaFlZRufQd3+Lm0IgdrAfLCm3TSlABywVtZn3akKUVQ4eT7j
         i2uO6cKUjX6hBYp8FohZBRPNBL6pexFTvsv76v7ufMfTjFzgUAVb47Nux5riYqqAq1Is
         B9O0nAxihsocwn8s30sYgkBOmMhF42fd+YWrKExG44kyqUR6zEi5Uz9BmHRRJiVgOIfS
         t1cFEZmEKl4p7ag12JIyJQ8yWDGbKiJ9vA2msD8OQD/c7tPQVt1KFRUzDPWwFqPpWI6g
         knafxGXskbQdJAGn0cjdbnvshY2ZyFUgwLnwOvL8nxkrFkk+dBeFlBvOYMzgWG699wKf
         3J5w==
X-Gm-Message-State: APjAAAWRuvOXUKAIT4a+j8N7fHFUPXNZC5PcJrGTIoGG8TQwySHXfmyO
        GEuKavdVJDALnytvNLGFONmNVzmZ
X-Google-Smtp-Source: APXvYqypDNYSvks/wwLedGYnFtU2Cmnb76KRdn6pCiaPy3/awLw5433pvVuPpmo9g4ufwn8k4ElJjw==
X-Received: by 2002:ac8:24cd:: with SMTP id t13mr30671475qtt.298.1562159947475;
        Wed, 03 Jul 2019 06:19:07 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:4874:bb25:bd6e:32d3? ([2001:4898:a800:1012:f9a7:bb25:bd6e:32d3])
        by smtp.gmail.com with ESMTPSA id k55sm1170381qtf.68.2019.07.03.06.19.06
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 06:19:07 -0700 (PDT)
Subject: Re: Virtual Git Contributor Summit
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
References: <nycvar.QRO.7.76.6.1907031429420.44@tvgsbejvaqbjf.bet>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9fc48120-a380-8152-9544-534e366d3fab@gmail.com>
Date:   Wed, 3 Jul 2019 09:19:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1907031429420.44@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/3/2019 9:01 AM, Johannes Schindelin wrote:
> Team,
> 
> I kept talking about this idea of a purely online Git Contributor Summit,
> and it is finally time for action.

Thanks for organizing this!

> To alleviate both of those points, we might want to consider spreading it
> out over a couple of days? I already heard some fierce opposition against
> that idea, though.

I don't have fierce opposition, but I do recommend one 8-hour day with the
intention of some contributors only able to join in the AM and some only in
the PM hours. We should not require all participants to be present for the
entire summit. By taking copious notes, we should be able to include the
rest of the community in the discussion.

Thanks,
-Stolee
