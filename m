Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2E741F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 01:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730110AbfJIBjY (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 21:39:24 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:38258 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729882AbfJIBjX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 21:39:23 -0400
Received: by mail-wr1-f46.google.com with SMTP id w12so523995wro.5
        for <git@vger.kernel.org>; Tue, 08 Oct 2019 18:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hsq7flw01CWZqNviNR2rY7U1ZDyTuRHqDE9O9B3BOf8=;
        b=TrrLkocEKVRweBUoxP1pT0RcjG2c7UB04Ge8zzMZHtzb0y2k2q+lJTD3MJqwnan03r
         AcUL9N5vmE46JRL2s/lluwCSjZkxUn3jjulmRPOT9+Fso35ALyqIQHEDScJOMF/gt/0r
         HjVf4J0xanefYQZepayb8eQkoR4e9tbEwpaI1aBs9SWSrJGnDb44Wc3Cyi4RaWvkm3PJ
         TczRFjhVK8h97L4yzeCAIW2d7LNSEgCBRLIYeIKtVQ7xlLU0Xl0V7nhDguQuao13gACR
         xGx0VJh2hZF+DeV9iSJF4y4co83iNUh873hXrTN9uCvMhwwabxMp/0ejoQ5muURB4a+h
         28Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hsq7flw01CWZqNviNR2rY7U1ZDyTuRHqDE9O9B3BOf8=;
        b=lQPDq9QIwofBUCNwplEJTo7k5qWk+h6WZSuXnK9JMuaLd83/eHMR1jXLzK6phSUSeW
         tRnfPDk31sKnNBMHGRlgT+x4NdYzxYdoCjpqqeetIkyBPQbvjk1kywbc4I+SML2fflmG
         N08ZjS8MZck5gYTFtZxyconEzLAAFpJM/dQMRYAxvLhspnhuP8riW6IZ9IMdZ9teZy5V
         2tgiroWBfOt8GHI6RBU8oH56CXZoar7Wn48kRR5yjXbkjUKdAxHVoZ0L5jDZTE0TO8+4
         uMtMOZryghsiIy6ub/BZcwYgOBFydHwS/lhj39bFjLzO48cRDMtaDdEA4cDuq19LKA5P
         J04Q==
X-Gm-Message-State: APjAAAXwt+JhTW/0zeFKlb3vCeezQ37dbH7GXfwhzZ3vR5torgv6G1Gh
        GkRWsZ/VAHkP8wDRB0Wep0E=
X-Google-Smtp-Source: APXvYqzSUcLZmytKMaHWqfbGcgfj3+oXMl0MtoEXRhX8kXYSzUGV7HPiXeZM4JRQFP0FXEZHSTxWpA==
X-Received: by 2002:adf:c98b:: with SMTP id f11mr681875wrh.274.1570585161777;
        Tue, 08 Oct 2019 18:39:21 -0700 (PDT)
Received: from szeder.dev (x4dbe0d12.dyn.telefonica.de. [77.190.13.18])
        by smtp.gmail.com with ESMTPSA id n7sm484238wrt.59.2019.10.08.18.39.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2019 18:39:19 -0700 (PDT)
Date:   Wed, 9 Oct 2019 03:39:18 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: jk/code-of-conduct, was Re: What's cooking in git.git (Oct 2019,
 #02; Mon, 7)
Message-ID: <20191009013918.GG29845@szeder.dev>
References: <xmqq36g5444k.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1910082111220.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.1910082111220.46@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 08, 2019 at 09:36:26PM +0200, Johannes Schindelin wrote:
> I missed a well-ACKed contribution in here: the code of conduct Peff
> kindly submitted, with the add-on that clarifies who is in that group of
> potential mediators. See
> 
> https://public-inbox.org/git/20190924064454.GA30419@sigill.intra.peff.net/
> 
> and
> 
> https://public-inbox.org/git/20190926072046.GB20653@sigill.intra.peff.net/
> 
> As far as I can tell, there was only one critical voice, Gábor, and when
> I responded asking for clarifications which part of the code of conduct
> exactly would require any change of behavior, there was no response,
> which I took as a silent sign of acquiescence.

It's merely a sign that I had other things to do, nothing more.

