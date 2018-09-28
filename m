Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F08F11F453
	for <e@80x24.org>; Fri, 28 Sep 2018 22:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbeI2Eyy (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 00:54:54 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38515 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbeI2Eyy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 00:54:54 -0400
Received: by mail-pg1-f196.google.com with SMTP id r77-v6so5413199pgr.5
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 15:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GCEp6pEca8OOxoyrpsG/c+h/FfQI6+YdFpi+dgHw30E=;
        b=CWijx7eq1ylinmrwcdwx9zrpoqLSxG57sUJ7sGHwcRv4VunwJuw6h5RQUse5I2GKAi
         2WiK/Urwbe1ab6bRYrQsuQoi5vj7++kKPNDh/bOkFEv8aXJudtU3o+N4VIdIPIk895dj
         VvJxlAkJtwURXvHitPLw4BrlVwXs5XeYXb3fgIdWUhtdk0B5k5EbTl1ePGS7NZtlMlAe
         cJ7P8jrahDIGWfwT1qB6MFAsfDzZvfa8SsdhpxdvFiZh65KLEx/g1Al0LvvBk3mzFgpL
         9nmxhB/qYpldMPIW9BfpBqQx7Hkrz9C1sjMsENgU/dTBZRiCuW0PQAoAnvvS+zqPiXzb
         souA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GCEp6pEca8OOxoyrpsG/c+h/FfQI6+YdFpi+dgHw30E=;
        b=GbBId/XzlZAMpuOpDdaAodjPzRrkMVPDbDIhNSq0rxBjBVpLPFJPkng31/7ra22tMo
         9DKoIOxJezlBiP29hK//GGT2t3Qb1RNEFRFbwhhvwvbCpjAxXQh2oaHwb/YtRlw2bAUE
         ukEyKzUG4LXmQb67scyO96TzSwKW0YfSlEVMkofTX1fFyApaOWYWlaCEx5y2H6GQuY2M
         0pix/QephayXHXYmj9J1GoDhn870P3Pcxk87h9iCru5tzhHsC2O6ta57EGasIpxySF8R
         tYXTHLJrxwABBSVN9inaW6orsFvcdvIBoPhbBkQjOX5NovgadDHJiw/Zhnr5QVZyJozS
         XPnQ==
X-Gm-Message-State: ABuFfoitWNrlafUS0womL2ZwI0FfkbsAYrtgUQ4Hpi7WgDK/fjSVsifY
        KQRhv7qTTRouVn14Vneeue5mb2dH
X-Google-Smtp-Source: ACcGV62EotjaBVDf9gOT/wZ7MfsSAPpRDqRKAt/vcpGxQTriqu7lMvp0h5Ag/cvV9/fzw+wmnGBd7Q==
X-Received: by 2002:a63:e855:: with SMTP id a21-v6mr579090pgk.4.1538173743645;
        Fri, 28 Sep 2018 15:29:03 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id k26-v6sm13542532pfb.167.2018.09.28.15.29.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 15:29:02 -0700 (PDT)
Date:   Fri, 28 Sep 2018 15:29:00 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] git doc: direct bug reporters to mailing list archive
 (Re: [PATCH v2] git.txt: mention mailing list archive)
Message-ID: <20180928222900.GE193055@aiede.svl.corp.google.com>
References: <20180926134717.GC25697@syl>
 <20180927055018.6683-1-martin.agren@gmail.com>
 <20180927063735.GC220288@aiede.svl.corp.google.com>
 <CAN0heSpG2jewXuzcZQAeFydW4zanzymSGVqVz2u0myW3Z7Wcrw@mail.gmail.com>
 <xmqq1s9def2p.fsf@gitster-ct.c.googlers.com>
 <20180928212049.GD193055@aiede.svl.corp.google.com>
 <xmqqd0sx9s19.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqd0sx9s19.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

> OK.  This unfortunately came a bit too late for today's integration
> cycle, so I'll leave this in my inbox and replace what is queued
> with it later.
>
> Unless there is another one to supersede this proposal comes before
> that happens, that is.
>
> Thanks.

Sounds good.  Thanks for the heads up, and thanks for the heads up.

Jonathan
