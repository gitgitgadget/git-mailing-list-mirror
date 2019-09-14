Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD2B41F463
	for <e@80x24.org>; Sat, 14 Sep 2019 21:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfINV0p (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Sep 2019 17:26:45 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:6411 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbfINV0p (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Sep 2019 17:26:45 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 46W5DM1HrSz5tlD;
        Sat, 14 Sep 2019 23:26:43 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id D539B109;
        Sat, 14 Sep 2019 23:26:42 +0200 (CEST)
Subject: Re: git-gui: automatically move focus to staged file before typing
 commit message?
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Git List <git@vger.kernel.org>
References: <CAGr--=KMJmYtVaATFkOPcboAdkLvpZFbWAo4QAE0-uC6RL4Lqg@mail.gmail.com>
 <20190914211509.sjy6lh2rlcl32lj5@yadavpratyush.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <0db5470e-5044-d5b3-8f04-f40cfbd8cf44@kdbg.org>
Date:   Sat, 14 Sep 2019 23:26:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190914211509.sjy6lh2rlcl32lj5@yadavpratyush.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.09.19 um 23:15 schrieb Pratyush Yadav:
> On 14/09/19 02:24PM, Birger Skogeng Pedersen wrote:
>> When the user
>> stages the last file in the "Unstaged Changes" widget, no file is
>> selected and the diff view becomes blank. When this is the case, I
>> would prefer that git-gui automatically selects one of the staged
>> files and shows it in the diff widget before I type up my commit
>> message. Naturally, this automatic selection should **only** happen
>> when the user chooses focus the "Commit Message" widget.
> 
> Why should it only happen when the commit message widget is selected? 
> What's wrong with directly switching focus when all the files are 
> staged?

That was my reaction, too.

> What I have in mind is once there are no more files to stage, the focus 
> directly goes to the staged files section, and the first staged file 
> gets selected.

... or the last one that was staged. Typically, it is a fixup found
during testing that is staged last. Then I like to have a look at the
complete staged changes of that file.

 Then if you want you can type in the commit message. And
> conversely, when unstaging things, once all files are unstaged, the 
> focus goes directly to the unstaged files section.

Same here.

-- Hannes
