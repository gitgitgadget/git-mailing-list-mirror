Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFE6D1F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 16:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731885AbeGMQ5f (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 12:57:35 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:47035 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729275AbeGMQ5f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 12:57:35 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 41Rz9Y1Bcxz5tlG;
        Fri, 13 Jul 2018 18:42:09 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id D63A51C9A;
        Fri, 13 Jul 2018 18:42:07 +0200 (CEST)
Subject: Re: [PATCH 0/3] rebase -r: support octopus merges
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>, gitgitgadget@gmail.com,
        git <git@vger.kernel.org>
References: <pull.8.git.gitgitgadget@gmail.com>
 <xmqqbmbd3cc3.fsf@gitster-ct.c.googlers.com>
 <CAGZ79kaYpw9t3kCvPnDiLc5z7cLFsVQv4XJDAff_T-bShEjPoQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.1807121450100.75@tvgsbejvaqbjf.bet>
 <xmqqlgagzah1.fsf@gitster-ct.c.googlers.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <8dbaefe4-778e-1e83-4beb-0261699cc483@kdbg.org>
Date:   Fri, 13 Jul 2018 18:42:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqlgagzah1.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.07.2018 um 18:26 schrieb Junio C Hamano:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> A much more meaningful measure would be: how many octopus merge commits
>> have been pushed to GitHub in the past two weeks. I don't think I have the
>> technical means to answer that question, though.
> 
> It does not mean that misusing a feature is a good thing and should
> be encouraged if many misguided people do so.

Just recently I had to rebuild the version of git-gui that comes with 
Git 2.18.0 before it was released:

https://github.com/j6t/git-gui-ng/commit/f07ae1d7f07b036d78a3d4706e6cb4102e623fb3

I think that an octopus merge is the right tool for the task. Am I 
misguided?

-- Hannes
