Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25D5E20966
	for <e@80x24.org>; Fri,  7 Apr 2017 14:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933441AbdDGOAG (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 10:00:06 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:49202 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751759AbdDGOAE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 10:00:04 -0400
Received: from skimbleshanks.math.uni-hannover.de ([130.75.46.4]) by
 mrelayeu.kundenserver.de (mreue003 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 0M0e3W-1c6AUK0Hpm-00utWw; Fri, 07 Apr 2017 15:59:58 +0200
Subject: Re: [PATCH] Documentation/git-worktree: use working tree for trees on
 the file system
To:     Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <20170317222842.GP26789@aiede.mtv.corp.google.com>
 <20170317225110.13417-1-sbeller@google.com>
 <xmqq60j75psk.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kayeSxFTJr3Q1atFgOyR74PzQyCLiejuZxh7+wTGGb=ww@mail.gmail.com>
 <xmqqbmsvx1ey.fsf@gitster.mtv.corp.google.com>
 <20170320185038.GU26789@aiede.mtv.corp.google.com>
 <CACsJy8CBmfj8wY+LQzEshJT0Ya+nmAGs=K8b1Nyr3qinvCo4kA@mail.gmail.com>
 <xmqqvar2ska7.fsf@gitster.mtv.corp.google.com>
 <3c16aea8-be53-ef41-d43f-7b4e8ca15d7d@drmicha.warpmail.net>
 <xmqqd1d7ev2q.fsf@gitster.mtv.corp.google.com>
 <CACsJy8BNYmYarZqnERhsO8LDxdsMsviUMs3Co6C4Ed7W9OvDJQ@mail.gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
From:   Michael J Gruber <git@grubix.eu>
Message-ID: <ee8e8671-066b-311e-8cad-31a1ab22eec7@grubix.eu>
Date:   Fri, 7 Apr 2017 15:59:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8BNYmYarZqnERhsO8LDxdsMsviUMs3Co6C4Ed7W9OvDJQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:9lu5XZ93Ywy+Z3Wo3dbgTtKuK0B7kbCqxT/P6eQpJkywvVaReUN
 AgJU4FEm6Uv74YN0heNUvrblgfR/VnzKZh9b4nPmQXhawlBybpoGD6IdxDRdiDwnZ4bUHc2
 L6jY1sPCT8/XDEz501nU4pHn8QhVA4SPrp7s9+mOIvFRQECdbMQMp7D2iqvXswVK8oumkfA
 ZHEsLeZnIu+ca/E3OMWOg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QmFh45SKVh0=:dP6S8qVo34bFvp3a64XkbX
 zl36ZgMGa6xCExPFgD3BLCHRNvXNC8j29dj9mQLtaInxY7fLP7q2Cf7mgDlr5iUabr4UllN73
 4+CSeJXmlR5p0oRAi5whhd1ZnkBI8uanimJ1UkiEwbMwCPcgkbevP1H4tS2WU/8p84kOIlRT2
 RZHZA8kG3DAyfcenwRISIPLQLjzdZyHNo/x/HbgaCSskQ/4BV6YXy0agD/5EEMd4MdDwXU/bv
 xtP33oOm8IAlMCiLAj+UnDJuwFnOBUPk4m2fMWvbuumvo7xbp6yorkm97PV8aVtaM0TTPAQkA
 wcfvELVwigyiVxb6RRwNqbyj5Z4QNd98N+RFdxQwO1j1Qfjm7Y31n95WcHFeDoU4APj196EPE
 +cnSQoU4qBJOsB8aP78oNUlAotm79QD5dqxJ8VjZDQnGXHzv2lf7N+8HYlAPfnj7I6jAjxp5x
 XzSJJvkv/WBKI4RUAIqDx2e48pz+c7e8ezhMS+7CUypLrx034Fq4dEPU4W7teRhsxSln0azuO
 eMbRlgou4c9/4B0JE//vUjjJt8iuyOT1kyCPW09FSE10DjI80OV3mPx/w5ViagIR2Nj5x1wT0
 jBgodRMwMF3rs4nDcJADdVYOYD8pVSoew+D9+3tOpHDRw9gpGBbDDdhbnRzUHkV5ZKTEttzsn
 isXu7MbaHyvmypwKY42LfQUYTk1unAmGi8WamyDLy7vcRXAo7Jtn4A3N/0yFne3SEntBTlIrs
 d1Y8O2ObVaiD8Sdh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen venit, vidit, dixit 25.03.2017 13:07:
> On Fri, Mar 24, 2017 at 12:55 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>>
>>> Are we at a point where we can still rename the new feature at least? If
>>> yes, and keeping everything else is mandatory, than "workspace" or
>>> "working space" may be a serious contender for naming the new thing.
>>
>> I do not have a good answer to the first question, but workspace
>> does sound like a good name for what this feature is trying to
>> achieve.
>>
> 
> Now is not too late to rename the command from worktree to workspace
> (and keep "worktree" as an alias that will be eventually deleted).
> Should we do it? I would keep file names, function names... unchanged
> though, not worth the amount of new conflicts.

I guess I would go for a full change. Our technical documentation often
merely consists of the source code, so we should reduce potential
confusion there, too.

Michael
