Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52C5B207D6
	for <e@80x24.org>; Tue,  2 May 2017 01:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751193AbdEBBFc (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 21:05:32 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:35852 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750830AbdEBBFb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 21:05:31 -0400
Received: by mail-pg0-f49.google.com with SMTP id t7so52230047pgt.3
        for <git@vger.kernel.org>; Mon, 01 May 2017 18:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+9pDdLOFcjlJGaPbnqdH7UqNOZcS5UW3mMn3LLndkLI=;
        b=j9/fv0unUQQ/M08AUErOWGn8qsqQQJ2glSSc+1khxwvkbdqaJa13awBaI/LZbBoU9T
         WQYYQx+WXbzL9CJ2TUhRzwAemBepNAL8dyJ7mTYuAneP1dkQ015Ku2SPLWqYkd0y+cTA
         CmLJl0OadMZWqpN+SzVD8pYLpN8KgcBNRMJdUsnZcLHmYInneQTmxjiPJdCHVJw4XX4v
         WKGwx8Vm89IhU5i6RtTX2F9TFDHYQS1YwTBLMxegzo1PFrFIOhcGbNlVud7D8yKKL7Jb
         qq+TJXIOJDJUOvanWXROhaP/V7q6zeNz9PFM6s0HNTnMQkl0MmGetr/zXDmw6NPpDaR8
         8iIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+9pDdLOFcjlJGaPbnqdH7UqNOZcS5UW3mMn3LLndkLI=;
        b=B8C1D2IBtnpT7Hz3Kd9zYBFCmAb50wD5K9QEtemepmb0SSxkvsIzLkatqSM7+3NaVn
         zA8mrhUc3Dz9YfBJCobGjBFBcYgVxXFOgo7G8nujyQcm6oUWFF9iio0RS/uPaBvCNPzn
         Z+w5y8SrTqpWlcGos+C7GV42x/+Zvdf3BjSwOz7EvY8dL+e+vwDNHUXE0HTje2coxNS+
         e0ySLlYbRzJb4jVTJugz5gCkjGJ1VqA6QbfHMZuxhfd5IAdpPopCElYEEoEpz3PYU0rW
         /Efr16ydyqjK3XFlArOnTwDcr1waPnSUq2rkxx3widV+h3gtWawx6X/rXRvhsw6ngYtp
         C0Zg==
X-Gm-Message-State: AN3rC/5JiCfuSijfICe5Ef/Yv4YVJ2yjoPoViNGjP2a4ChgOd41V3hwO
        uInhonAojfbTX+AwfHQ7yyC0VGThkPnU
X-Received: by 10.98.213.194 with SMTP id d185mr13264619pfg.35.1493687130944;
 Mon, 01 May 2017 18:05:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Mon, 1 May 2017 18:05:30 -0700 (PDT)
In-Reply-To: <20170502010239.179369-2-bmwill@google.com>
References: <20170428235402.162251-1-bmwill@google.com> <20170502010239.179369-1-bmwill@google.com>
 <20170502010239.179369-2-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 1 May 2017 18:05:30 -0700
Message-ID: <CAGZ79kbq_WSH01yE+oT9aagmyPWF55eCmU_2Dv_k1soB9-bwnA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] submodule: rename add_sha1_to_array
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 1, 2017 at 6:02 PM, Brandon Williams <bmwill@google.com> wrote:

> Change-Id: Ia6d15f34cee4d0dc32f7a475c69f4cb3aa8ce5bf

Uh?

Maybe another side project for the long todo list: get git-trailers into shape,
such that it can be configured to yell at you upon formatting the patch or
sending email when a given trailer occurs.

Thanks,
Stefan
