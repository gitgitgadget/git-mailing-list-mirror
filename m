Return-Path: <SRS0=UYkv=ZZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A0AC432C0
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 17:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75E2B206EC
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 17:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfLCRGd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Dec 2019 12:06:33 -0500
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:54611 "EHLO
        smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfLCRGd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Dec 2019 12:06:33 -0500
Received: from [24.134.116.61] (helo=[192.168.92.208])
        by smtprelay02.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1icBd6-0005cv-Kn; Tue, 03 Dec 2019 18:06:28 +0100
Subject: Re: [PATCH v4 00/13] Add --pathspec-from-file option
To:     Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.445.v3.git.1574182135.gitgitgadget@gmail.com>
 <pull.445.v4.git.1575381738.gitgitgadget@gmail.com>
 <xmqqpnh55oxi.fsf@gitster-ct.c.googlers.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <e4165215-c0f0-8659-8abf-9e91be671e8b@syntevo.com>
Date:   Tue, 3 Dec 2019 18:06:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <xmqqpnh55oxi.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03.12.2019 17:55, Junio C Hamano wrote:

>> Changes from V3:
> 
> Yikes, perhaps our mails crossed or something?  I think the previous
> round is already in 'next'.
> 
> Let's wait and see they cook enough to graduate to 'master', and
> build a separate series on top to teach other commands the option
> using the facility introduced by the current series (which is the
> first 6 patches you sent here).

My intent is to support more commands, so I was working on other patches 
in the background. Today more patches were ready and I wasn't sure 
whether to submit another topic or continue the old one. After some 
thinking, I decided to continue the old one.

Apparently, I guessed wrong :) Roger: I will wait until the first part 
graduates to 'master', then submit more patches.

Please give me an advice: when the time comes, shall I prepare even more 
patches and submit a massive branch, or shall I submit today's remaining 
patches, then wait again? I imagine that massive branches are scary and 
will deter reviewers?
