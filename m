Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A8C92021B
	for <e@80x24.org>; Mon, 13 Nov 2017 19:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755028AbdKMTt0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 14:49:26 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:48366 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754649AbdKMTtZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 14:49:25 -0500
Received: by mail-qk0-f176.google.com with SMTP id a142so21245287qkb.5
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 11:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AoSvIuHuVUgsOV1BudNRg683qB9pD7x3HU2XzI3fNIQ=;
        b=lwqGqBxBBigvJrB1NFRZmAYws8er/Q+O6D0eG/2gf3dtHsHv2AzTvNw+N2bQCG0h3z
         H1AVacY5+6RTG3pH0LLvDzD1uKHFfKzGyToRKbubAa/eruX7KMMZICZW3YRD7r2DiF6X
         81W7DC0Ou3mnFCWYm2ZbEmSJctvjZz1TzT224GuEdK4gvaAETupJl+/CR/2rOq7+Y77a
         oAT9FWhHvUTe888lGKtWTUzoNFTUzhZIXrESKLfXADEuu0TSQ6tBCcZ3uFXppVjfh1tj
         Sqhhggv3ar0r62+HEwkNoKUBtccKBCeZ2+1tOBQ8WeGCN8GjSg5k5EB9lvQjntU8OS4D
         LOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=AoSvIuHuVUgsOV1BudNRg683qB9pD7x3HU2XzI3fNIQ=;
        b=NsHjmxjsUPm690PA8xXUL0Uh1pFBOEVSr2kkQC5mDGfO61BP3smjvyhPktKL1BiLhX
         S/v06pdoSOhpdq1EQHQLClQ/WXTtBE+gYd6GlYXA9ijpgeh6lxhAbCcFAjodgeQJKUi7
         beTCqBeXU9GS6JDCH1+3w96OtErOE3FU5NzWsloXozKpYq0c9M6eHfPdqiFgwLKM+eO8
         udPuPr1hdNOBXfNS1QPtrpeD6tCByu4qOOIFagyAJdP9Tuw3Jldpr6JHoWtnAzhrPs9y
         m9XZsIm2iqJ17qGupnWQQc+USFjFYG5dDNePR47YluND/WTm9mi/88kZbnZF7IyzeJEo
         L38w==
X-Gm-Message-State: AJaThX62pHl1aYIV9jY15EIW+6+OyDzNtCLB4b4riIiVwtKlXq8Q/2Wc
        TCX0Mgmt6oU41FpQbmmDUVI=
X-Google-Smtp-Source: AGs4zMaHS+64SPrdU5hk1Bt43A/lKRmaypkydtfs1Q2EgNFY7gQRtuerTO/w2yau2BAa8r/a+HewMw==
X-Received: by 10.55.77.67 with SMTP id a64mr14598227qkb.172.1510602564231;
        Mon, 13 Nov 2017 11:49:24 -0800 (PST)
Received: from zaya.teonanacatl.net (pool-173-67-181-41.hrbgpa.fios.verizon.net. [173.67.181.41])
        by smtp.gmail.com with ESMTPSA id o95sm11276729qte.15.2017.11.13.11.49.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 13 Nov 2017 11:49:23 -0800 (PST)
Date:   Mon, 13 Nov 2017 14:49:21 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH/RFC] Replace Free Software Foundation address in license
 notices
Message-ID: <20171113194921.GP5144@zaya.teonanacatl.net>
References: <20171107053933.23370-1-tmz@pobox.com>
 <xmqqmv3wjd66.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqmv3wjd66.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> This change probably makes sense.  From here on after applying the 
> patch, we won't have to worry about updating these every time they 
> move---not that they have moved often, though ;-)

Indeed.  It's thankfully a rare move.  I imagine that's why it's 
somewhat common to find license text with the previous address long 
after the last move.  (That and how boring licensing details are, in 
general.)

>>  compat/obstack.c                                                | 5 ++--- 
>>  ... 
>>  ewah/ewok_rlw.h                                                 | 3 +-- 
>>  git-gui/git-gui.sh                                              | 3 +-- 
>>  imap-send.c                                                     | 3 +-- 
>>  ... 
>>  44 files changed, 69 insertions(+), 103 deletions(-)
>
> I've tried hard to keep the git-gui/ part as a separate project (it 
> indeed is managed separately).  I have been, and am still only 
> pulling from its "upstream" repository (Pat, who is its project 
> lead, Cc'ed), refaining from making changes that do not exist there 
> at git://repo.or.cz/git-gui.git/ to the tree I publish.
>
> I'll separate the part from this patch that touches git-gui/* and 
> try to arrange the next pull from git-gui repository would have the 
> omitted part somehow.  Given that the "upstream" seems to be inactive 
> these days, we might want to change the way we manage that part of 
> the tree, though.

D'oh, I should have known that.  Thanks for splitting this up.  I was 
worried more minor things like legal details or changing code that we 
synced from another project (compat/regex or xdiff) might require some 
changes and didn't think enough about git-gui being separate.

> Thanks.

Thank you too.  It's always impressive to see how well you wear the 
maintainer hat. :)

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
A common mistake people make when trying to design something
completely foolproof is to underestimate the ingenuity of complete
fools.
    -- Douglas Adams

