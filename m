Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C1B31F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 13:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751819AbdAYNCp (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 08:02:45 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33195 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751779AbdAYNCo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 08:02:44 -0500
Received: by mail-lf0-f65.google.com with SMTP id x1so21034669lff.0
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 05:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=eXFntPnpGShWJ8lyLA7sjnbBIXwicW72ejBlS+isaZM=;
        b=TNA4Wx8FVwTje6iNBWEHq6UtbiNKzLfssBc6M2Y/IcfG+Gi4FJpGIO5rnWltF79Apd
         AcH2nZCzBOu3SGqhWnKlxGnbmli4QPDqMt4XlIhYt4p79xPQC+yBtShZJTh6abJvjR3B
         ZbRIpgB2ti13obH9BAQ8cIYBLcCPsPHyu54/jWaiXfFt+VFBY9dzRhBcXn37DAMbfxBT
         egd3IfU7cYauJJ8HRUUeU6rVUoV47EtbaR81YcZPEFBoCKDd2gEJAMq7CQZw5V99DfN2
         HvfL2FTL10DvD7Tc0R/3LhsNyuP0VbGkG7GahRoTpCKUuLPRJonrzVJGbipCVnMXtMlz
         8LtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=eXFntPnpGShWJ8lyLA7sjnbBIXwicW72ejBlS+isaZM=;
        b=uWdxEqupxssJhhL2dXVBbvvGkObm6O2rf0yjSRNv+FKFg0Kk9jFbWipTHd1e6Gasw0
         vd25bUwt65XvxzZyErTaHcusZCFRv0cJqj91aFqdsPMqg8p7gMljsp2Qjc8qM3EPGULu
         XSArf3TGvwoHVimFHudkhn9f/icgPJwmfLZoLQqD6fwsgDQ7ZcP2gXNY+kb7Wr+bk6xD
         h7rhKyNfSDhJ27p3Bumj9K5asA1HTDy6Eu9CBe9rqP63Qho8MjjJG8S2PwKyUu3lVyi7
         phkI9NsfLqN8CjVRq5p++71CO2GE5knWmGeoFtFqsPZe7MzaP8VAaFH5DWxMY8dPtt6E
         1NBg==
X-Gm-Message-State: AIkVDXKEG2mFJXhhZyXxwXMPmL10181If8TMB5Q2gfs0N9gtRQ1m0UrJ/+TLGxTQ/ZLHmA==
X-Received: by 10.25.228.138 with SMTP id x10mr12851880lfi.55.1485349362978;
        Wed, 25 Jan 2017 05:02:42 -0800 (PST)
Received: from [192.168.1.26] (exc127.neoplus.adsl.tpnet.pl. [83.20.252.127])
        by smtp.googlemail.com with ESMTPSA id 17sm8370823ljp.45.2017.01.25.05.02.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jan 2017 05:02:42 -0800 (PST)
Subject: Re: [PATCH 1/3] Documentation/stash: remove mention of git reset
 --hard
To:     Jeff King <peff@peff.net>, Thomas Gummerer <t.gummerer@gmail.com>
References: <20170121200804.19009-1-t.gummerer@gmail.com>
 <20170121200804.19009-2-t.gummerer@gmail.com>
 <20170124201415.zzyg4vt35vflwjnb@sigill.intra.peff.net>
Cc:     git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>,
        Junio C Hamano <gitster@pobox.com>,
        Marc Strapetz <marc.strapetz@syntevo.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <d327cfc5-2f0d-1a67-d5f5-b9b7a06f7570@gmail.com>
Date:   Wed, 25 Jan 2017 14:02:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170124201415.zzyg4vt35vflwjnb@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 24.01.2017 o 21:14, Jeff King pisze:
> On Sat, Jan 21, 2017 at 08:08:02PM +0000, Thomas Gummerer wrote:
> 
>> diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
>> index 2e9cef06e6..0ad5335a3e 100644
>> --- a/Documentation/git-stash.txt
>> +++ b/Documentation/git-stash.txt
>> @@ -47,8 +47,9 @@ OPTIONS
>>  
>>  save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
>>  
>> -	Save your local modifications to a new 'stash', and run `git reset
>> -	--hard` to revert them.  The <message> part is optional and gives
>> +	Save your local modifications to a new 'stash', and revert the
>> +	the changes in the working tree to match the index.
>> +	The <message> part is optional and gives
> 
> Hrm. "git reset --hard" doesn't just make the working tree match the
> index. It also resets the index to HEAD.  So either the original or your
> new description is wrong.
> 
> I think it's the latter. We really do reset the index unless
> --keep-index is specified.

I wonder if it is worth mentioning that "saving local modifications"
in 'git stash' means storing both the state of the worktree (of tracked
files in it) _and_ the state of the index, before both get set to
state of HEAD.

Best,
-- 
Jakub Narębski
