Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51B951F744
	for <e@80x24.org>; Wed, 20 Jul 2016 18:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754343AbcGTSLG (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 14:11:06 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36479 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752777AbcGTSLD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 14:11:03 -0400
Received: by mail-wm0-f47.google.com with SMTP id q128so66201772wma.1
        for <git@vger.kernel.org>; Wed, 20 Jul 2016 11:11:02 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=AevEbwe6pqSH0uoCMM8PkRJBa7raEuS8xeJfSfYIeEE=;
        b=cz4DSxFPJ2CtQmE8y6AwduYiLXfqo6FO17H71ocBayrnoIAZTlpvGaAkVLC7sGMIvq
         N6IROJMMuEUoYrBaZUobvyDi1lf8OsRbQZZaTh2Jv1d3y3z5n8nnGKl94SLIvobYf+eE
         4ysq84qAmWxsgc2dyfWzrVOTZFhhzm2wCC6l1gvQqbFwig9Yuc723V2ERzKWpj97/EYA
         +yC3uiekfYMq3IiQ50qrMtiElwZk8+3QB4nuL9ZtUr1tioGcM2Dt6H9fKzBeg4niStvu
         f2IKfjHvwHDHHWqZzBgDtR888RkfQf9cOXjH4zwiqC1wX4ls4bV7nH7cu+TWVWi4vCj6
         maIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:newsgroups:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=AevEbwe6pqSH0uoCMM8PkRJBa7raEuS8xeJfSfYIeEE=;
        b=ZgewdfMtYDtFF/I29KsQRHAp14yR3Jjejgvcomd3W0/3wXFqncXZdnecYbuynFIU5k
         p/Up3CGdvkXk9dmZa+7jVK6Wo5fD+WHT/SF4U3j0ClSLW6ptK8YYGet55mnMPxp4yLn9
         9LUXXEseMhs2asvOLKXzAALmjgTLX13Apo2Krl0R2aoqrhr5He+uWhJRklnqUI1H37U3
         1d7/tayITcS5ryUjCj4LsO/YCpwhCTAjZQpghtvHPubuI6dkoyTwQxtTztb9ubKfcJwl
         zkn6anlmIZ6FttKx6Jtp7t8WyL78JXrDduINJ1ZYyxTNJdIv1NKhe3zgnrmOLoDZ+YNS
         cBKg==
X-Gm-Message-State: ALyK8tLAGY5T1ayAJnirLj7pGp2RhJEgSBQ3OxDct8ACw1IAcrdz4Qd6IVMrX+BRusVjjw==
X-Received: by 10.194.17.105 with SMTP id n9mr2661726wjd.161.1469038259760;
        Wed, 20 Jul 2016 11:10:59 -0700 (PDT)
Received: from [192.168.1.26] (daf247.neoplus.adsl.tpnet.pl. [83.23.5.247])
        by smtp.googlemail.com with ESMTPSA id a18sm2410710wjs.5.2016.07.20.11.10.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jul 2016 11:10:59 -0700 (PDT)
Subject: Re: How to generate feature branch statistics?
To:	Ernesto Maserati <ernesto.2.maserati@gmail.com>,
	git@vger.kernel.org
References: <CAOHAwykGkfY7M30jT8t0k6Gsdy5QSBHmAPiWYoKibjUgS-G6hg@mail.gmail.com>
 <578F8306.3070306@gmail.com>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <578FBEAE.9080307@gmail.com>
Date:	Wed, 20 Jul 2016 20:10:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <578F8306.3070306@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-07-20 o 15:56, Jakub Narębski pisze:
> W dniu 2016-07-20 o 10:05, Ernesto Maserati pisze:
> 
>> I assume that feature branches are not frequently enough merged into
>> master. Because of that we discover bugs later than we could with a more
>> continuous code integration. I don't want to discuss here whether feature
>> branches are good or bad.
>>
>> I want just to ask is there a way how to generate a statistic for the
>> average duration of feature branches until they are merged to the master? I
>> would like to know if it is 1 day, 2 days or lets say 8 or 17 days. Also it
>> would be interesting to see the statistical outliers.
>>
>> I hope my motivation became clear and what kind of git repository data I
>> would like to produce.
>>
>> Any ideas?
> 
> There are at least two tools to generate statistics about git repository,
> namely Gitstat (https://sourceforge.net/projects/gitstat) and GitStats
> (https://github.com/hoxu/gitstats), both generating repo statistics as
> a web page. You can probably find more... but I don't know if any includes
> the statistics you need.
> 
> I assume that you have some way of determining if the merge in 'master'
> branch is a merge of a topic branch, or of long-lived graduation branch
> (e.g. 'maint' or equivalent). To simplify the situation, I assume that
> the only merges in master are merges of topic branches:
> 
>   git rev-list --min-parents=2 master | 

Self correction: Here you need to use --first-parent, as in Peff answer
(which also uses less git invocations, and less of git porcelain).

I wonder if it is something that libgit2 would be helpful...
-- 
Jakub Narębski

