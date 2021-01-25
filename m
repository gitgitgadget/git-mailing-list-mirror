Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_05,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966A4C433DB
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 20:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FCD6217BA
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 20:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730001AbhAZE7r (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 23:59:47 -0500
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:42838 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729279AbhAYOLr (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 Jan 2021 09:11:47 -0500
X-Greylist: delayed 2611 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Jan 2021 09:11:38 EST
Received: from p5099125b.dip0.t-ipconnect.de ([80.153.18.91] helo=[192.168.100.43]); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1l41qk-0000TD-C4; Mon, 25 Jan 2021 14:24:10 +0100
Subject: Re: Can not rebase to first commit
To:     Eugen Konkov <kes-kes@yandex.ru>,
        Git Mailing List <git@vger.kernel.org>
References: <1327609829.20210125123816@yandex.ru>
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
Message-ID: <13e03215-76ad-ad8a-0da3-e18088f69416@virtuell-zuhause.de>
Date:   Mon, 25 Jan 2021 14:24:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <1327609829.20210125123816@yandex.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1611583907;7d003636;
X-HE-SMSGID: 1l41qk-0000TD-C4
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/25/2021 11:38 AM, Eugen Konkov wrote:
> I can not rebase to first commit.
> 
> This is how to reproduce:
> 
> kes@work ~/work/projects/general/Auth $ git tree
> * 67857d5 (HEAD -> dev) asdf
> * 1e99034 (local/dev) Initial commit
> kes@work ~/work/projects/general/Auth $ git rebase -i --autostash --rebase-merges 1e99034^
> fatal: invalid upstream '1e99034^'

See `git rebase --root` where the documentation says "This allows you to
rebase the root commit(s) on a branch.".

