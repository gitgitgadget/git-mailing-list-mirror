Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 191E01FC34
	for <e@80x24.org>; Fri,  8 Dec 2017 20:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752085AbdLHUpz (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 15:45:55 -0500
Received: from mail-wr0-f181.google.com ([209.85.128.181]:37686 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750951AbdLHUpy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 15:45:54 -0500
Received: by mail-wr0-f181.google.com with SMTP id k61so11916872wrc.4
        for <git@vger.kernel.org>; Fri, 08 Dec 2017 12:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9vJVrnvIvkcFMfcNuDdaYkU3ODEG3SLOO6Ke3WVST1A=;
        b=fW77dKpRwCE2wbEk3hV4LQwdLtP+Bmyd3t14Kwc6ZcME7bEgrqLXST/k2A8WWIg1/q
         oIIB8Y+mMXJ/6SuNhTEnhV1qjzq0zQPJN++f2qbPMVN2Z/LrBJmHkmQHo40wCt9R83IK
         w5XhU9WureVCoYwXA3CLTTeElZYQ+ObGEe/1raa+6A1Q9xxaGiFfUayYTEm398LgbJg6
         ub+VmsUuRaWMLiYzmMo1T3YcMeNYhZTiot2vvTwNwa4lK+igSmyHR7KTLGENK04PrpPC
         WWyMCtsgroXGtYa1ivHNuJWfkl3/Fryr9fMripckvAeDmhzk53cnYc7gnsElOT5TGeml
         ye9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9vJVrnvIvkcFMfcNuDdaYkU3ODEG3SLOO6Ke3WVST1A=;
        b=sgnW/ukh50CCIBuUPIiotXJFmX4Vv6FW1lBUmDSfiXW3+KQZjqprdpLRwKy2jApGCt
         EwMNPzuceo/mIAGqshliVWB8kvLLgQ10JLhPPctkAl7WaQ6XCceII0bAzOJX6d+l2fOJ
         F5CXqNwZ2G70qfcxLQmEs3elL2HNySNtBLfQKXR6UE33QSo9324ZWfmo8vZnHIYrs0UZ
         uGxkocDSD5s3xdCQ7cJ3luIE4Kb6xBWddVEQlSqYJVMq26bgUMfPNt4K0HnL4sJ6F58m
         UiOGxswo9EA/0QOa+BeSFjttYiip5uoZ4T85IAQK1UZYSRpHxSOyz4QlLXXaBN8UyoUQ
         whag==
X-Gm-Message-State: AJaThX5UZXaQrNOd6cRa9TZMRToDEjye/EzQ7N+NpgNvmtB2Wl05es8H
        I7n0teWgcMB4pIn8T5dV+lI=
X-Google-Smtp-Source: AGs4zMb6IY+3tRdjEz1ULocV5wSSZQNbeR6amFVGZhnd+bSOUV86qILoVb6EENi2jnEwRnLvTcZ8aw==
X-Received: by 10.223.154.182 with SMTP id a51mr26425335wrc.48.1512765953477;
        Fri, 08 Dec 2017 12:45:53 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id 139sm2481708wmp.7.2017.12.08.12.45.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Dec 2017 12:45:52 -0800 (PST)
Date:   Fri, 8 Dec 2017 20:47:36 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 1/2] t/README: remove mention of adding copyright
 notices
Message-ID: <20171208204736.GA25616@hank>
References: <20171126202100.1658-1-t.gummerer@gmail.com>
 <20171205194937.GB8183@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171205194937.GB8183@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/05, Jonathan Nieder wrote:
> Hi,
> 
> Thomas Gummerer wrote:
> 
> > We generally no longer include copyright notices in new test scripts.
> > However t/README still mentions it as something to include at the top of
> > every new script.
> 
> Where can I read more about this change?  Was it a deliberate change
> or something that simply happened?

I'm not sure if it was a deliberate change, I just noticed that most
new test files don't have a copyright notice anymore.

    $ git grep "Copyright (c)" t/* | sed -E 's/.*?Copyright .c. ([[:digit:]]+).*?/\1/' | sort | uniq -c
         61 2005
         40 2006
         55 2007
         32 2008
         31 2009
         30 2010
         10 2011
         14 2012
          4 2013
          3 2014
          1 2015
          5 2016

While we may be adding less new test files, we definitely added a few
in 2017, for example t/t7521-ignored-mode.sh in 371c80c746 ("status:
test ignored modes", 2017-10-30), or t/t0025-crlf-renormalize.sh in
9472935d81 ("add: introduce "--renormalize"", 2017-11-16).


> Thanks,
> Jonathan
