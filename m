Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 102771F406
	for <e@80x24.org>; Wed, 16 May 2018 22:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751254AbeEPWTO (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 18:19:14 -0400
Received: from mail-yb0-f179.google.com ([209.85.213.179]:36092 "EHLO
        mail-yb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbeEPWTO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 18:19:14 -0400
Received: by mail-yb0-f179.google.com with SMTP id o14-v6so819372ybq.3
        for <git@vger.kernel.org>; Wed, 16 May 2018 15:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uHy4n5oiKP2PrcAdw80DoTbHQDGeO/+Zc49UQYt04WA=;
        b=sO4dCaC4lZjy1e2KCCaV9umDt2PorR4MFnrHNgW4T3Vi+hTUmJdZxOvR4n+9LeE8A1
         26HYkkRu/e/f2EqDXxgm0oe3TMFDwp+xXw1ADPmyBnCg0J6sy1BLDzbBPYhB6vPRnLf4
         w0h0em1Z8vrL1w/NpftRj47p08+n9sI5blk7qWG5yAmZHTMEu2KTCmg8vOTHvb9/qOoA
         BAemmF6OrDDXSCRJ/WAMo0fyhjUdL/wRAalKHhTweFhwufIHrC/cHvpzDpiOe7FuIOhd
         6/6mAK/LzkYiJMVS3bpNjaYO35z0aT4rAGaO2L59494QjVBTwuceUvSaH/iq55YDRKEy
         JdeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uHy4n5oiKP2PrcAdw80DoTbHQDGeO/+Zc49UQYt04WA=;
        b=THOoqeX/pdzvRQOAtxGHf+SVpcwwPZwXqqkoWw9NpYcwb2/K9GJx6deW3qW4ntB/Gn
         7+B9rK+w/BOPgeq1dXhNHxyd1jW/L/G98PEa8LDx+5bXm/gMLNYqnt1/lXIoLwy+KuT8
         z1w7kUH7nk4yssXmQ7a9xAZu92v3HHSxckD2wJrIrnBwc14/qsCFLeCEoY8DO9LXIIZr
         opPBw4dT/6/W3uKqJfKZdyV5jSaJ8W/wJXUFrhPWgDmVjy4AxiTpRUclRTvmQdqMZD3V
         CPQ0C+GI9e7xrcpuENgNc9vD+0YYYJ+i1o8t8JreN5/OrN8VvhgrDGx90Y0yZCv9zkY4
         CsHA==
X-Gm-Message-State: ALKqPwfBm7h3JUmLTuAqhMcknJ219yJhteAf4LRMcO5YmP9WNB3Qimo+
        hZUkmaNyPEA4lMPrQEFgnbuRpRuRdIlrpz4NdvRwdlpT
X-Google-Smtp-Source: AB8JxZotYs8GeoB5o5odh8FJEuj4zMPhxsrGEk0gU7Orku7wWLAEAHpTme1NGrnz+k+nOixwgWJywCK/7ekk8MuZqCM=
X-Received: by 2002:a25:500e:: with SMTP id e14-v6mr1471619ybb.334.1526509152994;
 Wed, 16 May 2018 15:19:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cfd8:0:0:0:0:0 with HTTP; Wed, 16 May 2018 15:19:12
 -0700 (PDT)
In-Reply-To: <ae96f1c4-add2-d9d8-f08b-a765fe277232@ramsayjones.plus.com>
References: <ae96f1c4-add2-d9d8-f08b-a765fe277232@ramsayjones.plus.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 16 May 2018 15:19:12 -0700
Message-ID: <CAGZ79kadJpWvgmLyO-=mk_bdGFvgjdOa=mZqPPTNctxCMkRFvg@mail.gmail.com>
Subject: Re: [PATCH] shallow: remove unused variable
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ramsay,

> That commit seems to rename the 'shallow_stat' symbol to the 'the_repository_shallow_stat' symbol, but at the same time adds an 'shallow_stat' field to the parsed_object_pool struct, so ... :(

Thanks for catching this! it shows again, how rebase can be a
dangerous tool if not used properly.
I'll look into this, and the solution most likely will be to squash
this patch into that commit.

Thanks!
Stefan
