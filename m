Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 126801F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 18:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753115AbcHOS0I (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 14:26:08 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37011 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753091AbcHOS0H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 14:26:07 -0400
Received: by mail-wm0-f43.google.com with SMTP id i5so119663234wmg.0
        for <git@vger.kernel.org>; Mon, 15 Aug 2016 11:26:06 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=jiQQ0x/JBlwElZ4ytiCyUQeh4/Z6GoTdlIh7TEsL0yk=;
        b=BbA9dwJdp89LK906xBThuEPdHhyV6li8JcgqjGIa2eDeJnHlvUSpR10feNrUztRXgQ
         hcQXLdFYBTaWjp9yO8ea/nnhozI2MpgeGyag9ZiFUqIYC/+RXf1SxXNcsGvJVyUXD/jP
         C+4AvwbbfQBg49zd9lX7bEpXyY2pvxnNFEFrCoarm4XBlXh18LAvrO7jCVFTA+r7VEBt
         g8kiH/kGSC1q/X0bzrOsfUO0hdjDVwmvkfsHbjgxs7gfoY0WVUvtCJSvlTqZYuSc3Mwp
         Y3NfmZhvhUNzBgU2IYX0m6+sYjvDwXGCIqlUnP8POYLO6ZjFSaphOfGAhApBUnYlC9mj
         17lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=jiQQ0x/JBlwElZ4ytiCyUQeh4/Z6GoTdlIh7TEsL0yk=;
        b=FZ3JtkOxwaWz4DE+QuoWvYYqMTsuV/2BqvwAAM1aTLnLtNGFmdOwdF0VU88EkQcpGy
         SSsUxlK9DgOPiUaEr++bjEeMktzGCqQDceZDezYAxb6zI8JX/zJ3Ex2ngU1KI7Y0qPwV
         emDaoNlaJMV+wNRpAfeeZa1jOg0fgdevnUVcjGW2/tnG81eljCPQPi8Tgu18HlxZEGlf
         d3lYdmq3nGPCJ0wsRuuIaRl7iz6pXdYRm3+r/a3QvAaDDDeMaZrknywEJEy1xKRKW4M/
         U+n3x80nHIHdRMZ4RxOJB15imwNTYXgVyMWuUEtndAXxGanq01YeNM8x738FHwLjo+fX
         +vqg==
X-Gm-Message-State: AEkoouus+t+phlwjgPPCEZBHLzKirAtPsTaMLuypR6ssurt/0zymSecPHQStLxfjMMFPng==
X-Received: by 10.194.161.70 with SMTP id xq6mr1564137wjb.189.1471285565924;
        Mon, 15 Aug 2016 11:26:05 -0700 (PDT)
Received: from [192.168.1.26] (ewj67.neoplus.adsl.tpnet.pl. [83.20.233.67])
        by smtp.googlemail.com with ESMTPSA id us9sm22669422wjb.43.2016.08.15.11.26.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Aug 2016 11:26:05 -0700 (PDT)
Subject: Re: Draft of Git Rev News edition 18
To:	Philip Oakley <philipoakley@iee.org>,
	Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>
References: <CAP8UFD1iveotLsMOBnpa=hU4ohcQjZ-X7tjnzY4k+xz5KJvqBw@mail.gmail.com>
 <D5A2E231FFE74D1C891A1653E1C2D797@PhilipOakley>
 <9f3b254f-451e-4f6d-233c-7e995d8e369e@gmail.com>
Cc:	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	Nicola Paolucci <durden@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Eric Wong <normalperson@yhbt.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	Josh Triplett <josh@joshtriplett.org>,
	Lars Schneider <larsxschneider@gmail.com>
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <6b492c8c-2c75-9258-03dc-78346c98ff69@gmail.com>
Date:	Mon, 15 Aug 2016 20:25:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <9f3b254f-451e-4f6d-233c-7e995d8e369e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 15.08.2016 o 20:08, Jakub Narębski pisze:
[...]
> Additional references / information:
> 
> * "Alternatives to mid.gmane.org?" thread, starting with
>   Message-Id: <481D1EE2-6A66-418F-AB28-95947BBF3680@gmail.com>
> 
>   Mentions a few alternatives besides public-inbox:
> 
>      https://marc.info/?i=%s
>      https://mid.mail-archive.com/%s
>      https://lists.debian.org/msgid-search/%s
> 
>   for finding message based on Message-Id
> 
>   NOTE: there are a few mailing list archive sites not mentioned
>   in this thread, like Nabble, some of them listed on (not updated)
>   https://git.wiki.kernel.org/index.php/GitCommunity
> 
> * "Ingebrigtsen: The End of Gmane?" short note / article on LWN.net,
>   https://lwn.net/Articles/695695/ [Posted July 28, 2016 by jake],
>   part of "Announcements" (http://lwn.net/Articles/695980/) section
>   of LWN.net Weekly Edition for August 4, 2016 
>   (http://lwn.net/Articles/695974/)

* "A note from the maintainer" from 12 Aug 2016
  Message-Id: <xmqq1t1twymf.fsf@gitster.mtv.corp.google.com>
  
  includes updated links to mailing list archives, post-Gmane,
  and some discussion about public-archive.org

-- 
Jakub Narębski

