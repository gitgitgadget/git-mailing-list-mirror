Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 800DB1F406
	for <e@80x24.org>; Tue,  2 Jan 2018 11:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751999AbeABLgy (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 06:36:54 -0500
Received: from mail-wr0-f174.google.com ([209.85.128.174]:45229 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751332AbeABLgx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 06:36:53 -0500
Received: by mail-wr0-f174.google.com with SMTP id o15so16051615wrf.12
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 03:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yHytf0bfbpIMEs8TZ2pLFSpcOG0t5y+ZiTpk7qaNEx4=;
        b=S3IKXxjQEKPrvRBzqk5vL2TK3vokMndiC+3vrTCyCFy8Vovm0k7/T/305S5Vv0NhXp
         yTSQD7F6Qa8HvLZ4Aj07Cccq1RuTDj7jiFuAhi7e6wcjvJRlA/sSyJ4CH5mxrVlhaNEZ
         2LGMphUmyBSvP/r+NCnUKIBgqGqIYWLe62UXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yHytf0bfbpIMEs8TZ2pLFSpcOG0t5y+ZiTpk7qaNEx4=;
        b=UAELn5/FEscMLkSmhMzSwQ1aLBMW4tGU0c2HutJlpyIPeuEfDSLhwWSuBWZl3nfiHc
         VlOIjoVAKtJse6dBn0SYvntIOEsoFR3rCcydT+Er+7dz217W/NOa2AnijJcI1KBTkAgy
         XaITJdHucE09CZdEZo4O2zoGWImR/KPiqtwle+5e8BqSRP7I8/Nk8e7bf9XhWmXQYPeU
         p85j6atMViyO2CNEO1ktk+2L9jOW+fEdB13C9l/G8QQYK8bmDug6471F1bGaKU7fOaGg
         SUSu7M0sd+bwmnRs/cJIWFlAICUQgV0P1xWZAjhKvnnmiq3OZM9TrImaeO5TSVXtpc2X
         y4Lg==
X-Gm-Message-State: AKGB3mIr6sDYTR6lGUs6yiZnf16rgvRZhe+YfgvmYfRg2goYc7HNrXT9
        CZK1lF8vvW/TVb/nvoutdYkst3esg0w=
X-Google-Smtp-Source: ACJfBou+s91Gw7pCYb085/YntvRh/JzKcuorzu4GvGAFC5+xuIRmd5cY4jOkGVOZSdhw0aWbGEvd9A==
X-Received: by 10.223.142.98 with SMTP id n89mr37919155wrb.120.1514893011805;
        Tue, 02 Jan 2018 03:36:51 -0800 (PST)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id u54sm20932071wrf.77.2018.01.02.03.36.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jan 2018 03:36:51 -0800 (PST)
Date:   Tue, 2 Jan 2018 11:36:49 +0000
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: Test failure for v2.16.0-rc0 on cygwin
Message-ID: <20180102113649.GC29210@dinwoodie.org>
References: <519ac918-6b5f-bca3-05a0-0114683b9724@ramsayjones.plus.com>
 <20171230144019.GB29210@dinwoodie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171230144019.GB29210@dinwoodie.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Saturday 30 December 2017 at 02:40 pm +0000, Adam Dinwoodie wrote:
> On Saturday 30 December 2017 at 02:21 pm +0000, Ramsay Jones wrote:
> > Hi Junio, Adam,
> > 
> > Just a quick note about the failure of the test-suite on cygwin.
> > In particular, test t5580-clone-push-unc.sh #3, like so:
> > 
> > <snip>
> >
> > Adam, are you running the tests on Windows 10?
> 
> I'm only routinely testing on Windows 10 x86_64, but between holidays
> various, I've not had the tests running for the past couple of weeks.
> I'm kicking off a build now in the name of verifying I see the same
> problem.

I'm not able to reproduce this: t5580 is passing on both my Windows 10
test systems on v2.16.0-rc0.

Looking at your output, it sounds like there's something slightly odd
with your directory permissions.  I agree the mixed slashes look odd,
but given the test is passing on both my systems, I don't think that can
be the problem.

I suspect you're going to need to do some more digging yourself given
this appears to be a permissions issue on your system.  For a start,
when you get to the failing `mkdir` with a UNC path, are you able to
create the equivalent directory using Cygwin's `mkdir` but specifying a
regular non-UNC path, or by opening the UNC path in Explorer and
creating the directory there?

Adam
