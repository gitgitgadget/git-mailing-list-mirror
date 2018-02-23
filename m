Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 815C71F404
	for <e@80x24.org>; Fri, 23 Feb 2018 13:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751551AbeBWNMm (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 08:12:42 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:5849 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751540AbeBWNMk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 08:12:40 -0500
Received: from [192.168.2.201] ([92.22.21.220])
        by smtp.talktalk.net with SMTP
        id pD9ReFOQ45UYopD9Re0TqF; Fri, 23 Feb 2018 13:12:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1519391558;
        bh=c7LBOVYdTG90O/Tyxom41vhlAWtHEglAhT+LPQ2LCYo=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=cbyqqhXA/Cp2VRdSedh2x3boxYkRCYm9mtDkgar2Qc8yDLuZbm/KYKdXu/14o7dY9
         RMbNZ2tsBtoK/OnP1UFLTd64x820kI/sKPJcp/8IT9GoMwjINyaou3wo795LPj07C8
         XlLIUHt6kZaZROZ89Zk+z9NbDMRNi6oEraPvRp5c=
X-Originating-IP: [92.22.21.220]
X-Spam: 0
X-OAuthority: v=2.2 cv=aOKAkf1m c=1 sm=1 tr=0 a=VSxTZYxioCnvaH7igEU67w==:117
 a=VSxTZYxioCnvaH7igEU67w==:17 a=IkcTkHD0fZMA:10 a=oSzODahGfGAB2XvunvAA:9
 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Is there any way to "interrupt" a rebase?
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Hilco Wijbenga <hilco.wijbenga@gmail.com>
Cc:     Git Users <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Jacob Keller <jacob.keller@gmail.com>
References: <CAE1pOi1XtrWqG7mOdrNt10YoZG0LOAB7i9cc1Gi8oWhULxE57A@mail.gmail.com>
 <20180219223653.GE6619@genre.crustytoothpaste.net>
 <CAE1pOi070p9VNPnLS3jSXp7TrbR2fhOc7sx+58exAp92k4D0dw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1802201147300.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <nycvar.QRO.7.76.6.1802201240010.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <041177b6-e33b-085c-5546-56dbdec75fa3@talktalk.net>
Date:   Fri, 23 Feb 2018 13:12:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1802201240010.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfEdOc1Es0exsL1c6Df7+G6l5ME1BI492B5xj3wG3Y9wHfHf71uo62lhBAsW8xew9S8N16uoknYLyHnyT6nC2RK4kNHanYmLl1poNhs8WzJjpQs+t+Uku
 fT8M9SYw03t6xrI9IV13JCSSdQe/ZzdvH9MGjXaGTRadXaMBAM0CM7Vb9iI7mFhKCWYkQq8KmTNNZfUEhlx5yF1gOQSlVao9gSBlKve3F9g1JTnXAjhz+286
 Gt5XbftpxZE3436xqgryFYr6TWueXZQ2nFPgX544S/ratYDeAD6Ep4KMGiUByV+4FvMWUTuFP886tRSNKMd8+6xar6Y2Mgx8ZkKS32XYiAarrIIts9L7LeC+
 AfnkYVSb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/02/18 11:44, Johannes Schindelin wrote:
> 
> Hi Hilco,
> 
> On Tue, 20 Feb 2018, Johannes Schindelin wrote:
> 
>> When I am particularly tired and overworked (and therefore know that my
>> working memory is less useful than usual), I therefore resort to my
>> second-favorite strategy: U use the `done` file.
>>
>> I literally copy parts of $GIT_DIR/rebase-merge/done to the beginning of
>> $GIT_DIR/rebase-merge/git-rebase-todo (the most convenient way to open the
>> latter is `git rebase --edit-todo`). In your case, those would be the
>> `pick` lines cherry-picking D and E. Then, as before, `git reset --hard
>> <commit>` (where I look up the `<commit>` using an aliased version of `git
>> log --graph --oneline --left-right --boundary`), amend the commit, and
>> then `git rebase --continue`.
>>
>> It might be even possible to design a new subcommand for the interactive
>> rebase to facilitate a variation of this strategy (possibly even making
>> use of the fact that the interactive rebase accumulates mappings between
>> the original commits and the rewritten ones in
>> $GIT_DIR/rebase-merge/rewritten-list, intended for use in the post-rewrite
>> hook).
> 
> This feature might look somewhat like this:
> 
> 	git rebase --replay-latest-commits 3
> 
> and it would not even have to look at the `rewritten-list`. All it would
> do is to put back the latest `pick` from the `done` file (in case of merge
> conflicts) into the `git-rebase-todo` file, then insert `pick lines for
> HEAD~3.. at the beginning of that todo file, and then `git reset --hard
> HEAD~3`.
> 
> By not using the original lines from the `done` file (i.e. *different*
> from what I described as my second-favorite strategy), you would also get
> the resolved merge conflicts rather than having to re-resolve them.

Yes that's why I prefer using pasting the output of git log rather than
bits of rebase-merge/done into the todo list when rewinding manually.

> 
> (This all would of course only work properly without --preserve-merges and
> without the upcoming --recreate-merges.)

It shouldn't be too hard to support --recreate-merges in the case where
you don't go past a merge commit, one would just have to check
refs/rewritten to see if any label commands need to be inserted.

Best Wishes

Phillip

> Ciao,
> Johannes
> 

