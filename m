Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42F9C207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 21:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752545AbcILVOo (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 17:14:44 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36847 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750998AbcILVOn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 17:14:43 -0400
Received: by mail-wm0-f50.google.com with SMTP id b187so156182816wme.1
        for <git@vger.kernel.org>; Mon, 12 Sep 2016 14:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=TmoueWmp+3nxTtoRBVqyztQ47utv1WDXhz9ia9d4EcY=;
        b=aUm34I7+49OczmAAipv3c7IBLnNOBUY4JHwpowMBslI5KmndIL7B92PaL3Pm2LOBhM
         h2cuR1P2WupDJ3N4/IYM3YrbZgZKzY6hiiRMhW40MQwXswdgjtaap90gYWQl7Q6EVzH3
         b4t/HMXwDbvoDcpCg2OyVlSE1ILv7adsflJ3lSBEud4DE9P5Jm/9zwITtXTVJXHR3B0F
         SSyfavPB8amAPRXc+q//LWV5cJ7P7bGUN3CZCIB9ydSkkHTzWyMrbiPT8CEdOB8XYXLt
         BNfM5yUEPCJY03I4wCph+BQHC32JEwqf4GatQuskl5Gv0XyKzioNZUnVSG1wGJFvjK0m
         E0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=TmoueWmp+3nxTtoRBVqyztQ47utv1WDXhz9ia9d4EcY=;
        b=A2vUIBnnpw2r+nDktrapWMpIoEu47AqZnPG2y+KJ8y0f0eHjRyXCpt3PYCQr2AJk0k
         7Evluhgc/w1GCVfId9MJ9+0MEJ2+E+urE8RhAr1ghdSeLLQk59OlvwBx4Qa9F283tqJw
         EUIy6D/WDk5U0NPQ2uqS0Gr+caeoC9mN14SzfpCERpdd58z3kV2SBf0bVMBh55OeYoLT
         YsfmNsJQY3FWNtecfnitIJkpkqfPn68Q2fjjMctmMUt7GmKUrJpMDr3UVT8B6pGDkBrh
         9oJotQGqJvyoMhlnHKYRLxob3Hzq36CIRn0Wg6pPRyra4dk3PLsfkEIe3v/HgKVgYw8w
         T3Sg==
X-Gm-Message-State: AE9vXwPs9zaAaMWYRtik3+oGVsbly8kZ3EGkWUoRIpW7z7oCYSFYpYC0rwjjaadpadEduA==
X-Received: by 10.28.43.129 with SMTP id r123mr1796025wmr.27.1473714881958;
        Mon, 12 Sep 2016 14:14:41 -0700 (PDT)
Received: from [192.168.1.26] (elj71.neoplus.adsl.tpnet.pl. [83.21.203.71])
        by smtp.googlemail.com with ESMTPSA id e12sm1994224wmg.17.2016.09.12.14.14.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Sep 2016 14:14:41 -0700 (PDT)
Subject: Re: git commit -p with file arguments
To:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
References: <87zinmhx68.fsf@juno.home.vuxu.org>
 <CA+P7+xoN+q_Kst=qXG_HRznxbN7cbyi5uZe15zq1c16EifeK1Q@mail.gmail.com>
 <xmqq8tv1c5nb.fsf@gitster.mtv.corp.google.com>
 <23de5ffe-eaf8-2d62-2202-f1bf6087d44b@gmail.com>
 <87inu4bxt7.fsf@juno.home.vuxu.org>
 <b9d63103-011a-9486-2fa1-dcf3a82cbe64@gmail.com>
 <xmqqvay26r8u.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xqdWbERVQenZJTLyirBy2VFrKV2-uBOxB1CwcWs+gy43A@mail.gmail.com>
 <xmqqa8fd6fs7.fsf@gitster.mtv.corp.google.com>
Cc:     Christian Neukirchen <chneukirchen@gmail.com>,
        Git mailing list <git@vger.kernel.org>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <717354e1-79be-d1a2-c6bb-843d6ab99e41@gmail.com>
Date:   Mon, 12 Sep 2016 23:14:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <xmqqa8fd6fs7.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 12.09.2016 o 03:57, Junio C Hamano pisze:
> Jacob Keller <jacob.keller@gmail.com> writes:
> 
>> Yes, I'm actually confused by "git commit <files>" *not* usinng what's
>> in the index already, so I think that isn't intuitive as is.
> 
> You are excused ;-)
> 
> In ancient days, "git commit <pathspec>" was to add the contents
> from working tree files that match <pathspec> to what is already in
> the index and create a commit from that state.

That is, "git commit <pathspec>" meant --include, being equivalent to
"git commit --include <pathspec>".

>                                               This ran against the
> intuition of many users who knew older systems (e.g. cvs) and we had
> to migrate it to the current behaviour by breaking backward
> compatibility.

That is, "git commit <pathspec>" means --only, being equivalent to
"git commit --only <pathspec>".

But it was always about working tree version of <pathspec>.

And of course older version control systems didn't have the index...
-- 
Jakub Narębski

