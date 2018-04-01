Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F105A1F404
	for <e@80x24.org>; Sun,  1 Apr 2018 03:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752949AbeDADP2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Mar 2018 23:15:28 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:35930 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752851AbeDADP1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Mar 2018 23:15:27 -0400
Received: by mail-it0-f44.google.com with SMTP id 15-v6so4906132itl.1
        for <git@vger.kernel.org>; Sat, 31 Mar 2018 20:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=B+fwYiAUS5IXb9mFV5ihM0kqw3CokwIFuyOK+uibuLw=;
        b=Tn+EUtZCd+1KFXpHcf1QdHKv7i40IOTCtqY3T9EZxOkARMjdzLZjxxXc7mpwrOJkr5
         TZcwMt67sw4bzugQcxCj/1OCy3yIetfoPerRD7xlCsln9xoNkPsjEQMgvxOlUMiZ6LLb
         d/sD1X/Zv29Lcgv8MW/08hENaKECLttvzZg9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=B+fwYiAUS5IXb9mFV5ihM0kqw3CokwIFuyOK+uibuLw=;
        b=a6jJZiawimHD7VR9CZo7Gd0mdGaqnDyCeZGd5BXcBV8JQUdubaKEkHMRe1r5aBtaEE
         GqUsFL33Rcc3b/AQsPrzBuz4/d4V4FxcKNZ3ZBAbEnNu+dRuEAr1W9gNtOjpWNARVYOZ
         f8xDA/NrK+KgmTrJW9hYQrDNlzx2Y+nU86exkJSF1InY8akWaQbKtg9pzdQHFILI7AQl
         3tGXiNqWtPgdMV1Z14ucDOn4R1p3yVqS2u1xAQqcQSEgrxwMLhrJ3xvtp+d30wOusKK8
         lrH4MWql2XcsX1+/L2e0tSr5XjtTS8k9/sLpW8OjKE186Vmksmc8+ygaCqTptudnNN2p
         BeYg==
X-Gm-Message-State: AElRT7H9+C/9krOcF9i7wfOt3QbfnjI1/trJz/wVU/tK7iX60NltlG22
        QxmRzQSBrvIVBTqWOn1grYrTOA==
X-Google-Smtp-Source: AIpwx49dcW1M9Lr1TknVxFON3WU15KzdwogFGFK6U7RB6cN1bE5Qm1TM+9t8EkF3gOBqDkJcvJPdEQ==
X-Received: by 2002:a24:496a:: with SMTP id z103-v6mr7592703ita.133.1522552526920;
        Sat, 31 Mar 2018 20:15:26 -0700 (PDT)
Received: from localhost ([2601:401:c500:7dd8:84ee:c3a4:39aa:e237])
        by smtp.gmail.com with ESMTPSA id v5sm6429715iog.67.2018.03.31.20.15.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 Mar 2018 20:15:26 -0700 (PDT)
Date:   Sat, 31 Mar 2018 23:15:22 -0400
From:   Taylor Blau <ttaylorr@github.com>
To:     Mark Wartman <markwartman1@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Git Question
Message-ID: <20180401031522.GA80891@syl.local>
References: <CA263ADB-E23D-4C75-ACDC-C9C0B75A4A85@gmail.com>
 <20180329015848.GA82123@syl.local>
 <15759EC4-0867-44B3-995D-6EC121A6EC4C@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15759EC4-0867-44B3-995D-6EC121A6EC4C@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 31, 2018 at 09:06:53PM -0500, Mark Wartman wrote:
> I saw this pretty exhaustive .gitignore list that a GitHub Help page
> linked to: 9257657 <https://gist.github.com/octocat/9257657> .  Are
> these configurations from the list something one should install on the
> User/global level, or do you recommend managing it in each and every
> project repository?

If those appear helpful for your project(s), then sure; but this is up
to you.

> Concerning these items below, when I said I get these when running a:
> git config —list
>
> credential.helper-osxkeychain
> filter.lfs.clean=git=lfs clean — %f
> filter.lfs.smudge=git-lfs smudge — %f
> filter.lfs.process=git-lfs filter-process
> filter.lfs.required=true
>
> I suspect that the GitHub GUI tool has installed them.  Do you find
> that possible?  I ask because I did not write them.

Yes, I believe that GitHub Desktop runs 'git lfs install', which adds
these to your configuration.


Thanks,
Taylor
