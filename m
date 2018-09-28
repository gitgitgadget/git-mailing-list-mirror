Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A79201F453
	for <e@80x24.org>; Fri, 28 Sep 2018 23:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbeI2Ff4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 01:35:56 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45113 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbeI2Ff4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 01:35:56 -0400
Received: by mail-pg1-f194.google.com with SMTP id t70-v6so5430947pgd.12
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 16:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mr4nbpPEWSBoPCilJ10Hr0naEvJBK98aDbhDI06afm8=;
        b=XbiG4x5f+JCuaB56V76n9ZH9XxghUHNkPCtzpQnMdCbDiUFYhswPNbW/sXxh65tFWw
         v1gPVOHBw5B/qjPTYxGzYIPFmPfHms+QQ3tqhonT4TvWfp8IfpHG7xSJHgTKdpPR3bLA
         GkydG+ZsJyPFzlZwSjBgkuLg6wtASPtL05fP2eRTv27TP1I8j71EqKwFDHp4gRAKurb6
         upf0sAUP3RqeGLg8d3VAvEGj7pMFEHPP0x1Je9dsEb51t8TjQhoIeHeuAkGAmQOK4G0g
         hCetuvg+k6CEYOqe/AK1+mEi4/zJAUIM9a7PX5uNGfY6qtWv4fct9gD0vab2hxFCou0U
         MPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mr4nbpPEWSBoPCilJ10Hr0naEvJBK98aDbhDI06afm8=;
        b=GoqA008ACav9RjPVTD+nyWbmOweEXoRuC2qo9beH05jcYcUIhgpHrl0dfz0NbdOn5t
         SHdbI7uccbyVRJ8dmYXSavrodJZUrVY58z1G3hMfKQ6us094Qa4sNOcne4yuafvWW1nO
         qj9e4nBQm3DrJQFZwKOPxXlpImKgXkivPz+IRDbbRgjBEGl+CiUQi/5gOjZk65MYTN4M
         kWvGd754YAP1l+xwb8APLbTCKwu4pEDZO8marQWEY+5utgy6EOxCZ227Lj6EkYNhvhli
         ZnjBeI05cnSkn9SvvBvH32FP8lNacB0wZhWkwfYl7cfpc/7XpSsVtOAecBjT5kEW4pMw
         YDbQ==
X-Gm-Message-State: ABuFfoi5eD9V00bpfUwotQLyEFoC+TKifaiKV4EdZII440W004fMte3N
        9jRo4FT94dW9JT4NpyzXrKw=
X-Google-Smtp-Source: ACcGV619//fbV/dXYhfsM2ckyrAhJBTCblrMRKzzTbw0pd4OERNypyGZZ6puZEAU9heAbUTTiFFyDg==
X-Received: by 2002:a63:214f:: with SMTP id s15-v6mr681140pgm.202.1538176197101;
        Fri, 28 Sep 2018 16:09:57 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id p17-v6sm2223314pfk.186.2018.09.28.16.09.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 16:09:56 -0700 (PDT)
Date:   Fri, 28 Sep 2018 16:09:53 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] git doc: direct bug reporters to mailing list archive
 (Re: [PATCH v2] git.txt: mention mailing list archive)
Message-ID: <20180928230953.GA48520@aiede.svl.corp.google.com>
References: <20180926134717.GC25697@syl>
 <20180927055018.6683-1-martin.agren@gmail.com>
 <20180927063735.GC220288@aiede.svl.corp.google.com>
 <CAN0heSpG2jewXuzcZQAeFydW4zanzymSGVqVz2u0myW3Z7Wcrw@mail.gmail.com>
 <xmqq1s9def2p.fsf@gitster-ct.c.googlers.com>
 <20180928212049.GD193055@aiede.svl.corp.google.com>
 <xmqqd0sx9s19.fsf@gitster-ct.c.googlers.com>
 <20180928222900.GE193055@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928222900.GE193055@aiede.svl.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder wrote:
> Junio C Hamano wrote:

>> OK.  This unfortunately came a bit too late for today's integration
>> cycle, so I'll leave this in my inbox and replace what is queued
>> with it later.
>>
>> Unless there is another one to supersede this proposal comes before
>> that happens, that is.
>>
>> Thanks.
>
> Sounds good.  Thanks for the heads up, and thanks for the heads up.

Ahem, what I meant is "and thanks for the help with writing the
patch".

Sincerely,
Jonathan
