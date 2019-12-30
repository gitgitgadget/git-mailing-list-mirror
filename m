Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D47FC2D0C2
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 19:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A2B7206CB
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 19:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfL3TQH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 14:16:07 -0500
Received: from smtprelay04.ispgateway.de ([80.67.31.32]:9559 "EHLO
        smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfL3TQG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 14:16:06 -0500
Received: from [24.134.116.61] (helo=[192.168.92.208])
        by smtprelay04.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1im0WJ-0006Ri-BL; Mon, 30 Dec 2019 20:16:03 +0100
Subject: Re: [PATCH 2/3] t: directly test parse_pathspec_file()
To:     Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.503.git.1577727747.gitgitgadget@gmail.com>
 <27383a5b084b5e68152b08eb96fb4ddaf6d87f82.1577727747.git.gitgitgadget@gmail.com>
 <xmqq8smthcib.fsf@gitster-ct.c.googlers.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <97224460-c432-960a-0324-ea4f64f7c082@syntevo.com>
Date:   Mon, 30 Dec 2019 20:16:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <xmqq8smthcib.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for having a look! I think I have fixed all mentioned issues in V2.
