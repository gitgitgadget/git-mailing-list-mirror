Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D90C4D2E8
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0EE22479F
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbfLMUNM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 15:13:12 -0500
Received: from smtprelay01.ispgateway.de ([80.67.31.28]:20619 "EHLO
        smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728950AbfLMUNM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 15:13:12 -0500
Received: from [84.131.47.212] (helo=[192.168.2.6])
        by smtprelay01.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1ifrJE-00052G-QQ; Fri, 13 Dec 2019 21:13:08 +0100
Subject: Re: [PATCH v3] grep: support the --pathspec-from-file option
To:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20191213041254.13202-1-emilyshaffer@google.com>
 <xmqqpngskrpd.fsf@gitster-ct.c.googlers.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <52cf5a3b-09e4-f4d2-a5d0-36b6ddc442f6@syntevo.com>
Date:   Fri, 13 Dec 2019 21:13:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqpngskrpd.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13.12.2019 19:26, Junio C Hamano wrote:

> Hmph.  This has nothing to do with "--pathspec-from-file" that was
> advertised on the title of the patch.  It used to be that
> 
> 	git grep -f one -f two
> 
> can be used to read patterns from two sources, but that is no
> longer possible, is it?  Am I missing a larger benefit to accept
> this regression?

Ouch, that comes completely unexpected to me. It's good when someone 
experienced watches over :)
