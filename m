Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F39B2207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 21:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750998AbcILVXg (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 17:23:36 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35701 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751227AbcILVXe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 17:23:34 -0400
Received: by mail-wm0-f43.google.com with SMTP id i130so1309032wmf.0
        for <git@vger.kernel.org>; Mon, 12 Sep 2016 14:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=bCi4a1uyqvm18wbe82C5Y1x+oI0Chrzph+Zf6Ln+enM=;
        b=F7+Q5TJS/B1pStiEDfMQm6Gv0MWmyD4+3Izik1cbxpNPr7+PSKhZyNas5mJr4rVPCp
         uuGaXeN0vS6dAvAitrfZtANBVplTPqZ5aiT3lA8+NU7djHp8PVvUX5/vErWpZVHwR22H
         zFtCuIji1ku6+zWnEuzgD6XgdVt+1dr60PchDk0VC/fgIOHRWbCZa1uSUnylJJvjRHVR
         IDK0cJiBK6KaUirHhDodZu0mUPaE9VXWVbFxlucCaZcf5wqOAUkpwwqFaSR0K9bh4AeB
         3KwOlmBiUV8NceOml9f/eUj58OV7R7k5inYJYytU7C28w5O+UNWjpCQ/qWVVde7OzB5O
         eTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=bCi4a1uyqvm18wbe82C5Y1x+oI0Chrzph+Zf6Ln+enM=;
        b=T6SPMXRlSSbY24Ek/0PvEFqmouSwZhIBGozc5bxM7E/cudEdSi5uQ0JG+xNMYQQER9
         q+n/wchd4ZdeaJjdR/ASE5Ur9A2k4HvCDM7VKcFJY62Sr9nMgO2m/4h39OzZ52/heg4K
         YiEeAG6/Y79lApaI4tkFAIxohv484b3sAnAKCjD7cOQujPn3obOWptWZPd3S0FSUPwwt
         xbxtIrpdwhKDg6Y8p6pXf+w1wrjf1/e+9zRLuPvXrr1M8Uc3+XAXmkztIiqViF3xvqsT
         h8KSRopBXSMhPF+NRcqFAkTtCdxOKXE+NeoZwn60lVgcpcYoTAixPgcGG/GocEbx2P4q
         eNOQ==
X-Gm-Message-State: AE9vXwNhFho8esOyNOzKBPYVbqCAYMkZulDdqT4UCiYbqW2QAlEqZTI2/pKWXg1BxhC+HA==
X-Received: by 10.194.88.74 with SMTP id be10mr16599927wjb.120.1473715413164;
        Mon, 12 Sep 2016 14:23:33 -0700 (PDT)
Received: from [192.168.1.26] (elj71.neoplus.adsl.tpnet.pl. [83.21.203.71])
        by smtp.googlemail.com with ESMTPSA id a1sm6037421wju.41.2016.09.12.14.23.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Sep 2016 14:23:32 -0700 (PDT)
Subject: Re: Git Miniconference at Plumbers
To:     Jon Loeliger <jdl@jdl.com>,
        David Bainbridge <david.bainbridge@ericsson.com>
References: <E1bhKNo-0005m2-5z@mylo.jdl.com>
 <20160912004233.qh6uf35v5ylrboz6@sigill.intra.peff.net>
 <E1bjRLd-0005k0-Vb@mylo.jdl.com>
 <DB5PR07MB1448B5EDFE2E2D84C42A8AFCE2FF0@DB5PR07MB1448.eurprd07.prod.outlook.com>
 <E1bjVfp-0006sG-89@mylo.jdl.com>
Cc:     Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <bf2edfe8-667c-8a98-64f1-510983abf9f9@gmail.com>
Date:   Mon, 12 Sep 2016 23:23:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <E1bjVfp-0006sG-89@mylo.jdl.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 12.09.2016 o 20:09, Jon Loeliger napisał:
> So, like, David Bainbridge said:

>> Does anyone know whether the sessions will be recorded in any way?
> 
> I am uncertain about outright recording (digital video/audio),
> but there will be at least summarizing notes taken and posted.
> Anyone wishing to record the talks/discussions is likely welcome
> to do so.

I think LWN.net usually covers Linux Plumbers Conference, see e.g.
https://lwn.net/Archives/ConferenceByYear/#2015-Linux_Plumbers_Conference

Hopefully they would cover it this year too.

HTH
-- 
Jakub Narębski

