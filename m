Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62FB81F428
	for <e@80x24.org>; Sat, 16 Dec 2017 06:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750987AbdLPGGk (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Dec 2017 01:06:40 -0500
Received: from mail-io0-f169.google.com ([209.85.223.169]:45538 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbdLPGGj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Dec 2017 01:06:39 -0500
Received: by mail-io0-f169.google.com with SMTP id e204so4813417iof.12
        for <git@vger.kernel.org>; Fri, 15 Dec 2017 22:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3WNANttwfDxh9vtEayJAsiEaDr5irlTaWwaIxtpcR3o=;
        b=rqkww+d+g4KHEj3f5OK75SuMDqwBLnYpczl/eZaFqFW8BUANTQobmGsRZ4a5hT1CDx
         oBAA4i9O0RnjqjIBAe6+2BckoOB/mQHH2KZ/CiVd8CCQ8AVE5dRXRJNPiK61LVR9Csvl
         K1Zrg6W8KrgEO4FI9nTo2o6JoPatTvRNxijyB/2iZjTorVFu1lYH7vV9B1ilCH1BQms8
         a9d6E4rRgmVZNIJb9vALAk/V7v6bYB2ciUINildzpjrBAj4xwUZV7g59FoU8/VTXJ4jn
         gku2gdsLLbKLPoILRc8bDdv4+pEHGi/RcWcsWsLwW4S41bTBjgbYls7ut4VCw7MbDXb8
         p1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3WNANttwfDxh9vtEayJAsiEaDr5irlTaWwaIxtpcR3o=;
        b=KB8BZD5IrJSHBHJJghmkAPLLbjSoU602KQP75vOTuby/V8AS8seaX0ybecmU8OH3t+
         q8dpuwQysIsTWtHNhACMKMmG6v8yb/Y8IhDei0HFCnwLZIzkW5Emr+rt8PPuzpgHkkLg
         RzjFac327aPeZiXFO6uW2j4/S2aPEemnWiLTSq/qzPi+QzCcFtCINzv7DLpDL4/bAJCd
         F1YyskorLIY+GKe0U1OYG0M2gXz2BHsvggssFQesshXdebGpyxWp8wzBaEZObh62tFRa
         nVro55q6beUbYDBFTmMyq72BFnl7NaacjX1okTdtswqUQwtJmremUAs4lt6ngfMV4iq+
         KXGQ==
X-Gm-Message-State: AKGB3mImVUMk1ltoXEtg+0HfgKn+XmbzpiuYnk8tGBY2Z1awMpJu01aq
        HizwD4xaWQTfGEeWkkaseKJWlGsj
X-Google-Smtp-Source: ACJfBot79A93uE4cgiGtyXr0XyuS/e3uvRrsvBlU2PqkI7jC5LPIQz29ilcRfzW+10dTTCl8po2h7A==
X-Received: by 10.107.18.216 with SMTP id 85mr3798858ios.276.1513404398661;
        Fri, 15 Dec 2017 22:06:38 -0800 (PST)
Received: from [10.4.2.238] ([14.102.72.147])
        by smtp.gmail.com with ESMTPSA id e72sm4234504ioe.33.2017.12.15.22.06.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 15 Dec 2017 22:06:37 -0800 (PST)
Subject: Re: What's cooking in git.git (Dec 2017, #03; Wed, 13)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqqzi6mutcc.fsf@gitster.mtv.corp.google.com>
 <1513255038.6351.2.camel@gmail.com>
 <xmqqk1xpusyh.fsf@gitster.mtv.corp.google.com>
 <xmqq1sjxt3tz.fsf@gitster.mtv.corp.google.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <dbed9ef3-0bf6-01e2-13d2-4c92a243c321@gmail.com>
Date:   Sat, 16 Dec 2017 11:36:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <xmqq1sjxt3tz.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Friday 15 December 2017 02:38 AM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> I think you only sent 3/3 in newer rounds, which made it not to
>> apply to my tree.  If you meant to drop changes in 1/3 and 2/3,
>> perhaps because they were needless churn, then 3/3 needs to be
>> updated not to depend on the changes these two made.
> 
> Here is what I reconstructed to suit my taste better ;-)
> 

Looks good to me except that your v4 3/3 seems to be spawning a subshell 
is an oversight, I guess? Also, I guess it would be better if there was 
comment in the code saying 'branch_nam' might hold a commit/branch name. 
No worries I'll send a v5 to that thread based on your v4.

Thanks,
Kaartic
