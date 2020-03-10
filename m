Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68359C10F27
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 17:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44EDC21927
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 17:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgCJRfR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 13:35:17 -0400
Received: from smtprelay03.ispgateway.de ([80.67.31.26]:62995 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgCJRfR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Mar 2020 13:35:17 -0400
Received: from [24.134.116.61] (helo=[192.168.92.208])
        by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1jBimg-0007uN-KZ; Tue, 10 Mar 2020 18:35:14 +0100
Subject: Re: git-core: try_to_follow_renames(): git killed by SIGSEGV
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Ondrej Pohorelsky <opohorel@redhat.com>, git@vger.kernel.org
References: <CA+B51BFFvn9puia8+kheeWkDfOQ7RYHTcGa74M5aeiTd8-QJXA@mail.gmail.com>
 <3c722d21-ee57-7d20-81fb-0399f02f1bc7@syntevo.com>
 <20200310165723.GB3122@szeder.dev>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <28747ec8-0049-b459-0100-420252ca0225@syntevo.com>
Date:   Tue, 10 Mar 2020 18:35:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310165723.GB3122@szeder.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10.03.2020 17:57, SZEDER Gábor wrote:
> Don't do this.  In particular:

To clarify, I don't do this, I merely investigated a crash report from 
someone else. The reporter (Ondrej) seems to be a crash db maintainer, 
so he also doesn't do this. Finally, the user behind the report also 
doesn't do this, as he merely uses VS Code. Therefore, "don't do" part 
is in fact addressed at VS Code.

 > This should have errored out since the beginning

To me it sounds like a perfect plan to avoid the crash.
