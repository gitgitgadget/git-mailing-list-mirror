Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F0E720193
	for <e@80x24.org>; Thu, 27 Oct 2016 23:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S942624AbcJ0XHn (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 19:07:43 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37378 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933978AbcJ0XHm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 19:07:42 -0400
Received: by mail-wm0-f54.google.com with SMTP id 140so47457672wmv.0
        for <git@vger.kernel.org>; Thu, 27 Oct 2016 16:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pelly-co.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=AUlbPYTLpx3U28iLKkQN6Pyq1eTQ++z+9QSDd16AVGM=;
        b=CPNTS+wYX/TWbw8n/niLr6rCnmJO/UzVdcaJsIJJi/oa9fW9Gj/acEXbUN9LN9J++P
         7iOx8zCclRu2/JTEsriaAiMzHDd2+f41Mr8dghZZ+Ua/cFmMY2mrB+l6d4hGQp4oShjP
         cjlSIoUzdxeHH9O2X+TwMpL5V026PFdz6/yw+OrLnSNNVJRjT2Uv4ZRPDCbytPvSplXk
         BgN4pqExqPbMncJhT5fioi+GVyeUsxLtf6uJo6n2YF8/a4pSBsbOwhgpjXdthpk5D9Jc
         pN8Jp4D9wejri9e+mNADNYuUAzz7HSUN6bnr4uHWQEm0V5uxEOpU7Yri8zmroKie3G16
         4HIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=AUlbPYTLpx3U28iLKkQN6Pyq1eTQ++z+9QSDd16AVGM=;
        b=a73TEKjS53chJFbRudg4pudkss8gIfWVqiV+LJBJ6TKs1G6i3UnLj8QCx8CSh/33fy
         9r8EllQxWb8QK+gD0FoGy82l/c3gtgCxTyqhlMXkeWfmHhgxzu60KcRxSRqM8QLnwYII
         Q7C79VVo0ZqoFWYhMfW7WooisD0RCdpnoph77aZyIQySLh6KWs4zlcXFl+yPKcgVI0/P
         mzNqNQTFfy5N+3x7R/DdXCo5dUqvEQo53q8alUlEu7MrtIW8gm0lwDqJahC5tJT3P7hh
         R+YHyKIut2zi2PVyZX/jJKY6v63W6qY0h2z3d16fjec8qhe8BJMSWAz1TlmjZA6EkvS3
         Nghw==
X-Gm-Message-State: ABUngvdmGGgS7ZpOU9ioLXXqAsb/rXpoufT/HcGD1wiu+551E9Nz/MGNEs+ihwRa1tleww==
X-Received: by 10.28.196.129 with SMTP id u123mr152043wmf.66.1477609660688;
        Thu, 27 Oct 2016 16:07:40 -0700 (PDT)
Received: from [10.3.1.6] ([49.50.252.82])
        by smtp.googlemail.com with ESMTPSA id a5sm10968058wjv.6.2016.10.27.16.07.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Oct 2016 16:07:40 -0700 (PDT)
Subject: Re: Expanding Includes in .gitignore
To:     Jeff King <peff@peff.net>
References: <80919456-7563-2c16-ba23-ce4fcc2777de@pelly.co>
 <20161027105026.e752znq5jv5a6xea@sigill.intra.peff.net>
 <b20b458c-440d-df09-d2c7-e510ac20492c@pelly.co>
 <20161027205508.vqw44zlbnqpj2cvd@sigill.intra.peff.net>
 <20161027210753.btc7zbndhdocsbwa@sigill.intra.peff.net>
Cc:     git@vger.kernel.org
From:   Aaron Pelly <aaron@pelly.co>
Message-ID: <c2b917af-afc6-20de-14a5-3070f92bb243@pelly.co>
Date:   Fri, 28 Oct 2016 12:07:36 +1300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20161027210753.btc7zbndhdocsbwa@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/10/16 10:07, Jeff King wrote:
> I think it does
> introduce compatibility complications.

If this is not a show stopper, I am happy to knock out a short
functional spec. I'll give it some hours before I begin.

