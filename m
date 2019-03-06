Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C78920248
	for <e@80x24.org>; Wed,  6 Mar 2019 23:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfCFXj3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 18:39:29 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45482 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfCFXj3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 18:39:29 -0500
Received: by mail-wr1-f68.google.com with SMTP id w17so15334487wrn.12
        for <git@vger.kernel.org>; Wed, 06 Mar 2019 15:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0OzTq7oBJXtho3+ptytUY+8RrLhWsXZ6QHWrAJZptCw=;
        b=B8MJk66M/vK7/Ec7UdpGzKz/TeQA3DAD9fsMYjXzlkOPLraxDqJNmyuBUTT//2Bje1
         4MrsUsp65VcD/BQQ0aJyt/hglGl7Uo5ivVgGJLGwV7RGqYUkz/FBsObpTi8mIX64lsHz
         4yUjbs0OYp222GBC8H1ANjxz4JkLRme8GJP/yMoPzSh+GE9DFgLQ8Ty5fFD3jm7UYkxn
         r3E+y8LyRDpscY0Rzhb5qrSymjuG1eR1jDy5B3J1rTFdTRdAC5+BjSKMfA6gMCUw4V7f
         WxgR0nJXVCARop6qaRLiJvUrXOpcVwF9yYy6i9sFaj4Uf5YGPO4qJrVGDt21mKTaqEKl
         aiUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0OzTq7oBJXtho3+ptytUY+8RrLhWsXZ6QHWrAJZptCw=;
        b=kID5Dfh8sBz6eYVQ3ACQTkPbmwKw9fOIjHXHjubYXs82jO13PH1bMjvH4YY7dyGy4s
         RpXjNJQcveL/1pMJemN6O//QkAvWDFm3dfVN0iblz5utHAcnWTBsQ6BNwM+el0H48ps+
         hpNonXl2ZVSz12ZxItlWDMXHNmCQ7ichHMAR9t+NLtJYNM2Wcc67s7JwN89RtnmZ0Mz/
         p+BGxCbWUCtYZs9ICJTK/8KGKSANrrz8/yE1yE3vfu7BKLaIapdnFVCFsEgrZt1laYUY
         lZEIJYFM29MipEa91fDilfkpX8YtKaXyUGV2EOLn3DENquum6EGlBQvGX89FHC7eZFuE
         FiHg==
X-Gm-Message-State: APjAAAU6x9pYufL1aHvoTfll7uugJ0xpGDNmRMOoEEqvQCCl+WDKilcp
        bRrydngHkqvLFg2BU7bt+yA=
X-Google-Smtp-Source: APXvYqzi9dzhxjgqkH0yapDGkVXiC2TaciKYj/x+MSie2o8LFzB+p4Gw8NRzYEixTbCO/pba9wTCFQ==
X-Received: by 2002:a05:6000:1107:: with SMTP id z7mr4422232wrw.87.1551915567453;
        Wed, 06 Mar 2019 15:39:27 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g10sm3194231wrq.61.2019.03.06.15.39.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 15:39:26 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        git@vger.kernel.org
Subject: Re: [PATCH] Doc: fix misleading asciidoc formating
References: <20190305214423.27820-1-jn.avila@free.fr>
        <20190305223655.GA27535@sigill.intra.peff.net>
        <xmqq4l8hszj7.fsf@gitster-ct.c.googlers.com>
        <20190305230227.GA22901@sigill.intra.peff.net>
        <20190305231142.GA359@sigill.intra.peff.net>
        <xmqqy35ssx7v.fsf@gitster-ct.c.googlers.com>
        <43445278-ec9f-f3f4-89bf-cf99906fc617@free.fr>
        <20190306190630.GB18239@sigill.intra.peff.net>
Date:   Thu, 07 Mar 2019 08:39:25 +0900
In-Reply-To: <20190306190630.GB18239@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 6 Mar 2019 14:06:31 -0500")
Message-ID: <xmqqtvgfpo7m.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> (Though I am also happy to see it applied since you went to the trouble
> to make it).

Yup.
