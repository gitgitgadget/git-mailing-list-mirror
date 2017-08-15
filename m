Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7428B208C4
	for <e@80x24.org>; Tue, 15 Aug 2017 17:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753415AbdHOReu (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 13:34:50 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:38878 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753402AbdHORes (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 13:34:48 -0400
Received: by mail-pg0-f45.google.com with SMTP id l64so9519720pge.5
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 10:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EEh28l9eQLY8LTEcp8nkOdHezs9njjHTNK9Jgrwn9oA=;
        b=r9GgrOTQrF535wQ81B+u3atAzNQkCpv30eQMDXUeearZYRQwciTAmEd4+8BxkzdOVm
         kFVUn7aZJqLhYDAtI6s0EhCWVFU0e/OlMLkx7e/rxf+xlURffMXcuiTIoNRGC81lhFBf
         E6+t586R2MPA02ji4SJixh1Xt69BYZcNIqSnL6G/dH4ghSjGOhPd/BA2/3lLFDJHfxdF
         hreK+HcW4eSvqlIJHKYCXEBDr0ji8tnfe7McDCU9OTBe8NY/yQ/8YYYORtEzQE6qBNef
         ouZhAgd3JzZx5HlOjSXhuTvbBUswsZ3YXlrEiz3e8UayCD0OdWulhXMXTglQcxViSUnX
         Z6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EEh28l9eQLY8LTEcp8nkOdHezs9njjHTNK9Jgrwn9oA=;
        b=B4m6pkCAnC2ETi7CO2l38AaR2scrujbtJCZfsDBAoKOG0BG0jJhBPkJ+KVPtynlE/k
         4pT5weSFe2yWedAeA3DR3l53E97w37bEz7YSN0lxdoeP4FoDXe9A1MuUAbpgyJCILCN9
         1daV03z3VvXp63fUc1Lhfineu1PmVJKMOTQV+Ckjri1iXeFB8U1LyFQdm6ASOw5L2vgK
         MnFot/fECltJ1qVpzbBJk2YesniwnB72LKiN+99Zlt+fuVWwBY9fpYPGpvE+/H44IZwF
         6X68u8HA6yTuEo9aGkVKXe5Rwh+TmDPL7xDYMhrOtdOvsrQsWjw6xdqZBjkILMMmDeyF
         cV3Q==
X-Gm-Message-State: AHYfb5iNhxHcNy+lvVvT+GzA8y8RFxVeTrCb79GNQB+kjJX2EeHyEobb
        tvRpv5H+rGPgrrxH
X-Received: by 10.84.131.101 with SMTP id 92mr31608137pld.84.1502818488088;
        Tue, 15 Aug 2017 10:34:48 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:593a:8ead:b053:9e22])
        by smtp.gmail.com with ESMTPSA id q21sm2898403pfj.126.2017.08.15.10.34.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Aug 2017 10:34:46 -0700 (PDT)
Date:   Tue, 15 Aug 2017 10:34:45 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com,
        Johannes.Schindelin@gmx.de, jrnieder@gmail.com,
        ramsay@ramsayjones.plus.com, peff@peff.net, avarab@gmail.com
Subject: Re: [PATCH v2 1/2] clang-format: outline the git project's coding
 style
Message-ID: <20170815173445.GA21874@google.com>
References: <20170808012554.186051-1-bmwill@google.com>
 <20170814213046.107576-1-bmwill@google.com>
 <20170814213046.107576-2-bmwill@google.com>
 <9c9a9b98-9308-95d6-a912-85a49bd3e21d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c9a9b98-9308-95d6-a912-85a49bd3e21d@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/15, Ben Peart wrote:
> 
> 
> On 8/14/2017 5:30 PM, Brandon Williams wrote:
> >Add a '.clang-format' file which outlines the git project's coding
> >style.  This can be used with clang-format to auto-format .c and .h
> >files to conform with git's style.
> >
> >Signed-off-by: Brandon Williams <bmwill@google.com>
> >---
> >  .clang-format | 165 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 165 insertions(+)
> >  create mode 100644 .clang-format
> >
> 
> I applied this and then ran:
>     clang-format -i -style file *.c *.h builtin/*.c
> 
> The modified files generate lots of line ending warnings.
> Apparently clang-format isn't respecting the git settings for line
> endings as it converted CRLF to LF in all the files it edited.
> 
> $ git add .
> warning: LF will be replaced by CRLF in alloc.c.
> The file will have its original line endings in your working directory.
> warning: LF will be replaced by CRLF in base85.c.
> The file will have its original line endings in your working directory.
> warning: LF will be replaced by CRLF in bisect.h.
> [...]
> 

I would think that there  must be some setting to permit CRLF on windows
machines.  As I work on a unix machine I don't see this sort of
behavior.

-- 
Brandon Williams
