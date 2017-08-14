Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 190B420899
	for <e@80x24.org>; Mon, 14 Aug 2017 21:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752357AbdHNVcz (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 17:32:55 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:35683 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752275AbdHNVcy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 17:32:54 -0400
Received: by mail-pg0-f42.google.com with SMTP id v189so54855639pgd.2
        for <git@vger.kernel.org>; Mon, 14 Aug 2017 14:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J6VVGZD8zTZay8kC2i9s+8ImfvWdb58TV9P8bVXwcQA=;
        b=qm1Iwx7k7ds6H3skFZnRAW73USreA/WVC2OQ0yAMFofQyl3WhEVY+vIRHzgBFJDqMK
         5x2VcK6TX7Yw6LJ0kSZmlv8DOW7ztY04OPpsMTGwndpqC7hoMHG1MS59BnIoTdRzhXvc
         kzyd0o8N7W6n4HohX+j9g2au/cCS6TceU8x+REXq/o0Dv3nV5sRRPonK95FQsBL3JFUc
         99ojobDW2IxoDBAkdD6nG2st7LMBvRCiKuZLAB/KkqZb7F6H9o/xDwK2OQgy/V8JcQ35
         qZW9G7Y818i9NvYuRQO6q1zHIebv28slaF4UM2Zi6fEqNnKS/ACg6T488q3jOlrIAMNG
         q8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J6VVGZD8zTZay8kC2i9s+8ImfvWdb58TV9P8bVXwcQA=;
        b=Txt+n1amBqdvDH4DrJPa0vlt8YRN7p+JR6TFunluRcoRGt9B780kxhqn4vDD87foOe
         CHd4ext54+KjGVUcgW4T+uZyEtmoBUqwPZiGGA5Kxv++Ul8dD9AWaPFfRWuVMHkQXDP+
         gYShmlkQdHwu8Wqa7vBLgLx7awQsHL8pddQ07Clo5xbIFwXOvZaRwAxSM1GYyXyZp+18
         dd0YDnE74sg5E6r9DVRYdR9f3GOCAhi4dgoL24QjJBk35JMlpDFacLi9T3ydqaTUMJM0
         zIW5AAgV9BOPKqDDmy2PMRJhY6181CWSacGnbA5fs7LBZhz81K5kNxkAZX04Zay4SAjw
         ZFYA==
X-Gm-Message-State: AHYfb5iK7rW8IKNhqQAiFWWQ2NR9Ns1qGUUi9ZcsRFHnYnt6eT9rarKe
        GU2Gl8GDDVt9seFDU7bwgA==
X-Received: by 10.84.167.2 with SMTP id c2mr28860546plb.330.1502746373513;
        Mon, 14 Aug 2017 14:32:53 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:8d3a:cd80:9f5c:505b])
        by smtp.gmail.com with ESMTPSA id y70sm15709477pfg.93.2017.08.14.14.32.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 14 Aug 2017 14:32:52 -0700 (PDT)
Date:   Mon, 14 Aug 2017 14:32:51 -0700
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, Johannes.Schindelin@gmx.de,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com, peff@peff.net,
        peartben@gmail.com, avarab@gmail.com
Subject: Re: [PATCH v2 0/2] clang-format
Message-ID: <20170814213251.GA95777@google.com>
References: <20170808012554.186051-1-bmwill@google.com>
 <20170814213046.107576-1-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170814213046.107576-1-bmwill@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/14, Brandon Williams wrote:
> Changes in v2:
>  * Changed a couple rules to be more inline with our coding style.
>  * Added a Makefile build rule to run git-clang-format on the diff of the
>    working tree to suggest style changes.
> 
> I found that the llvm project also has the git-clang-format tool which will
> allow for doing formating changes based on diffs so that the parts of the code
> you didn't touch won't be formated.  It also has a nice '-p' option to only
> apply hunks of suggested changes.  I also saw what Ramsay did and attempted to
> add a Makefile rule to run clang-format.  This bit may need more tweaking to
> get it right.

Forgot to include the [RFC] bit because from the discussion it seems
like we still have a lot to talk about before we decide that this is the
path we are taking.

> 
> Brandon Williams (2):
>   clang-format: outline the git project's coding style
>   Makefile: add style build rule
> 
>  .clang-format | 165 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  Makefile      |   4 ++
>  2 files changed, 169 insertions(+)
>  create mode 100644 .clang-format
> 
> -- 
> 2.14.1.480.gb18f417b89-goog
> 

-- 
Brandon Williams
