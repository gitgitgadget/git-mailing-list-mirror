Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CC5C433E0
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 09:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4025E2222A
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 09:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbhAEJdf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 04:33:35 -0500
Received: from mail.netline.ch ([148.251.143.178]:33624 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727853AbhAEJde (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 04:33:34 -0500
Received: from localhost (localhost [127.0.0.1])
        by netline-mail3.netline.ch (Postfix) with ESMTP id 4CAF02A6042;
        Tue,  5 Jan 2021 10:32:52 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
        by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id N8tf2fy10dfq; Tue,  5 Jan 2021 10:32:51 +0100 (CET)
Received: from thor (24.99.2.85.dynamic.wline.res.cust.swisscom.ch [85.2.99.24])
        by netline-mail3.netline.ch (Postfix) with ESMTPSA id CE0F32A6016;
        Tue,  5 Jan 2021 10:32:51 +0100 (CET)
Received: from localhost ([::1])
        by thor with esmtp (Exim 4.94)
        (envelope-from <michel@daenzer.net>)
        id 1kwihu-002Weg-TP; Tue, 05 Jan 2021 10:32:50 +0100
From:   =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
To:     git@vger.kernel.org
Cc:     Daniel Stone <daniel@fooishbar.org>
References: <c22ba034-6d7d-866a-c6fb-d769d117eec4@daenzer.net>
Subject: Re: Bug report: git rebase ignores different context, resulting in
 subtle breakage
Message-ID: <34b425b5-0237-fb46-5613-e90346bd7114@daenzer.net>
Date:   Tue, 5 Jan 2021 10:32:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <c22ba034-6d7d-866a-c6fb-d769d117eec4@daenzer.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-12-14 3:37 p.m., Michel Dänzer wrote:
> 
> (Originally reported as a GitLab issue: 
> https://gitlab.com/gitlab-org/gitlab/-/issues/292754)
> 
> 
> All output below is from Debian git 2.29.2-1.
> 
> 
> The following branches of 
> https://gitlab.freedesktop.org/daenzer/mesa.git can be used to reproduce:
> 
> gitlab-issue-292754/pre-rebase (pre-rebase state)
> gitlab-issue-292754/base (new base)
> gitlab-issue-292754/bad-rebase (bad post-rebase state)

Does the lack of response mean this is considered not a bug?


-- 
Earthling Michel Dänzer               |               https://redhat.com
Libre software enthusiast             |             Mesa and X developer
