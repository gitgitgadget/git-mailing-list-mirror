Return-Path: <SRS0=/qQH=ZU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D537C432C0
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 10:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB2DB216F4
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 10:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfK1KH4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Nov 2019 05:07:56 -0500
Received: from smtprelay03.ispgateway.de ([80.67.31.30]:25608 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbfK1KH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Nov 2019 05:07:56 -0500
Received: from [24.134.116.61] (helo=[192.168.92.208])
        by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1iaGiE-0000WL-9E; Thu, 28 Nov 2019 11:07:50 +0100
Subject: Re: [PATCH 1/1] contrib/buildsystems: fix Visual Studio Debug
 configuration
To:     Philip Oakley <philipoakley@iee.email>,
        Alexandr Miloslavskiy via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <pull.348.git.gitgitgadget@gmail.com>
 <525669b3b38ed57d6d4f188dfe0bb8fe10b63749.1569227313.git.gitgitgadget@gmail.com>
 <c89cc506-b515-b913-bb0a-353b04fe4210@iee.email>
 <8e7ff0b2-9f62-8ec6-5316-eb9cee25024e@syntevo.com>
 <70bc64f6-3513-2924-9ba0-0e38e0e9d308@iee.email>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <0b2124b5-6d40-08bb-6cc5-a8cef2b7a9b1@syntevo.com>
Date:   Thu, 28 Nov 2019 11:07:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <70bc64f6-3513-2924-9ba0-0e38e0e9d308@iee.email>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28.11.2019 1:34, Philip Oakley wrote:

> Hmm, 45 minutes of cloning and rebuild, but finally it compiled clean 
> (both Release and Debug)

I understand that the issue is resolved now.

Probably your old repo was missing the libraries for whatever reason 
(like antivirus deleting them, etc), but build script thought that 
dependencies are properly built, so didn't attempt to rebuild them.
