Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A99A20989
	for <e@80x24.org>; Mon, 10 Oct 2016 18:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752196AbcJJSKk (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 14:10:40 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34026 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752161AbcJJSKj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 14:10:39 -0400
Received: by mail-lf0-f65.google.com with SMTP id p80so11407736lfp.1
        for <git@vger.kernel.org>; Mon, 10 Oct 2016 11:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=/k3mqlqbEHdtfQzulpkyKaCWIVBQ3/7+Au3FKlUIShA=;
        b=O/y6SKQRmoIx3wAdgyeEm0HBOhPnChVrAnMEVr2mOCtBj1gWWvgzPwWg2+xY4oduww
         0BOywUiVc1AIwFjVk+ady2zF2+0rUaqOfdKEZwdE2YByGv8Y8aMnInTb0189S80aPJ+x
         J/8eGTvQQLbZuXYTWEEb5yeOuzQ4loSGJn21JkQ1V5tgx4mZjYQXhksxt2213pjziQxZ
         lyJ/OMmNHBPkN3/VfUGR/b1HKlYj3nYa+JUZH07w/ZGv7uOufgWXLWztFq0QlPk+JaZp
         8JpUS4aGFe/gndWergrEldd1eYWo7GyuoJSN+MySQb5si1HoGMd1wK8Qf9CfZMgYs5FL
         LiJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=/k3mqlqbEHdtfQzulpkyKaCWIVBQ3/7+Au3FKlUIShA=;
        b=bamROhtS3kPGgTYABga0MQH1WQUjP1ow4Cm/Q8+0L21CxY/73GJyn08iQQfwD8zdy/
         SbswOBcxU3dWPQ9pAeSjDzI5oD8VxU81HTItV3xHDS47rdc5xKL1Zt3gqp/8YUpnZUET
         XUB5ODIqzGGjr/iA/aiRXbGALHVyqbzwMAYn6j17GnsLOK+gA9i7kSp09j1tGF6wJ2MU
         fcp8A7fFuqTm5VBIfBIEy1mlLdkC8718WFEJ74D24cANm22IHIJsnirYxmgv3ViKsjs+
         NorJJYzIOJcwAK+zhVtXL937IkmU3tszEfkuHzG3d+5lMlKhdiYiKH5xF+Ti3xVIL4dY
         vmtA==
X-Gm-Message-State: AA6/9Rn4vtZ+N3T8BqpiINH94NpGgGkolZyTU2XpLZBfPntvPfYCYD5Zj8PXWzSU7gxopg==
X-Received: by 10.25.20.104 with SMTP id k101mr15532617lfi.133.1476123036776;
        Mon, 10 Oct 2016 11:10:36 -0700 (PDT)
Received: from [192.168.1.26] (afp90.neoplus.adsl.tpnet.pl. [83.25.145.90])
        by smtp.googlemail.com with ESMTPSA id 197sm6858723ljj.3.2016.10.10.11.10.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Oct 2016 11:10:35 -0700 (PDT)
Subject: Re: How to watch a mailing list & repo for patches which affect a
 certain area of code?
To:     Ian Kelling <ian@iankelling.org>, git@vger.kernel.org
References: <1476039798.3060702.750483225.1DE6C48B@webmail.messagingengine.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <14d81587-b6b1-5880-d6af-0564780aeae4@gmail.com>
Date:   Mon, 10 Oct 2016 20:10:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1476039798.3060702.750483225.1DE6C48B@webmail.messagingengine.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 09.10.2016 o 21:03, Ian Kelling pisze:

> I've got patches in various projects, and I don't have time to keep up
> with the mailing list, but I'd like to help out with maintenance of that
> code, or the functions/files it touches. People don't cc me. I figure I
> could filter the list, test patches submitted, commits made, mentions of
> files/functions, build filters based on the code I have in the repo even
> if it's been moved or changed subsequently. I'm wondering what other
> people have implemented already for automation around this, or general
> thoughts. Web search is not showing me much.

First, the practice on this mailing list is to Cc all, and from what
I have seen people tend to do that (well, at least the regular participants).

Second, you can read this mailing list (and send emails / respond) with
a news reader via the NNTP interface (gmane or public-inbox).  News readers
usually have good search capability.

Hope that helps
-- 
Jakub Narębski

