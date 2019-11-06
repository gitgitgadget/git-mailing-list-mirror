Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95A4C1F454
	for <e@80x24.org>; Wed,  6 Nov 2019 15:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732145AbfKFP44 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 10:56:56 -0500
Received: from smtprelay08.ispgateway.de ([134.119.228.111]:53589 "EHLO
        smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727312AbfKFP44 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 10:56:56 -0500
Received: from [24.134.116.61] (helo=[192.168.92.208])
        by smtprelay08.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1iSNfz-0000ND-9a; Wed, 06 Nov 2019 16:56:55 +0100
Subject: Re: [PATCH 4/5] doc: commit: unify <pathspec> description
To:     Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.445.git.1572895605.gitgitgadget@gmail.com>
 <251d06e27f6bc93b190450ae6e1087a3126b5e52.1572895605.git.gitgitgadget@gmail.com>
 <xmqq8sotvcar.fsf@gitster-ct.c.googlers.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <6cd64094-d229-ef96-86fd-e64accd759d4@syntevo.com>
Date:   Wed, 6 Nov 2019 16:56:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <xmqq8sotvcar.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think I have implemented most suggestions in PatchV2. Thanks!

> I am not sure if we want to repeat this all over the place.
> 
> We do not say "For details about the <commit> syntax, see the
> 'SPECIFYING REVISIONS' section of linkgit:git-rev-parse[1]" for
> every command that takes <commit> from the command line.
> 
> Is your urge to suggest adding this sentence coming from that you
> are much more familiar with <commit> than <pathspec>?  In other
> words, if you were more familiar with Git, would you still be adding
> this (and not corresponding one for <commit>)?

Commit is a well known term, dating from ancient times like CVS or even 
older.

Pathspec, however, is something new. When I pretend to be someone new to 
git, I see it this way:
1) Let's read "git commit" documentation
2) Where on this commandline do I put my filename?!

So yes, I would repeat it in every location that could be popular for 
new users.
