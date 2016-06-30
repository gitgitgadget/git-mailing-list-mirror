Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5741520FCF
	for <e@80x24.org>; Thu, 30 Jun 2016 05:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbcF3F7R (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 01:59:17 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33750 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbcF3F7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 01:59:16 -0400
Received: by mail-pa0-f52.google.com with SMTP id b13so24986856pat.0
        for <git@vger.kernel.org>; Wed, 29 Jun 2016 22:59:16 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:references:to:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=HEybEzj8AfGgwwyCN5wkmAvW2Y8gjh/5FLmbj98EPD0=;
        b=SZKTJiNhuujsZ9ZaneysbIR1DEaHpQ79KKukkJ3D0vFqDAAH4WwUMwGGWmGGGWJQIr
         VrSu2+1ndsvJrlQyS5y4VbnuHq/QVxFueezcCmPNDEWd05EgL2jeBv/vYI+7oE1dAY8n
         iR3CeKGqCOI3qU7Hp9nDIRykLjeCZKyTf6f6G5ow5u6uHyVTsE40K1hLwYxAi1Qg22oU
         QF8OipFke7+ojDg+bIp6hGDQ2wJhrKmuVsyvjpykgYPu80RuWLuysawiOo7gn/97Yphe
         6Ce4t+Fslb/VwHOCTFXEfzGQ2YBjDgqN5moVN+/oz6io3txYT7mBT456GECy2iCnORWK
         RmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:references:to:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=HEybEzj8AfGgwwyCN5wkmAvW2Y8gjh/5FLmbj98EPD0=;
        b=Wbc99jHVCK85e1HJPefUpLe0VlLSWOzHuyTeTLF81cTNYWxzpMp35dfXmXiP6iq4Pm
         iurbCyH9zfye4KCCyyCMzssEblP97g7+cO9tW7gq16mxCCWmajjPJSLxxOaqbksBf4rS
         x/LaC+a9dtnOQ9m6ZQdYeridyNKDusfbNaCxL+78Vge9sN1+LswNYm4zjAyz2kmNP0J0
         Ta2pbPHV86rFNti31vyWIIW+B12+YKrfaxqy3JdZ2CzG5TeH9TmE2LB4MNY1lbzLNjdD
         naGblWuWV9thdoKNmzTAm0BbmozrGtdNRIKMkltazxswc+0uQbtLcQvgkdnijqESRuH+
         8dwA==
X-Gm-Message-State: ALyK8tJCaliEYq/lAS3n3n1UiAV7ztrgqbAkLc/xsBpxHkRft1kht+86qTxvMwGIC9cEPw==
X-Received: by 10.67.3.7 with SMTP id bs7mr18461711pad.86.1467266355730;
        Wed, 29 Jun 2016 22:59:15 -0700 (PDT)
Received: from [192.168.2.11] ([223.207.72.228])
        by smtp.googlemail.com with ESMTPSA id g26sm1894336pfj.82.2016.06.29.22.59.14
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jun 2016 22:59:14 -0700 (PDT)
Subject: Re: git gui produces series of commits with exactly the same time
References: <37a71a23-ded6-9d48-a873-a05f33e802bd@gmail.com>
 <alpine.DEB.2.20.1606291344400.12947@virtualbox>
To:	git@vger.kernel.org
From:	Andrei Faber <andrei.faber@gmail.com>
Message-ID: <7ee92d87-810a-5f30-9e16-dc2d1a3e6887@gmail.com>
Date:	Thu, 30 Jun 2016 12:59:11 +0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1606291344400.12947@virtualbox>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi everyone,

I've found one case when this bug happens.

1. Create a commit

2. Amend it

3. Create several new commits

All the new commits have the same "Author" timestamp until the git gui 
is restarted.

Can anyone reproduce this?

Best wishes,
Andrei Faber

On 29/06/2016 18:45, Johannes Schindelin wrote:
> Hi Andrei,
>
> On Wed, 29 Jun 2016, Andrei Faber wrote:
>
>> I've noticed that git history contains series of commits with exactly
>> the same time, despite the real commit time of these commits was
>> different. All these commit were made using the git gui tool. I'm the
>> only developer in this project.
> Is it possible that you played games with your GIT_AUTHOR_DATE environment
> variable?
>
> Ciao,
> Johannes
>

