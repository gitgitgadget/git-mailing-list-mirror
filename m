Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 056812023D
	for <e@80x24.org>; Tue, 23 May 2017 05:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759395AbdEWFDx (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 01:03:53 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:34977 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760673AbdEWFDj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 01:03:39 -0400
Received: by mail-pf0-f175.google.com with SMTP id n23so102560486pfb.2
        for <git@vger.kernel.org>; Mon, 22 May 2017 22:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WX+EQKmAifKsD/zeTSgr5GSQASTMn9tbQM2pisDgrJ8=;
        b=IOQFZF7dRDb2qSIUZoHSrLM0b8gvVVTYtci2RZpV/smHGqj1HmljXBV6LtLreL8Zs0
         bfA7R2JuhCreOz9W9Zucii0b5z74xW989CRHwVEXXoNqTcAY5Zu+HngGVvrL2FY32Wkr
         cZ69m4DTMWd6yYk82CDgUvQCCXZiqar1e/gOB4ZYJmDvhFpT4tLDWJ61a3fbocPKJHZP
         LftW2cM2N+G0E8+v3HO2dtFDsFqEYCYc+SmbJ4wvWXxjzVP4b3+n/O3vQkGR6LrDsLlp
         ZL0HaMKUcH6gZ9fi6TTUVoMQZi9OMl5FwtC9Pf8XAcqX3rjxFsBYVpOU0OFcUFqov3o2
         RcsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WX+EQKmAifKsD/zeTSgr5GSQASTMn9tbQM2pisDgrJ8=;
        b=EybV0UC6hKVAHjm0YnM+5j6xxJvm7QpzMo2siz8e1NldV8+2FJlcyJxsntV7gKCplj
         +x1Re0zEN0PkTEEzn1sK4lIqRfWfRkO62wzWbwjRbar+dDogI0D1iMzzGx20ViWolKCL
         yt1PfGaTH6OpMO7t96bdeiqMHoIffTPOtIxTun/zQkCiVwSgLbNtcMivg7GppZbOtFV1
         V5/JhCIveEAS25kb5Fn9SS0evRzzRBxHzEP2CfrYuysxbPkh/boQITXoV6E/Qu1bu8iP
         BfZ0OJEiYLgtpqhfVjuWyNET4dFGdE/Pj+sobg2yl6bv/iVgyELrwXZZOiP+vBTi0jJb
         zJMg==
X-Gm-Message-State: AODbwcB9XsnVvol+V3eEMMhkbA944CUOz35TnUEg0tHyGeRfjJojyCu9
        kAdFwQYVcFL62gFp8vU=
X-Received: by 10.99.189.9 with SMTP id a9mr10465819pgf.9.1495515818432;
        Mon, 22 May 2017 22:03:38 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:557c:4659:8965:b134])
        by smtp.gmail.com with ESMTPSA id b2sm522113pgc.16.2017.05.22.22.03.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 22 May 2017 22:03:37 -0700 (PDT)
Date:   Mon, 22 May 2017 22:02:36 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2017, #06; Mon, 22)
Message-ID: <20170523050236.GA21264@aiede.svl.corp.google.com>
References: <xmqqo9ulo1yn.fsf@gitster.mtv.corp.google.com>
 <20170522174208.GB17710@aiede.svl.corp.google.com>
 <xmqqlgpomelp.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqlgpomelp.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>> Junio C Hamano wrote:

>>> * bw/forking-and-threading (2017-05-15) 14 commits
[...]
>>>  The "run-command" API implementation has been made more robust
>>>  against dead-locking in a threaded environment.
>>>
>>>  Will merge to 'next'.
>>
>> What's holding this up?  The deadlock it fixed was a real,
>> non-theoretical issue.
>
> Does "Being down-sick over the weekend" count?

Yes.  Sorry, I should have asked in a more productive way.

I applied the patches locally to ensure tests continue to pass
reproducibly but was worried because the patches had been ejected from
"next" and had been in "Will merge" state for the last couple of
pushes.

Your health is more important.  I hope you get well soon.  Sorry
again, and thanks for looking them over.  

Sincerely,
Jonathan
