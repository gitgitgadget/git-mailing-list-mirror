Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 335F01F404
	for <e@80x24.org>; Mon,  5 Mar 2018 18:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752700AbeCESNh (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 13:13:37 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44662 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751935AbeCESNg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 13:13:36 -0500
Received: by mail-pf0-f194.google.com with SMTP id 17so7541839pfw.11
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 10:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wiEwSNHumtnsJRXfNj9xdLv4y29c08lYhIKUBzBYSRg=;
        b=i2ByrsLIBhDstrl3Fwzkv0dZSAXY6XNMay1vCKVA+pkL+pfZ0AyAn9l8kwXgirl3Om
         M/WkdPjDXQA1CWTaKyZ7dIHTpCKfx1Sr7gR/e31jXWgltvx/0l+9qomWQx+T+f3XXGxJ
         6C72o8uWw7mqSWHUxY3tbRTE1WDgAWi5T4qE58lT64i4eH8hG6KbUDAS729AUZeSzi1w
         oRaVm2IBdwbYa7cuBMcA310PE8p0j7fr3AqQkFXtdH1hv+V7u4cUN3mfi05NsY5l/xAi
         ziXXxdsG+tS3Dk7sG1GErE1twP3vKHoonKlJPO7yIecf7t3kk5KQ6w3jmouDkwmmnokS
         lG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wiEwSNHumtnsJRXfNj9xdLv4y29c08lYhIKUBzBYSRg=;
        b=l7KFA8irDuQg6J7YOfgUq7KGRU4IL6ubNHKiI6qDOnXkZ46G4m24GaAzKAWBEP3Qja
         VatLk4+MRy+bQaHYNQ04ybsjYc3P2JBVaLalZoShwgJ79g78FRh12rnj1brsa9VkXPjD
         C5iLC8+9Yc4HVdRLH0+eN04mtDJGrGroZUXCwSbD3yknrL887jCkbB+ag8syMRZVdtJA
         MZRl5r13Yvc0Bj0xSBRhqrKK0XJZ6PYD538ftH8dhJ+Gghdt1gNyxnfSpZ8Ojpgmx209
         VI93enc3dwQeBNG+iw6n0xD3BPYfqr863KmcTKYVZjs6VyYH7bH3Fk+FQKQ6IbNjaiD3
         rYZQ==
X-Gm-Message-State: APf1xPCx+eIkv3ouXhmQdM1PAWbZO4cnSq6bAi4MmoJIQKNB/ViDHJXs
        DwR5AovyAJ77XNuZi0LnKTs=
X-Google-Smtp-Source: AG47ELs9nZing0tKIVWoW0lAAAWmQEyQFsoGRUUvd4FIEJfwSt6ZWyRz79B2Q1D54mskaan4jSF1nw==
X-Received: by 10.99.6.85 with SMTP id 82mr12680692pgg.181.1520273615437;
        Mon, 05 Mar 2018 10:13:35 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id i11sm19727477pgq.34.2018.03.05.10.13.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Mar 2018 10:13:34 -0800 (PST)
Date:   Mon, 5 Mar 2018 10:13:33 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [RFC] Contributing to Git (on Windows)
Message-ID: <20180305181333.GB28067@aiede.svl.corp.google.com>
References: <176408fc-3645-66d3-2aa3-30ca3fa723e7@gmail.com>
 <20180302044409.GC238112@aiede.svl.corp.google.com>
 <xmqq606ee89v.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1803031721590.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <20180303182723.GA76934@aiede.svl.corp.google.com>
 <663f3fef-30bc-8900-6070-80ac96cccff0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <663f3fef-30bc-8900-6070-80ac96cccff0@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee wrote:
>>>>> Dereck Stolee wrote:
>
> nit: s/Dereck/Derrick/ Is my outgoing email name misspelled, or do you have
> a misspelled contact info for me?

A manual typo.  Sorry about that.

[... a bunch snipped ...]
> I have a habit of being too loose in language around lawyer-speak. I should
> not have attempted to summarize what "Signed-off-by:" means and will use
> that helpful link for the description instead.

No worries.  I make that kind of mistake all the time but just thought
it worth pointing out.

BTW, thanks again for writing and submitting this document.  It can't
land soon enough. :)

Jonathan
