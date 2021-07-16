Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA0EC636CA
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 18:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE9C2613FD
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 18:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbhGPSPK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 14:15:10 -0400
Received: from smtprelay06.ispgateway.de ([80.67.31.101]:42072 "EHLO
        smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhGPSPJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 14:15:09 -0400
Received: from [84.163.66.66] (helo=[192.168.2.202])
        by smtprelay06.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <git@mfriebe.de>)
        id 1m4SIY-0001zA-MA; Fri, 16 Jul 2021 20:10:54 +0200
Subject: Re: PATCH: improve git switch documentation
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
 <65362688-b65b-661c-20c1-94d7dc2118c7@mfriebe.de>
 <60e874e1c6845_215320861@natae.notmuch>
 <dbfa96f0-558e-ccaf-6e34-6d95c43848b5@mfriebe.de>
 <60e88a4b8592f_16bcb2082b@natae.notmuch>
 <ad58bd54-a9dd-59a9-4fce-f90be469cd60@mfriebe.de>
 <60e9f8d462bd9_7ef20898@natae.notmuch>
 <6f43b36b-abe1-41f2-6138-e820c974b1bd@mfriebe.de>
 <60ea07e3495e8_7ef2081d@natae.notmuch>
 <30e4c874-6b87-b03d-fa33-fde5b7e50b2a@mfriebe.de>
 <60ea2eb562f26_2a69208e8@natae.notmuch>
 <1e18c4ed-6975-5041-4b4f-75c4d3d21860@mfriebe.de>
 <60ec6d91deced_a452520825@natae.notmuch>
 <54644739-2138-8086-1696-d3c52960216c@mfriebe.de>
 <60ec74c513b2b_a45252081b@natae.notmuch>
 <0d7bd249-2aba-236a-9f93-3a5b30182d15@mfriebe.de>
 <60ec93155663f_a231f208fb@natae.notmuch>
 <3a84e4c9-4e48-1cbe-4fe6-150ff56c8508@mfriebe.de>
 <60ecbe577a086_a6b702082@natae.notmuch>
 <d3678ef6-1bcd-2666-87dc-751aef2ca1a7@mfriebe.de>
 <60edb8ff814cf_ab6dd208d9@natae.notmuch>
From:   Martin <git@mfriebe.de>
Message-ID: <d264e1b6-dde4-025f-c137-86345ba55d4e@mfriebe.de>
Date:   Fri, 16 Jul 2021 20:12:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <60edb8ff814cf_ab6dd208d9@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWVAbWZyaWViZS5kZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/07/2021 18:02, Felipe Contreras wrote:
> Martin wrote:
>> Of course now, that they had no need to think about any commits, an no
>> warning that would have prompted that, they believe "-C" to be save.
> 
> Why would they think -C "saves"? And save how?
> 
Sorry, spelling.

"safe"

