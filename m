Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D6601F463
	for <e@80x24.org>; Mon, 16 Sep 2019 19:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388371AbfIPTvB (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 15:51:01 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174]:32874 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732089AbfIPTvB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 15:51:01 -0400
Received: by mail-pl1-f174.google.com with SMTP id t11so381167plo.0
        for <git@vger.kernel.org>; Mon, 16 Sep 2019 12:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=knt2Py5n2P3MyDnl3HlrThGv4yvhgGDLZZXpvBpnyNQ=;
        b=c+hzTjKteltrKy7KyHN4qAon8ChZ4vRovpnWM1hGYs2xEzEymANd1KvtbN2dn+pH9H
         vIAYlH+ROpIDb3pMQRaYEUyMqH8yCFvMfo4XYXnX/GiWVeiAvp96mlHQaMh/oe0LdaAa
         834lsYUlrwN3oQVnCMg4PVvhIQH1/WBTbksDuSzjGZl/GO//9CIeW3IhSXm0eS2b7WsQ
         VugfA1ydb/8PCp9lihiuETG3ERFu+TN1JHh25XeXXMaXdlCSW9NW++kCNa6RHBAyXs3R
         CrKmNY0wag6mFW8BHz9usWExBL7KxIl39x+4l7tvLVtl9r6ga1qH8bEWymDHBb02di92
         +9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=knt2Py5n2P3MyDnl3HlrThGv4yvhgGDLZZXpvBpnyNQ=;
        b=LyOH1dKMsxjOMEfgl6L8i/DVuYnuJFVzl4KBv7iTCX9RvdEouh2iaSXy7xYei+vcXn
         6Ispe0P9485bViDbHD/M7Vr4LZP1AXtEfa7rhAW8wOPi4qxZK9MnO7qkzzweu/qwzTT6
         6Ry+u2MsbPa2dMrf/kUrIf7xTzNS/I2yrXXr07Zt//jQvUCyT7XPf6uAzVZo7Sd9iSDI
         1kz9TqAOhc4hs88VEQqtohmbmgYG32IEsR4dndPWciEMgubRPEOz8pmnqmOUoKery/lg
         XYhI6ZbOSVeGFs6j29h70yocOLipF2neeV7nwZi8LZXhZS+1B82gYBUl+cRoOBjk8NWz
         Ks6g==
X-Gm-Message-State: APjAAAWE26u3V9UMQ0aWzGJlR2V0oZ2NbCkvUqKmz9w5K57NqK8Hj2Rp
        QO5Yif7voC5P8Xfqbre461Ad3no1
X-Google-Smtp-Source: APXvYqxkymHXeFqU2hKxs5i0+OjquHbfg/8Pye85uPjVluI77MQ8+mr0NZUwlTQNPm2ZItoXc05p9w==
X-Received: by 2002:a17:902:ff08:: with SMTP id f8mr1518634plj.309.1568663460291;
        Mon, 16 Sep 2019 12:51:00 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id u11sm29767130pfm.113.2019.09.16.12.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 12:50:59 -0700 (PDT)
Date:   Mon, 16 Sep 2019 12:50:58 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: Git standup on IRC
Message-ID: <20190916195058.GA67467@google.com>
References: <20180713170018.GA139708@aiede.svl.corp.google.com>
 <nycvar.QRO.7.76.6.1909132353310.47@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1909132353310.47@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(+cc: Thomas Gummerer)
Hi Johannes,

Johannes Schindelin wrote:
> On Fri, 13 Jul 2018, Jonathan Nieder wrote:

>> Some of us have been informally doing a "git standup" on #git-devel on
>> irc.freenode.net on IRC every two weeks at 17:00-17:30 UTC.  It's a
>> way for people to say what they're working on and ask questions.
[...]
> As discussed during the Virtual Git Contributors' Summit, I would like
> to propose a new day (Fridays at 17:00UTC, I want to be well into my
> weekends...): Monday.
>
> So how about meeting on IRC every other Monday at 17:00 UTC, starting
> this coming Monday? I'll try to be there.

Sounds good to me.  Let's do that.

> (In case it was not clear: those standups are meant to offer a really
> informal venue to talk about patches you are working (or planning to
> work) on, _especially_ for people who feel intimidated by this here
> mailing list...)

Thanks to Thomas for setting up the calendar
https://calendar.google.com/calendar/embed?src=nk8ph2kh4p5tgfcctb8i7dm6d4%40group.calendar.google.com

Sincerely,
Jonathan
