Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,BODY_URI_ONLY,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2CF81F576
	for <e@80x24.org>; Wed, 31 Jan 2018 10:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753656AbeAaKEM (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 05:04:12 -0500
Received: from smtpq1.mnd.mail.iss.as9143.net ([212.54.34.164]:36810 "EHLO
        smtpq1.mnd.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753637AbeAaKEH (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 31 Jan 2018 05:04:07 -0500
Received: from [212.54.34.118] (helo=smtp10.mnd.mail.iss.as9143.net)
        by smtpq1.mnd.mail.iss.as9143.net with esmtp (Exim 4.86_2)
        (envelope-from <git@jessiehernandez.com>)
        id 1egpFO-0000Wp-8d
        for git@vger.kernel.org; Wed, 31 Jan 2018 11:04:06 +0100
Received: from 53544873.cm-6-5b.dynamic.ziggo.nl ([83.84.72.115] helo=jessiehernandez.com)
        by smtp10.mnd.mail.iss.as9143.net with esmtp (Exim 4.86_2)
        (envelope-from <git@jessiehernandez.com>)
        id 1egpFO-0005EF-7C
        for git@vger.kernel.org; Wed, 31 Jan 2018 11:04:06 +0100
Received: by jessiehernandez.com (Postfix, from userid 112)
        id 13BEA224EF; Wed, 31 Jan 2018 11:04:06 +0100 (CET)
Received: from mail.jessiehernandez.com (localhost [127.0.0.1])
        by jessiehernandez.com (Postfix) with ESMTP id 47C30224E9;
        Wed, 31 Jan 2018 11:03:42 +0100 (CET)
Received: from 185.46.212.85
        (SquirrelMail authenticated user pi)
        by mail.jessiehernandez.com with HTTP;
        Wed, 31 Jan 2018 11:03:43 +0100
Message-ID: <cb45d936ebc51f852ec50baf9d5e89a3.squirrel@mail.jessiehernandez.com>
In-Reply-To: <CAPig+cRiyterpyJfayVmA5Ra_zzyVp6GGSNqe2Tx-Hrrif+U8A@mail.gmail.com>
References: <615c04025165d0dff9d6e6b66bf11a41.squirrel@mail.jessiehernandez.com>
    <CAPig+cRiyterpyJfayVmA5Ra_zzyVp6GGSNqe2Tx-Hrrif+U8A@mail.gmail.com>
Date:   Wed, 31 Jan 2018 11:03:43 +0100
Subject: Re: Creating sparse checkout in a new linked git worktree
From:   "Jessie Hernandez" <git@jessiehernandez.com>
To:     "Eric Sunshine" <sunshine@sunshineco.com>
Cc:     git@jessiehernandez.co, git@jessiehernandez.com,
        "Git List" <git@vger.kernel.org>
Reply-To: git@jessiehernandez.co
User-Agent: SquirrelMail/1.4.23 [SVN]
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-SourceIP: 83.84.72.115
X-Ziggo-spambar: /
X-Ziggo-spamscore: 0.0
X-Ziggo-spamreport: CMAE Analysis: v=2.3 cv=DLmhHRFb c=1 sm=1 tr=0 a=n+ob1Bm1t1G9OO4azozuvA==:17 a=8nJEP1OIZ-IA:10 a=RgaUWeydRksA:10 a=CdBCPKDxAAAA:8 a=QPbZCRsIvT8yICgZPaIA:9 a=wPNLvfGTeEIA:10 a=lDjxF1AZmdN7bNtopFhl:22
 none
X-Ziggo-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Tue, Jan 30, 2018 at 9:25 AM, Jessie Hernandez
> <git@jessiehernandez.com> wrote:
>>> The sparse-checkout file is specific to each worktree, which allows you
>> to control "sparsity" on a worktree by worktree basis. Therefore, you
>> should create $GIT_DIR/worktrees/<id>/info/sparse-checkout instead
>> (where <id> is "new-branch" in your example).
>>
>> Would it help if this was added to the documentation of git-read-tree
>
> It probably would. Would you be interested in submitting a patch
> (mentioning 'git rev-parse --git-path info/sparse-checkout', as
> suggested by Duy)?
>
Sure. I will give it a try.

