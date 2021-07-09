Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20472C07E99
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 16:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1A9D613BF
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 16:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbhGIQ4w (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 12:56:52 -0400
Received: from smtprelay01.ispgateway.de ([80.67.29.23]:8032 "EHLO
        smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhGIQ4v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 12:56:51 -0400
X-Greylist: delayed 63726 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Jul 2021 12:56:51 EDT
Received: from [84.163.73.96] (helo=[192.168.2.202])
        by smtprelay01.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <git@mfriebe.de>)
        id 1m1tlX-0002Tr-DE; Fri, 09 Jul 2021 18:54:15 +0200
Subject: Re: switch requires --detach [[Re: What actually is a branch]]
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
 <b667ca37-b3cb-fce2-a298-63c3b839089d@mfriebe.de>
 <xmqqpmw4uwh2.fsf@gitster.g>
 <7870a0ad-8fa1-9dbd-1978-1f44ec6970c5@mfriebe.de>
 <xmqqy2arrmba.fsf@gitster.g>
 <b80bf908-0c31-2b3a-6d6c-1a3fba5b2334@mfriebe.de>
 <87wnqaclz8.fsf@osv.gnss.ru> <60e5f3981de5f_301437208bc@natae.notmuch>
 <87bl7d3l8r.fsf@osv.gnss.ru> <60e61bbd7a37d_3030aa2081a@natae.notmuch>
 <877di13hhe.fsf@osv.gnss.ru>
 <c740a4f0-011f-762e-4f49-f85d1b3abc99@mfriebe.de>
 <60e67389a4adc_306ac1208fd@natae.notmuch>
 <4057b3ac-a77c-0d5f-d3f4-ad781754aae4@mfriebe.de>
 <60e736e72da68_30939020850@natae.notmuch>
 <155308af-42ad-b044-fb37-676251a9b7e1@mfriebe.de>
 <60e762243aab1_30a7b02089@natae.notmuch>
 <2b85a7eb-d0be-65e7-ecbb-1750abf53e53@mfriebe.de>
 <60e79c31aaa72_30b8a4208c1@natae.notmuch>
 <084a355e-95cd-5c84-2fa5-a901da3e0e49@mfriebe.de>
 <60e8666c8707f_2153208c0@natae.notmuch>
 <57f316cb-850d-706a-592b-4376f240e032@mfriebe.de>
 <60e8776cdc455_215320852@natae.notmuch>
From:   Martin <git@mfriebe.de>
Message-ID: <7cb0e152-2ef2-a226-2dbb-f32d19378792@mfriebe.de>
Date:   Fri, 9 Jul 2021 18:54:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <60e8776cdc455_215320852@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWVAbWZyaWViZS5kZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/07/2021 18:21, Felipe Contreras wrote:
> Martin wrote:
>> - add --allow-detach  and git config switch.detach allow ?
> 
> That's a good option, but another one would be to have a core.advanced
> mode, you turn it on if you are an advanced user.

+1

