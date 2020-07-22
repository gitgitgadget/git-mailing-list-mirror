Return-Path: <SRS0=ybwr=BB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C53CC433DF
	for <git@archiver.kernel.org>; Wed, 22 Jul 2020 05:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FFA520771
	for <git@archiver.kernel.org>; Wed, 22 Jul 2020 05:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgGVFuK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 01:50:10 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:8902 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726696AbgGVFuK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jul 2020 01:50:10 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4BBPgj2Rq4z5tlB;
        Wed, 22 Jul 2020 07:50:09 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 768262082;
        Wed, 22 Jul 2020 07:50:08 +0200 (CEST)
Subject: Re: Improving merge of tricky conflicts
To:     "B. Stebler" <bono.stebler@gmail.com>
References: <a0418859-c62e-c207-a1b0-1b1aaf178527@gmail.com>
Cc:     git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <4df975f0-e4b1-afa1-cac1-f38e6d31a0d8@kdbg.org>
Date:   Wed, 22 Jul 2020 07:50:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a0418859-c62e-c207-a1b0-1b1aaf178527@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.07.20 um 01:29 schrieb B. Stebler:
> I have been looking for a tool to display merge conflicts, that instead
> of showing the two versions of the conflicting section, would show the
> diff for that section in both conflicting commits.

Perhaps you want to configure `merge.conflictStyle=diff3`? It does not
exactly show a diff, but it writes the base version of the conflicted
part in addition to "ours" and "theirs".

-- Hannes
