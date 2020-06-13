Return-Path: <SRS0=iF2w=72=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60CBC433DF
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 11:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D5EB207DD
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 11:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgFMLeA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Jun 2020 07:34:00 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:55985 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbgFMLeA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jun 2020 07:34:00 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 49kb8P0bvrz5tl9;
        Sat, 13 Jun 2020 13:33:56 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 2BF7D41AF;
        Sat, 13 Jun 2020 13:33:56 +0200 (CEST)
Subject: Re: Collaborative conflict resolution feature request
References: <BY5PR19MB3400EB9AD87DFE612AFD5CC390810@BY5PR19MB3400.namprd19.prod.outlook.com>
From:   Johannes Sixt <j6t@kdbg.org>
To:     "Curtin, Eric" <Eric.Curtin@dell.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "Geary, Niall" <Niall.Geary@dell.com>,
        "rowlands, scott" <Scott.Rowlands@dell.com>
Message-ID: <cd31ad3e-ab92-7b23-e27f-034ede094888@kdbg.org>
Date:   Sat, 13 Jun 2020 13:33:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <BY5PR19MB3400EB9AD87DFE612AFD5CC390810@BY5PR19MB3400.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.06.20 um 16:08 schrieb Curtin, Eric:
> Sometimes in our private git instance in the company I work for we
> merge branches that have been forked for months and there can be
> several or more people involved in the conflict resolution.
> 
> At the moment we have two options:
> 
> - One person, a branch manager, solves them by ringing people,
> holding meetings, using best judgement, etc.
> - Somebody solves the conflicts they are involved with, marks
> everything as resolved and pushes (leaving <<< ==== >>>> delimiters
> in for unsolved conflicts) for the next person to continue. This sort
> of works although you falsely mark everything as resolved, leaving
> merge tools useless and many broken, unbuildable commits around in
> the branch.

Third option: Do not merge the whole branch in one big do-it-all-at-once
merge. Instead, pick strategic commits in the history of the branch such
that, when you merge them one after the other, each has only conflicts
in one particular area or topic, and so can be solved in a reasonable
amount of time with reasonable resources.

-- Hannes
