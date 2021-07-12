Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F364C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 16:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EE7360200
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 16:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbhGLQmN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 12:42:13 -0400
Received: from smtprelay01.ispgateway.de ([80.67.31.28]:56825 "EHLO
        smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbhGLQmM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 12:42:12 -0400
Received: from [79.233.237.92] (helo=[192.168.2.202])
        by smtprelay01.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <git@mfriebe.de>)
        id 1m2yxx-0005YR-0X; Mon, 12 Jul 2021 18:39:33 +0200
Subject: Re: PATCH: improve git switch documentation
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
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
 <65362688-b65b-661c-20c1-94d7dc2118c7@mfriebe.de>
 <60e874e1c6845_215320861@natae.notmuch>
 <dbfa96f0-558e-ccaf-6e34-6d95c43848b5@mfriebe.de>
 <87im1ieaba.fsf@osv.gnss.ru>
 <1bd36aa2-ac90-f7d4-9d48-1aa39159b263@mfriebe.de>
 <87a6mudt9b.fsf@osv.gnss.ru> <60e9ff4430c57_7ef20815@natae.notmuch>
 <874kd1gr0q.fsf@osv.gnss.ru> <60ec6cd622c4c_a4525208a0@natae.notmuch>
From:   Martin <git@mfriebe.de>
Message-ID: <f0770358-be4c-a747-0851-b2fd73c1978e@mfriebe.de>
Date:   Mon, 12 Jul 2021 18:39:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <60ec6cd622c4c_a4525208a0@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWVAbWZyaWViZS5kZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/07/2021 18:24, Felipe Contreras wrote:
> Sergey Organov wrote:
> Even standardizing `git branch` would be an almost-impossible task, even
> if we manage to convince others. `git new branch` even more impossible.
> 

Not sure but from the glance at hg that I took, they seem to use the 
plural for nouns.

So then we could have

   git branch <new-branch-name>

   git branches new   // long version
   git branches list
   git branches delete
   ....

However, standardizing to a fixed verb/noun rule will still be more than 
a challenge.

The above would as guildeline be

   git verb
or
   git plural-noun verb

Yet try to do that with
   git status
   git log

I don't see how a better alternative for those can be found. One that 
actually is accepted because it's better, not just because it follows a 
rule.

status, is not a verb
log is the wrong verb, or again a noun.



