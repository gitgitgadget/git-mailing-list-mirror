Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E03C07E95
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 21:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90C00613FB
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 21:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhGBVd5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 17:33:57 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:9883 "EHLO
        smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhGBVd5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 17:33:57 -0400
Received: from [84.163.67.238] (helo=[192.168.2.202])
        by smtprelay01.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <test2@mfriebe.de>)
        id 1lzQkv-0006zR-2q; Fri, 02 Jul 2021 23:31:25 +0200
Subject: Re: [PATCH 5/5] config: add default aliases
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20210702100506.1422429-1-felipe.contreras@gmail.com>
 <20210702100506.1422429-6-felipe.contreras@gmail.com>
 <871r8hauvi.fsf@igel.home> <60dee7d4e27bf_2964b20817@natae.notmuch>
 <65b1d215-c3ab-e0e3-f4ac-a30131541f9b@mfriebe.de>
 <60def07e686c7_7442083a@natae.notmuch>
 <3e82a574-fdcc-08b8-8fb5-1ff15f8ae564@mfriebe.de>
 <60df813938303_28bb208c8@natae.notmuch>
From:   martin <test2@mfriebe.de>
Message-ID: <cb40e459-7862-b917-b4bb-7bd6f929adef@mfriebe.de>
Date:   Fri, 2 Jul 2021 23:31:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <60df813938303_28bb208c8@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Df-Sender: bWVAbWZyaWViZS5kZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/07/2021 23:12, Felipe Contreras wrote:
> I know, but it comes from CVS.
>
> In both CVS and Subversion "commit" pushes a commit, so it can be seen
> as the opposite of "checkout", which pulls a commit.
>
> That's not the case in git.
>
>> But of course other letters can be picked. I don't see an advantage in
>> it though.
> The advantage is that it's straightforward: co -> commit.

But it is not that different between git and svn/cvs

svn/cvs both store/restore from the repository. That happens to be on 
the server.
git  store/restore from the repository. That happens to be local. (the 
remote is optional in git)


That, said, it is ok to break with the old patterns. Otherwise 
innovation can't happen.
But, plenty of users have old habits, and those die hard.
If the new aliases should help people, then those used to other meanings 
of the same alias may not think of it as that much help.

Also, git has plenty more commands than other vcs. Even if not all of 
them will be aliased, people will expect different sub sets of them in 
the list of those with alias.
Maybe 3 letter aliases will be less controversial
git com
git cho (checkout if needs must)
git rst  restore
git swt  switch


