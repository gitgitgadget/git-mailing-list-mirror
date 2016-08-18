Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54F261F6C1
	for <e@80x24.org>; Thu, 18 Aug 2016 12:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753895AbcHRMwC (ORCPT <rfc822;e@80x24.org>);
	Thu, 18 Aug 2016 08:52:02 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37483 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753457AbcHRMwB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2016 08:52:01 -0400
Received: by mail-wm0-f52.google.com with SMTP id i5so30483617wmg.0
        for <git@vger.kernel.org>; Thu, 18 Aug 2016 05:52:00 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=TtvmSRp1QMrl8Vul9e8KeZjEMheXIeNTH47iR8+Sya4=;
        b=tYbkd1ayKzWRhaZsmJ4KyLexJfmhpmFgBAdKZHCShGl1VyyahFc66UmHjBmGCwmEp6
         7DGY/s0EMWVvR9YKxMEfBwDYvwOWM7IDvKSDUSSlRw536M6N9Mrm5Ncvyis/njaBmzok
         0FD2pjkh8DoZQT41rqTbcuMz81uDX1xHeiCltY8YtCAUsT+ykwKGX62LUuz4uhdrlBAz
         3X/HWkAkm/zO8/rungw5eKLwf8HkLBgUjBFMDEDDoGJzt/v0SEW1qafFzV/P7/9CDwwh
         catpPwqw9CcgH4vfTWitJikWLj6J9ubF7moTmJJ5i/bdkNFa0BpOCgKMk1nrPaPeCdWN
         yLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=TtvmSRp1QMrl8Vul9e8KeZjEMheXIeNTH47iR8+Sya4=;
        b=N13/y2ycjvK4D3RfWw9eq3lyMZApdk0SUgvJYJ0LO0LX6vi3kjWDC79m0TlQ+KURD0
         ihN+pADbEDRo7zvQCBizem5p97hHTyqCraPZSe02O6hhsd1+MxoG9MKBkIsHBLbSTLO/
         96ONYDt9XIgp55i4potARwKeZRnw9FEtQ4hNJlKpJqWjJIFukaC4lDMJnWdGgiw03hjA
         Az4/dqLpLYeV5TyNg5uRWv/S4Vkja5Z4tvtLBSCwYuKrhDFhlBLipk9Yb+YKQKiS2bSD
         VuVCTHDMvdYWM9kTUf1zvwaSCyX+peOM2k1c12if0Tq2KCyoYf5CIMrABLdM5azw0rmk
         xmPg==
X-Gm-Message-State: AEkoouuYCO8/TO9KscDkytinxiolE70VyOmZ8AmIUkPe+11FmRssWYjGMfbcg9mVOq0rRQ==
X-Received: by 10.28.50.3 with SMTP id y3mr2449965wmy.23.1471523370452;
        Thu, 18 Aug 2016 05:29:30 -0700 (PDT)
Received: from [192.168.1.26] (abpo56.neoplus.adsl.tpnet.pl. [83.8.56.56])
        by smtp.googlemail.com with ESMTPSA id x203sm31422770wmg.0.2016.08.18.05.29.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Aug 2016 05:29:29 -0700 (PDT)
Subject: Re: Working from different machines.
To:	Junio C Hamano <gitster@pobox.com>, Tobiah <toby@tobiah.org>
References: <71d05705-792f-8bb9-026b-5b9251b104b9@tobiah.org>
 <xmqq4m6j81ci.fsf@gitster.mtv.corp.google.com>
Cc:	git@vger.kernel.org
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <60d5e760-dbc9-121e-f003-a6971534cdcb@gmail.com>
Date:	Thu, 18 Aug 2016 14:29:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <xmqq4m6j81ci.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 18.08.2016 o 00:41, Junio C Hamano pisze:
> Tobiah <toby@tobiah.org> writes:

> [...] the next question is if you commit all the
> changes you made before you leave the 'desktop'. [...]
> 
> If the answer is "yes", then you are in the problem space that
> Git-the-tool is interested in solving.  Assuming that you have
> network connection into 'desktop' from 'home', the solution would
> involve making it the first thing to do when get home to run "git
> fetch" on 'home' to get the latest state from the 'desktop', and run
> "git push" on 'home' to push out the latest state to the 'desktop'
> before you leave 'home'.  If your 'server' is for your sole use, and
> if 'home' has network connection into 'server', then you could
> instead rendezvous at 'server' by running "git push server" on
> 'desktop' (or 'home') to 'server' as the last thing before you leave
> 'desktop' (or 'home'), and running "git fetch server" on 'home' (or
> 'desktop') as the first thing before you start working on 'home' (or
> 'desktop').

Two additional comments:

* First, `--mirror` might be what the relation between 'desktop'
  and 'home' repositories should be.

* Second, even if you can connect only from 'home' to 'desktop',
  but not from 'desktop' to 'home', the refspec mechanism of Git
  is flexible enough that you can emulate 'push' with 
  appropriately configured 'fetch', and vice versa.

-- 
Jakub Narębski

