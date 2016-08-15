Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53E031F859
	for <e@80x24.org>; Mon, 15 Aug 2016 18:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752992AbcHOSIk (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 14:08:40 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37015 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752915AbcHOSIi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 14:08:38 -0400
Received: by mail-wm0-f51.google.com with SMTP id i5so118794594wmg.0
        for <git@vger.kernel.org>; Mon, 15 Aug 2016 11:08:38 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=XnqgSTU39i16AQmErM6R8+5LLdbLtf+eMX12Kp0UIyM=;
        b=wgzUT27X2Rocy/f2W39AIxMtxmSQZylGa3+wsa6V9wiJVmjGyO5LSLa/IPu/tgLT2r
         Q+RtWeSWMy2De3V+p+u8xvxiTWkZ7nJkdgeBmRp5JR/JsBfcKetiCfInAoIas/5mX+VP
         eVcyt7egqWbAnXdS37CIOWZc6zfuLKjB/eUY/Gk7kdDCUEjzrE5hkOfDuQwVwcyOWh28
         P/l7yxtw6r7rS11LXcYbe9hIDaZjWIQ7kernbsld4xkzmOL/TK1XPV4vEyudcTVCWEZy
         9lI0jlyKcUkkbVa2IWr4e2R+PGoHCKC2VacRPADkrzIrUxFaAjxDssJFFijt/W2BfKc0
         3mow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=XnqgSTU39i16AQmErM6R8+5LLdbLtf+eMX12Kp0UIyM=;
        b=SELIOfWiioRXu96yG/m0X7LCtAp65dRnmO+Iu/1dupXrRfKRi4xDQMnfm5BpT9lkrD
         PVvzKPnUUEGqxJPCf5VvM+7U9AP2ETJt+JeuA9qluxgzI39TikVdWQqJ62bAPnyC8Q8Y
         cmqGicncYSVHeXYu4LVcZTLTkSrlKrDyAx+ueXUEkR+XTO2ncZu85fRhMuw2v6raI/Qk
         UEpdZsn8s3jRoojm12ZqTeLyafiEaVLumk6k8LciPgsyh9ERM3qnyMd3YhwiqjC23UHr
         lkBmGlhtmrdvc+qd/0nmfDSJFGbhLbShI1aeisN1PN9kq1gwD5nx/igdKaJUnXNVzh+e
         UJ2Q==
X-Gm-Message-State: AEkoous0S5lBLcPbExWL3R4EBNd4urjcYBsdpMWYesmJiCZituBqJNHEmu54AvbADgMAhQ==
X-Received: by 10.194.47.206 with SMTP id f14mr36389245wjn.98.1471284517095;
        Mon, 15 Aug 2016 11:08:37 -0700 (PDT)
Received: from [192.168.1.26] (ewj67.neoplus.adsl.tpnet.pl. [83.20.233.67])
        by smtp.googlemail.com with ESMTPSA id va3sm22669723wjb.18.2016.08.15.11.08.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Aug 2016 11:08:35 -0700 (PDT)
Subject: Re: Draft of Git Rev News edition 18
To:	Philip Oakley <philipoakley@iee.org>,
	Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>
References: <CAP8UFD1iveotLsMOBnpa=hU4ohcQjZ-X7tjnzY4k+xz5KJvqBw@mail.gmail.com>
 <D5A2E231FFE74D1C891A1653E1C2D797@PhilipOakley>
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
Message-ID: <9f3b254f-451e-4f6d-233c-7e995d8e369e@gmail.com>
Date:	Mon, 15 Aug 2016 20:08:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <D5A2E231FFE74D1C891A1653E1C2D797@PhilipOakley>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 14.08.2016 o 23:10, Philip Oakley pisze:
> From: "Christian Couder" <christian.couder@gmail.com>
>>
>> A draft of a new Git Rev News edition is available here:
>>
>>
>> https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-18.md
>>
>> Everyone is welcome to contribute in any section either by editing the
>> above page on GitHub and sending a pull request, or by commenting on
>> this GitHub issue:
>>
>>  https://github.com/git/git.github.io/issues/170
>>
>> You can also reply to this email.
> 
> I see you mention in passing (well in the small headings near the bottom)
> that gmane web interface has gone away. It may be worth noting a few of
> the alternatives, and in particular Eric's newly updated public-inbox
> https://public-inbox.org/git/.

It would be nice to turn it into mini-story rather than just putting
a link.

Additional references / information:

* "Alternatives to mid.gmane.org?" thread, starting with
  Message-Id: <481D1EE2-6A66-418F-AB28-95947BBF3680@gmail.com>

  Mentions a few alternatives besides public-inbox:

     https://marc.info/?i=%s
     https://mid.mail-archive.com/%s
     https://lists.debian.org/msgid-search/%s

  for finding message based on Message-Id

  NOTE: there are a few mailing list archive sites not mentioned
  in this thread, like Nabble, some of them listed on (not updated)
  https://git.wiki.kernel.org/index.php/GitCommunity

* "Ingebrigtsen: The End of Gmane?" short note / article on LWN.net,
  https://lwn.net/Articles/695695/ [Posted July 28, 2016 by jake],
  part of "Announcements" (http://lwn.net/Articles/695980/) section
  of LWN.net Weekly Edition for August 4, 2016 
  (http://lwn.net/Articles/695974/)

> I've found it very useful and probably easier to use.
> (now I've seen https://public-inbox.org/design_www.html)

It's a great pity that https://public-inbox.org/ is just
directory index, not a true home page.

-- 
Jakub Narębski

