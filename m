Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 908E51F790
	for <e@80x24.org>; Tue,  2 May 2017 21:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751409AbdEBV4c (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 17:56:32 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35363 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbdEBV4b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 17:56:31 -0400
Received: by mail-pg0-f65.google.com with SMTP id i63so5226308pgd.2
        for <git@vger.kernel.org>; Tue, 02 May 2017 14:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hA1UfN8Sv0pYcP4ywA0T4vJ1XR7R7zR+Yb66pdN5ymM=;
        b=HGmBv+pldd7/7hRines+R80cZHTk2Rnmzsg3T2GJdu0gkkOIQonV2L376VkbnlLJt7
         QxVwnfYJI/mZSq/rHNq7Tw1kf/vhjqtirjurebCuxdL+6d4OrLiugMRDU0RPTOmKgS23
         NwBMoQLUlSD+kh6uDnIJcCV2BXrGSX7ee4SeSAnROR+YXN3BaN6Y5yOL9id9PmP2mEZB
         Po9muCrqG38dNRQecM5dL/ZgWEr7PREod8qtv+y9f0RqUjJoGGHGr0VYllM1KKSE8cj5
         Z1FBRLccqHooqcyLkHkUCBIQcp4NdnxNADb13aq82mS1nZLNuByH/Z/Trgzx31B/hEZb
         HxTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hA1UfN8Sv0pYcP4ywA0T4vJ1XR7R7zR+Yb66pdN5ymM=;
        b=heERxq+LdLFbBw1HdOZvLDdlVc88wQ6DC3lqtsCFl2k2y+yCg/U0zFQQI466/g3m3z
         CNK71NTmYPzEYf48ojGEQFCPc2a2bLwpIWXMLLHtBrF+2yqUm1I0LnkRkqGgeLNjtRFg
         unWNvHl/oFw5RhdFt9Sv0N+GJdBM6gRBwjCQ6vj4oJyhCzj0V3gVi3HQWzbK+qV7hCts
         jlB9AJRWJuypFO53HTZzPrEIvQnvc8fXIDM94SAOsiNpuQokjFRNA7Wecojj+Tx81yhP
         09qwp322yH5pxknqaorvHxQOLV9UjPa3pv0krzyiatajAcOmRT3hz442LE5v9RRQzSgt
         tgKQ==
X-Gm-Message-State: AN3rC/5Iv/jMVyKL50jeeQDf21anSjJFNLASuOd9xff6ZzAI8dDzTWQz
        NXUqaJv4YOinjw==
X-Received: by 10.98.59.2 with SMTP id i2mr1340487pfa.50.1493762190295;
        Tue, 02 May 2017 14:56:30 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:cd8a:5ca8:9391:9c00])
        by smtp.gmail.com with ESMTPSA id c12sm29670956pgn.21.2017.05.02.14.56.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 02 May 2017 14:56:29 -0700 (PDT)
Date:   Tue, 2 May 2017 14:56:27 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] Abide by our own rules regarding line endings
Message-ID: <20170502215627.GX28740@aiede.svl.corp.google.com>
References: <cover.1493728172.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1493728172.git.johannes.schindelin@gmx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Johannes Schindelin wrote:

> Over the past decade, there have been a couple of attempts to remedy the
[...]

I'm intentionally skimming this cover letter, since anything important
it says needs to also be in the commit messages.

[...]
> Without these fixes, Git will fail to build and pass the test suite, as
> can be verified even on Linux using this cadence:
>
> 	git config core.autocrlf true
> 	rm .git/index && git stash
> 	make DEVELOPER=1 -j15 test

This should go in a commit message (or perhaps in all of them).

[...]
> Johannes Schindelin (5):
>   Fix build with core.autocrlf=true
>   git-new-workdir: mark script as LF-only
>   completion: mark bash script as LF-only
>   Fix the remaining tests that failed with core.autocrlf=true
>   t4051: mark supporting files as requiring LF-only line endings

With or without that change,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

The t/README bit in patch 4/5 is sad (I want to be able to open
t/README using an old version of Notepad) but changing that test to
use another file seems out of scope for what this series does.

Thanks,
Jonathan
