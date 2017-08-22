Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07FB71F667
	for <e@80x24.org>; Tue, 22 Aug 2017 22:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752533AbdHVWyJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 18:54:09 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36726 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751643AbdHVWyI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 18:54:08 -0400
Received: by mail-pf0-f195.google.com with SMTP id c15so87880pfm.3
        for <git@vger.kernel.org>; Tue, 22 Aug 2017 15:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YLI790H9B7UzmD2x0l1OSy2Qdv4supyeUgjbMprDrkg=;
        b=Co9tN8Hg9AwOqkON0EfO6tr4+QATWODhPpJj5/bMEdMgi1qZLYhlU8QhL3iBJ1GA88
         NFmMijDpjJSY2SSkENZ0eL3VwvYqPFaUD+yooN2p/7d64N18RRiFLFQ91XcA98MalOVO
         7PV2z3FR0X5CoGjPgyK9zII7VjSL/AjRaM4R7yfLKDVQbvV+Jg0yJq9E/PJ0bnNBAG2a
         WoIgzDoRFGRH/zpBhmb0zquQ7/IMkUbD9+ADKU9CXa9L7vc8Ok4Mb73tmD/5NnHq2s+j
         nK7CEJPwR5S2XbN5oxIZiGDBvHmxavjA/qLXsTgf4foUarCDZIglTIXrkRhq5Bq8bQeP
         hOnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YLI790H9B7UzmD2x0l1OSy2Qdv4supyeUgjbMprDrkg=;
        b=UsZzRL/dtcbSFja2v8Bt24zyhRov/Sf81ZMGMMC3nkIsJ9v5mGrk27VAQjoz70JwEe
         Z5IMXBDqi2MHO/M2TzOJvDG/xgOcN0iOXitnJ2wvFJsJCgFFQre/UGp6SjnlgI+La/CX
         w5+aivPTSOeZvQftNkGdJcVioU/PMSokCUkPDYRGvo5Bj5foUZuf1txqrUME6u1WC+SG
         NruZSthMdbOzEi94btfixgKgpKt1wyVbiCpsl+FZ/EdAaUE0TFA5KbkC1/AE7ngReZuv
         E/RqDcSPhNngmlHuYb5k5omt5nGEvFoDUZ05H3UvYK4P5jPARlH5LyOE+CpaGGCehIWg
         URBQ==
X-Gm-Message-State: AHYfb5gZPqOsXlhOl84KWv6llxmuKKRiq0P/Gmacql+EVkqJP3NSCcJ0
        RfG0AOFYZqZYkQ==
X-Received: by 10.84.132.73 with SMTP id 67mr727570ple.53.1503442448362;
        Tue, 22 Aug 2017 15:54:08 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:dc68:f470:52d1:2c63])
        by smtp.gmail.com with ESMTPSA id u4sm70379pgn.74.2017.08.22.15.54.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 22 Aug 2017 15:54:07 -0700 (PDT)
Date:   Tue, 22 Aug 2017 15:54:05 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] vcs-svn/repo_tree.h: remove repo_init declaration
Message-ID: <20170822225405.GV13924@aiede.mtv.corp.google.com>
References: <20170822213501.5928-1-sbeller@google.com>
 <xmqqmv6r1c26.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmv6r1c26.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Stefan Beller <sbeller@google.com> writes:

>> The svn specific declaration of repo_init was not used since 723b7a2789
>> (vcs-svn: eliminate repo_tree structure, 2010-12-10).
>>
>> This was noticed when including repository.h via cache.h as that has the
>> same function with a different signature.
>>
>> Helped-by: Jonathan Nieder <jrnieder@gmail.com>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>
> It looks to me that this is a reduced duplicate of what brian posted
> yesterday.  The first two patches in the 6-patch series that you
> commented on, I think, covers what this change wants to achieve and
> probably a lot more.  I've merged those two already to 'next' and
> was about to push the result out.

Thanks for the pointer. I believe you're referring to
https://public-inbox.org/git/20170821000022.26729-2-sandals@crustytoothpaste.net/.

From Stefan's verbal report I was about to send a patch just like
Brian's plus some more patches on top to get rid of the rest of repo_tree.h.
I can build on top of Brian's patch if that's more convenient.

Regards,
Jonathan
