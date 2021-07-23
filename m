Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E05C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 19:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0672560E52
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 19:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbhGWSeM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 14:34:12 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:60497 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229461AbhGWSeL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 14:34:11 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1m70d8-0007Hd-D8; Fri, 23 Jul 2021 20:14:42 +0100
Subject: Re: [PATCH 7/7] fast-forward: add help about merge vs. rebase
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "Randall S . Becker" <rsbecker@nexbridge.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Denton Liu <liu.denton@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20210722000854.1899129-1-felipe.contreras@gmail.com>
 <20210722000854.1899129-8-felipe.contreras@gmail.com>
 <76d59e73-ae5d-3bef-4aa3-5d1af9611577@iee.email>
 <60faf81658201_defb208d4@natae.notmuch>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <b5cdd34b-c50e-f6f4-4462-c869836d309d@iee.email>
Date:   Fri, 23 Jul 2021 20:14:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <60faf81658201_defb208d4@natae.notmuch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/07/2021 18:10, Felipe Contreras wrote:
>> It is good to have diagrams for the visual learners!
> Actually, it seems there's no such thing as "visual learners" [1]; we
> are all visual learners.
>
> Cheers.
>
>>> +    D---C---B---A---M master
>>> +	 \	   /
>>> +	  X---Y---+
>>> +------------
> [1] https://www.theatlantic.com/science/archive/2018/04/the-myth-of-learning-styles/557687/
It's a double myth, in that many try to suggest that a person has a
single style (untrue), or that a single style is relevant in a
particular context, when it should be that sometime individuals fail to
learn (a particular item) when not provided with a particular style that
would suit them in the moment. I.e the removal of a particular format
(e.g. no visuals) will reduce the effectiveness of the manual (excepting
the 'The pictures are better on radio' aphorism ;-).

Philip
