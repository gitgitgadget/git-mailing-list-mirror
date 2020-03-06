Return-Path: <SRS0=QY2u=4X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DB8C10DCE
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 23:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 245BD206CC
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 23:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgCFXGJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Mar 2020 18:06:09 -0500
Received: from smtprelay01.ispgateway.de ([80.67.31.39]:43583 "EHLO
        smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbgCFXGJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Mar 2020 18:06:09 -0500
Received: from [84.175.189.84] (helo=[192.168.2.6])
        by smtprelay01.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1jAM2f-00028l-07; Sat, 07 Mar 2020 00:06:05 +0100
Subject: Re: [PATCH 4/4] get_superproject_working_tree(): return strbuf
To:     Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.575.git.1583521396.gitgitgadget@gmail.com>
 <2eeefda3d41e6af1bc61249daf14b42050f0d0c3.1583521397.git.gitgitgadget@gmail.com>
 <xmqqv9nh14u0.fsf@gitster-ct.c.googlers.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <664d6312-0189-8646-3d73-d6869c6a6806@syntevo.com>
Date:   Sat, 7 Mar 2020 00:06:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <xmqqv9nh14u0.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06.03.2020 23:44, Junio C Hamano wrote:
> Micronit.
> 
> The asterisk sticks to the identifier, not type, in our codebase.
> I.e. "struct strbuf *buf".

Sorry, having difficulties switching between many different styles.
Will fix in V2 next week.


Thank you very much for giving such a quick response! It is a great 
pleasure when my patches get movement instead of just gathering dust 
like in some other opensource projects :(
