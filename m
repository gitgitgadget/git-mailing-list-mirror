Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 500A51F462
	for <e@80x24.org>; Thu, 25 Jul 2019 10:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389736AbfGYKPN (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 06:15:13 -0400
Received: from mx2.uni-regensburg.de ([194.94.157.147]:37086 "EHLO
        mx2.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389517AbfGYKPN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 06:15:13 -0400
Received: from mx2.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id DAAB6600004E
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 12:15:09 +0200 (CEST)
Received: from gwsmtp.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by mx2.uni-regensburg.de (Postfix) with ESMTP id C4195600004D
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 12:15:09 +0200 (CEST)
Received: from uni-regensburg-smtp1-MTA by gwsmtp.uni-regensburg.de
        with Novell_GroupWise; Thu, 25 Jul 2019 12:15:09 +0200
Message-Id: <5D39812C020000A10003265F@gwsmtp.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.1.1 
Date:   Thu, 25 Jul 2019 12:15:08 +0200
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Cc:     <git@vger.kernel.org>
Subject: Antw: Re: blank lines in pre-created merge message
References: <5D382AC1020000A100032608@gwsmtp.uni-regensburg.de>
 <nycvar.QRO.7.76.6.1907251204310.21907@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1907251204310.21907@tvgsbejvaqbjf.bet>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>> Johannes Schindelin <Johannes.Schindelin@gmx.de> schrieb am 25.07.2019 um
12:07
in Nachricht <nycvar.QRO.7.76.6.1907251204310.21907@tvgsbejvaqbjf.bet>:
> Hi Ulrich,
> 
> On Wed, 24 Jul 2019, Ulrich Windl wrote:
> 
>> I think I had tried bringing this to your attention before, but I think it

> was
>> without success.
>> The issue may seem purely cosmetical, while being easy to fix (is my
guess):
>>
>> When using "git merge --no-ff --no-commit ..", the pre-created merge
message
>> always contains two empty lines in between the comment lines. However if 
> there
>> was a merge conflict (being resolved) an extra blank line is added after
the
>> first line.
>>
>> In vi those empty lines are easy to spot, and I routinely remove them. But
>> maybe it's better not to create them at the beginning. (A "normal commit" 
> never
>> creates any emüpty lines in the pre-created comment)
> 
> I could imagine that
> https://github.com/gitgitgadget/git/commit/b2f5171ecc2feb4192acd80f5a6b05c06

> e099e97
> addresses that. Would be good if you could try; just build `pu` from
> https://github.com/git/git (`make install` will install it into your
> `$HOME/bin` and you can test that easily).
> 
> If not, how about giving it a try to fix it yourself? This is open
> source, giving you great power to change the entire source code in your
> local repository as you wish. And of course, with great power... comes
> great responsibility.

I agree, but git isn't a tiny project: Could anybody provide a rough overview
how and where these editor comments are created? Then I could have a look
myself.

> 
>> My Git version is 2.12.3, but the bug is probably quite old...
> 
> You might think that the bug is probably quite old, but what is really
> old is your Git version. The current one is v2.22.0.

With old I mean 1.7.12 or older ;-)

> 
> First order of business should be to verify that it has not been fixed
> in the meantime ;-)

Yeah, but for a fast-paced project you often find yourself busy with updating
all the time, leaving no time for your productive work (like Android
development).
Don't expect too much from someone that drives as 26 year old car... (it's
easier to handle than the new ones) ;-)

Regards,
Ulrich

