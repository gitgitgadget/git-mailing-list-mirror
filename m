Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AAEB202A0
	for <e@80x24.org>; Fri, 17 Nov 2017 01:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754727AbdKQBgs (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 20:36:48 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:37139 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752487AbdKQBgq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 20:36:46 -0500
Received: by mail-qt0-f196.google.com with SMTP id d15so2467177qte.4
        for <git@vger.kernel.org>; Thu, 16 Nov 2017 17:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ju4Tta9z/5gm0TwnsNXtYjHvYkqhC6QXjUDIwfugtNE=;
        b=JeSnOjtgxoVm4tLHk6TUtTX60hfWdDvaN3ui+iX+VbTRHgNpp9uaQLG5aqMwUnLFSU
         EkLtxC0iiQcBXDklUq3ZLXISdlKjCXEoL366go9CLz8tRTligy42hHKXlKF16oCfeI8w
         VVY2FdSW5osWBxN/odyrOejhAY89z44BWWGxCCuEh9QtseYfmczqAgG+oi8vEdgCq6mJ
         mOvcLnJenEK0XvL36FKI5LwYgya6R/WHLSdNZ56Bu1itTOa8VSZ4xJUG9S381Va7qDzK
         TsdaYFAWRMUQjG7gRYeDDoZZnw6PJoBh3bQ0LxHdlWf49Tfjx3/+jAlP40bcAN/QbO3U
         GurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ju4Tta9z/5gm0TwnsNXtYjHvYkqhC6QXjUDIwfugtNE=;
        b=fqa6ZITpz9YhiTgkvoEXb+5rBsqXtijhYLLyxJBLIPqZnmBOXJ0YBd6po5gPoy+PmO
         pUu1DiVHDqk8Fp+WthglLs207tT1bmxcN3cmMxDvsJyIP3oQQNV9HpeFyoaInGjhL7OU
         VLPbMfxhjDKxfaKqMsBgvkI+yg1AaJDkEuyvzygX0YjHO9zaAuzbBC1lyURSYxYXf6S+
         AnHS2iIgTAoyXNLWNxrcCZnS+Yn1gLcrRSHIqi9uScl4Z78OS0yRDNTtJFO498WpRoLk
         IF6JZgFtDhOfkPX1OOehLqSBm/dmXWMpDxtPL7mD+jJMtiw0FlbhLKZ4jGLfw68SieYV
         nYiQ==
X-Gm-Message-State: AJaThX5MkedRtmBgtvB5w4AXToYcdDwOof2ode2u4/iO8owmCSQI5Hp6
        htI8KeuaClqPUwE+0APMLBk=
X-Google-Smtp-Source: AGs4zMY2/SyBLGQ/GkjK5zqVFLMpKqAOBPj1pMjQiDUOYNn6SVXWqJ13Nd5rN75XRyVjhe/MwJltcA==
X-Received: by 10.237.60.117 with SMTP id u50mr5578789qte.6.1510882605419;
        Thu, 16 Nov 2017 17:36:45 -0800 (PST)
Received: from zaya.teonanacatl.net (pool-173-67-181-41.hrbgpa.fios.verizon.net. [173.67.181.41])
        by smtp.gmail.com with ESMTPSA id j30sm1822937qkh.61.2017.11.16.17.36.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 16 Nov 2017 17:36:44 -0800 (PST)
Date:   Thu, 16 Nov 2017 20:36:42 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH] branch doc: remove --set-upstream from synopsis
Message-ID: <20171117013642.GL3693@zaya.teonanacatl.net>
References: <20171116074643.19614-1-tmz@pobox.com>
 <xmqqzi7lu2h8.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqzi7lu2h8.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Todd Zullinger <tmz@pobox.com> writes:
>> Support for the --set-upstream option was removed in 52668846ea
>> (builtin/branch: stop supporting the "--set-upstream" option,
>> 2017-08-17), after a long deprecation period.
>>
>> Remove the option from the command synopsis for consistency.  Replace
>> another reference to it in the description of `--delete` with
>> `--set-upstream-to`.
>>
>> Signed-off-by: Todd Zullinger <tmz@pobox.com>
>> ---
>
> Makes sense.  Even though we internally still carry (and have to
> carry) code to notice and explicitly reject "--set-upstream", I do
> not think that we need to suggest its presence to the end user.
>
> The option parsing code marks it with the PARSE_OPT_HIDDEN bit
> correctly and it would make sense to make the synopsis section
> follow suit.

Seeing that the error output when using it tells the user to "use
'--track' or '--set-upstream-to' instead," should we perhaps also
remove the --set-upstream entry entirely?  That's reads:

    --set-upstream::
            As this option had confusing syntax, it is no longer supported.
            Please use `--track` or `--set-upstream-to` instead.

I don't have a strong opinion either way, but perhaps the error
message is all that's needed now?  Only users who have a long memory
or are reading old documentation will call --set-upstream.  I can
imagine someone coming along in a few months suggesting to remove the
remaining reference to --set-upstream from the git branch
documentation for consistency.

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
...more people are driven insane through religious hysteria than by
drinking alcohol.
    -- W.C. Fields

