Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 981331F731
	for <e@80x24.org>; Thu,  1 Aug 2019 20:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732102AbfHAUvH (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 16:51:07 -0400
Received: from smtprelay08.ispgateway.de ([134.119.228.109]:21153 "EHLO
        smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728669AbfHAUvH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 16:51:07 -0400
Received: from [87.165.16.84] (helo=[192.168.2.6])
        by smtprelay08.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1htI2R-00017h-3G; Thu, 01 Aug 2019 22:51:03 +0200
Subject: Re: Support for --stdin-paths in commit, add, etc
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
References: <a38bc928-7ccd-e2d9-b89b-23298e9fa95d@syntevo.com>
 <066cfd61-9700-e154-042f-fc9cffbd6346@web.de>
 <xmqqef24op5q.fsf@gitster-ct.c.googlers.com>
 <a6610e94-6318-b962-5dd0-ca379def3bba@syntevo.com>
 <xmqqimrgmx6k.fsf@gitster-ct.c.googlers.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <f35fe280-2e26-f719-4030-faf261bc9a22@syntevo.com>
Date:   Thu, 1 Aug 2019 22:51:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqimrgmx6k.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01.08.2019 22:45, Junio C Hamano wrote:
> That does not mean that any patch along that line will automatically
> be accepted, of course, so the answer to "am I ready to accept"
> question is a definite no.  No, I am not ready---we will have to
> look at the actual patches before deciding.

That's why I previously mentioned "good enough" patches :)

Thanks for your time! I guess we'll start with a patch for 'git commit'
and see how it goes.
