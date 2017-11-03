Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4AD620450
	for <e@80x24.org>; Fri,  3 Nov 2017 23:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755031AbdKCX2f (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Nov 2017 19:28:35 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:45097 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752352AbdKCX2e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Nov 2017 19:28:34 -0400
Received: by mail-io0-f179.google.com with SMTP id i38so9649182iod.2
        for <git@vger.kernel.org>; Fri, 03 Nov 2017 16:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EVeJh8N0G6lOC+DqGzYMlKdSQGzTPzO3n+hnb0WvIms=;
        b=Dpyi7kxnN474FfAlT+Icz4a166w1VLOggwZGy28l5FzUeFFpapSb++/lpvALy2EK7d
         iVKY1LJDV/uyhmLHI2OFkvsIFfB1kB7Zbm43PeiP4HJThMmZdsgONzzK/Td5Cek/WU/X
         OVLqXK9dQgTmsE6csjtRQSxRBXbayy+lcAbGLpL9BJzs05UHpUX2mSFaEgTFG3JKsCYx
         hTHAa0eAgGHtE8E/wqbDCjbM1jz5fhhxef2MJQVc8L3yDu2ALURZea5UybMAp2rP1K7I
         lbWJUR9yJMXWQrbBGEXb8gp7LTcnZm15hMrl4hfTENYQR8elqnNsx/Fn/jqfyJpPKAXI
         /85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EVeJh8N0G6lOC+DqGzYMlKdSQGzTPzO3n+hnb0WvIms=;
        b=ED3Yap+AahSpQgPTDB9zkaH9iNQncvrgrm7I5S/ONMXUoWEY0ZrB0Ftd0ePmrpGzAQ
         wO/0Pbomh0X9wtMpZcGCj26cbVAwjzYZCi4u5CFzYvts56ApULyf656jbT1Q4zerPql3
         xjDbRwPf3d/xWevgUoikUXcrhw4rOLU/R/TW4J4wPn3hLjJKCqK+xGHg9xyXgQJXP2VP
         VOD/OvZaiiu729tqEiaNsPit8EOmrEbMQnk/UYGWrOr4n7Z8D/GswINGawRjU2NnK2xV
         A6NWMYkjnKdnnyyhQ05Aqj2BMJqo3hVyl2uSqggBLL3ITLlIm2mHVRyv2D/Sp6Mi4zHj
         1sgg==
X-Gm-Message-State: AJaThX5h629Lh7lAUGlJ2BfxU0hSEptUUGuUuE3A29zUCpMdW5xooOwI
        eq7gci9CURP4c2eRpKh4uxxDAMnK
X-Google-Smtp-Source: ABhQp+RxeOKubVjzQahB4V0RyoBoAgFBaSd4lvErvFSrn4quLzOJYhWg1yKDhj7Mre0Ofa6740rbMw==
X-Received: by 10.107.42.10 with SMTP id q10mr11495588ioq.196.1509751714076;
        Fri, 03 Nov 2017 16:28:34 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id r65sm1685561ith.1.2017.11.03.16.28.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Nov 2017 16:28:33 -0700 (PDT)
Date:   Fri, 3 Nov 2017 16:28:31 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jean Carlo Machado <contato@jeancarlomachado.com.br>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fix typos in 2.15.0 release notes
Message-ID: <20171103232831.yrfi6qdq4q4zul4e@aiede.mtv.corp.google.com>
References: <20171103231549.9140-1-contato@jeancarlomachado.com.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171103231549.9140-1-contato@jeancarlomachado.com.br>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jean Carlo Machado wrote:

> ---
>  Documentation/RelNotes/2.15.0.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Thanks!  Can we have your sign-off?  (See
Documentation/SubmittingPatches section 5 "Certify your work" for what
this means.)

Sincerely,
Jonathan
