Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45F9D1F597
	for <e@80x24.org>; Thu, 26 Jul 2018 04:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbeGZFbU (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 01:31:20 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36751 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbeGZFbU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 01:31:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id h9-v6so265719wro.3
        for <git@vger.kernel.org>; Wed, 25 Jul 2018 21:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=eenHcei0K+QA91ASomYp+kogxxsOUB1F26DmSgTykhI=;
        b=sYdjg0MIveQV3QkoRRrX33tluVbaY0d3PmYBEbFrKOYWJBFWHPBOgM3Au5AA0nSVJS
         BKIKKQK+ZiT3LEsmqp94wo9upvVT+pDHyEJ6u0id2y9EgLOEbUY6qX3eLpjpyPdnTQsl
         o5WuO+XkjQNn7ZUAED3h5q/sjmadb9fYO01gDr13x3ez0XBJ0qyvjLyaeA+BKpsFOR31
         2wNx14b6vNZH8KDV+WLwxP313NTlqDrtH2wYjVdQqvGu4mVKmNRaEm6vLN20phDg8bfg
         k2BkI0OzbS+nNVJeTwMAbtOHJxGWaWLB27j5BANBPgqTXkCmNwY6VJmiPKxMrWYfTgro
         Hu0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=eenHcei0K+QA91ASomYp+kogxxsOUB1F26DmSgTykhI=;
        b=pbEkS1UzK19scUDkXO32izjRojb4XCrVr3MX2bpQd1cKpk+/qLf+uaJwl1qi5zESIh
         5Xx4RYhwclELwrh48y52VQQJVFOqXNiovH7TfTAHrnosPwcxnTBkJ87M1ZlaKr6JARPG
         sw1FCLntToAYqfW8X7JMnosHKObgzuUBsCSFq+l3bCCab7hcgZC3vxfOOjFT1b7Vlr36
         BRKftJWvVqCd0IlVZSkqQ8FBXkGpOwM9Xp0/TZuw4YPfRJWFpiplMTrSgMFT9GeF1xLC
         I1IDGLO7vL2YQtEX47MZ/PVsGRQPTS9jDJdkNi+v523BylOw5/VV9SW7b4vkEEiEdsZ8
         rSXg==
X-Gm-Message-State: AOUpUlHqKyufINvnLKJ8A5r9enoWKg+z8OzduQh6pPu6oKqSrO+vaRxt
        dHgfgtLofrbJXI0cWyt4+MY=
X-Google-Smtp-Source: AAOMgpdOQptEwA60LLcHQ66XvIG3BSrA8+I671dIYkAgpNzESxlsfqIeqiVUixCwgVeny5lhenAeAw==
X-Received: by 2002:a5d:6601:: with SMTP id n1-v6mr158774wru.281.1532578586917;
        Wed, 25 Jul 2018 21:16:26 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z13-v6sm454611wma.45.2018.07.25.21.16.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 21:16:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniel Baumann <mail@daniel-baumann.ch>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-rebase--interactive.sh: Remove superfluous tab in rebase
References: <db70d275-584e-3a3b-5201-dc04e4c5950b@daniel-baumann.ch>
        <87o9evbn6l.fsf@evledraar.gmail.com>
        <ed377eda-648a-23a5-c400-03602e007a05@daniel-baumann.ch>
Date:   Wed, 25 Jul 2018 21:16:25 -0700
In-Reply-To: <ed377eda-648a-23a5-c400-03602e007a05@daniel-baumann.ch> (Daniel
        Baumann's message of "Thu, 26 Jul 2018 04:21:19 +0200")
Message-ID: <xmqqin52skbq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniel Baumann <mail@daniel-baumann.ch> writes:

> On 07/25/2018 12:54 PM, Ævar Arnfjörð Bjarmason wrote:
>> The code you're modifying doesn't exist in the "pu" branch since
>> 249d626f2c
>
> indeed, thanks.
>
>> From looking at it it seems we no longer have this problem,
>> but perhaps you'd like to check that out for yourself?
> Yes, it's not needed anymore at all, yay!
>
> Sorry for the noise.

Thanks for reporting.  It is 100% better to see occasional
duplicates than nothing.
