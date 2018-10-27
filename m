Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F3BE1F453
	for <e@80x24.org>; Sat, 27 Oct 2018 03:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbeJ0MYt (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 08:24:49 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:40649 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbeJ0MYt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 08:24:49 -0400
Received: by mail-pg1-f173.google.com with SMTP id o14-v6so1382880pgv.7
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 20:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a1iFGBL+NI4FuwH/GYKdHHMjy8LzXiAWH2CTjGNqzt8=;
        b=PWyAd99pRbl5E98h++3MY201LGCCf3Jkv61psBBXFw6n/Hsxe6tj1uGs9tlGbUBC4D
         QyvjXMZDSPDT+eK+ON0mZehNyMSq/Be+cFnekyrR8O9Gadqs+bwrxVceJkqUYoc5w+8c
         dn3OafsdoCIVXiDg6ickJNa+VcD3JdVO6C7oUWRHPCJASycWUrLTHGabF3NNy8alFwWu
         GlKeZzjcqirb6aXRwJgErWvCBBcBxgRp+c7iaWQ0MvyIyOX97fLeH5uhVTQOqN9WLyPY
         1Sv/AAUGbz76F3L3ILrh/vT9H4zViIZf2+O/lEp2aKH/BkVfc74lX3GM6h/Vleo+is4d
         zSbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a1iFGBL+NI4FuwH/GYKdHHMjy8LzXiAWH2CTjGNqzt8=;
        b=t1/SfRX/uWdylQNjN4AG7xM3eF3A/Cq3W5BWdixhRmmc2YPyUVQYzWB/aDbiWeJKbG
         Sxl9NeP8qNbMR4AFw87yxi9AB/KPiwFoJjZ5vloxiM2wSHnFBUUljvZ3lzDinI2gyjDI
         54tf0hWqpnYdVku16wHgEt1OpAJMTjiUu+4mcR5CMUAybSlfqzzzj5OQmUo2FEunVJ3K
         O4j5G4QxyTMOiZOvUoMoAdKh7N9hrptRwRJPQS/7ltD8tRxD4yN3Go55OBn9SegpDOvt
         HCBVdSnxc86mJJvOV3mO562uZOtjBK9lpxMFyseVCdRzNnn/bEk6vSlsCNFj2Y4yApTK
         MtgQ==
X-Gm-Message-State: AGRZ1gIMH6ASXllYIakK6xorVxckyW5HhWm8sAjL90ExYa0fedg0i9PC
        i7viV85YK7JhdGCWTgDkAdUjgQ==
X-Google-Smtp-Source: AJdET5fIlDi/eXo4a6C37te2e7ueMgLejUyHQP/+1+fty8rrA7fNb1l+mAcyQoDbyYO6TXgE0uURkA==
X-Received: by 2002:a63:1c64:: with SMTP id c36-v6mr5699796pgm.354.1540611914753;
        Fri, 26 Oct 2018 20:45:14 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:217b:cd3f:4c97:19e8])
        by smtp.gmail.com with ESMTPSA id w2-v6sm9088419pfw.26.2018.10.26.20.45.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 20:45:13 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Fri, 26 Oct 2018 20:45:12 -0700
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2018, #05; Fri, 26)
Message-ID: <20181027034512.GA2875@syl.hsd1.wa.comcast.net>
References: <xmqqo9bhcf89.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo9bhcf89.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 26, 2018 at 04:57:26PM +0900, Junio C Hamano wrote:
> * tb/filter-alternate-refs (2018-10-25) 2 commits
>   (merged to 'next' on 2018-10-26 at 887a7779a3)
>  + t5410: use longer path for sample script
>  + Documentation/config.txt: fix typo in core.alternateRefsCommand
>
>  Test fix.
>
>  Will merge to 'master'.

There is an additional clean-up patch in [1] that I'm not sure if you
have seen or not. Could you please queue that as a fixup to the above?

Thanks,
Taylor

[1]: 6aabe7201dc81b98e404010b441fef8d582b0232.1540258140.git.me@ttaylorr.com
