Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C643D1F454
	for <e@80x24.org>; Wed,  6 Nov 2019 15:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731909AbfKFP4k (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 10:56:40 -0500
Received: from smtprelay07.ispgateway.de ([134.119.228.101]:47109 "EHLO
        smtprelay07.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727312AbfKFP4k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 10:56:40 -0500
Received: from [24.134.116.61] (helo=[192.168.92.208])
        by smtprelay07.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1iSNfg-0007ko-1C; Wed, 06 Nov 2019 16:56:36 +0100
Subject: Re: [PATCH 2/5] doc: reset: unify <pathspec> description
To:     Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.445.git.1572895605.gitgitgadget@gmail.com>
 <1740ac7a291cfc81418c2d437201c3373487fa26.1572895605.git.gitgitgadget@gmail.com>
 <xmqqh83hveiz.fsf@gitster-ct.c.googlers.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <b7acd8d1-d17a-29bd-44d3-59d425842c10@syntevo.com>
Date:   Wed, 6 Nov 2019 16:56:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqh83hveiz.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think I have implemented most suggestions in PatchV2. Thanks!

> Any time I see "... X. This means Y." either in the doc or in the
> proposed log message, I wish the author (not you in this case,
> obviously) thought twice about rewriting so that they do not say one
> thing and immediately have to rephrase it, i.e. either just say Y
> without saying X, or saying X more clearly without having to say Y.
> 
> In this case, however, I think X and Y are related but both relevant.
> The subcommand resets the index entries for chosen paths to match
> what is in the tree-ish, which is the same as restoring from a tree
> to the index.
> 
> It is not quite the opposite of adding to the index from the working
> tree.  In this sequence:
> 
> 	$ edit newfile
> 	$ git add newfile
> 
> and then further
> 
> 	$ edit newfile
> 	$ git add newfile
> 	$ git reset -- newfile
> 
> we are taken back to the state _before_ any of the changes made to
> newfile (in fact, since HEAD does not have newfile, the resulting
> index would not know about it, either).

I am a bit confused, is it correct that you don't expect me to change my 
patches?
