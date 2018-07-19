Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 973AA1F597
	for <e@80x24.org>; Thu, 19 Jul 2018 11:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730096AbeGSLmp convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 19 Jul 2018 07:42:45 -0400
Received: from rrzmta1.uni-regensburg.de ([194.94.155.51]:46386 "EHLO
        rrzmta1.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbeGSLmp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 07:42:45 -0400
Received: from rrzmta1.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id DA99C610BB
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 13:00:05 +0200 (CEST)
Received: from gwsmtp1.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by rrzmta1.uni-regensburg.de (Postfix) with ESMTP id C5C0A610AF
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 13:00:05 +0200 (CEST)
Received: from uni-regensburg-smtp1-MTA by gwsmtp1.uni-regensburg.de
        with Novell_GroupWise; Thu, 19 Jul 2018 13:00:05 +0200
Message-Id: <5B506F34020000A10002C6C5@gwsmtp1.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.0.1 
Date:   Thu, 19 Jul 2018 13:00:04 +0200
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     "Sebastian Staudt" <koraktor@gmail.com>
Cc:     <git@vger.kernel.org>
Subject: Antw: Re: Q: Ignore ./foo, but not script/foo
References: <5B503FF0020000A10002C6B5@gwsmtp1.uni-regensburg.de>
 <CA+xP2SZJ0VN0Y7SChAx1a8joVMKMU2R9d0je801i=9SuLicF3w@mail.gmail.com>
In-Reply-To: <CA+xP2SZJ0VN0Y7SChAx1a8joVMKMU2R9d0je801i=9SuLicF3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>> Sebastian Staudt <koraktor@gmail.com> schrieb am 19.07.2018 um 09:55 in
Nachricht
<CA+xP2SZJ0VN0Y7SChAx1a8joVMKMU2R9d0je801i=9SuLicF3w@mail.gmail.com>:
> Hello Ulrich,
> 
> if you want to ignore a file in the root of the repository (and only
> there) this is the correct syntax:
> 
>     /foo

Hi!

Thanks, you are perfectly right: It works, and actually, when read carefully enough, the last item in "PATTERN FORMAT" explains that.

Maybe the EXAMPLES could have an example for each item (5 cases) described ;-)

Regards,
Ulrich

> 
> Best regards,
>     Sebastian
> Am Do., 19. Juli 2018 um 09:45 Uhr schrieb Ulrich Windl
> <Ulrich.Windl@rz.uni-regensburg.de>:
>>
>> Hi!
>>
>> I have a (simple) question I could not answer elegantly from the 
> gitignore(5) manual page:
>>
>> A project produces a "foo" binary in the root directory that I want to 
> ignore (So I put "foo" into .gitignore)
>> Unfortunately I found out taht I cannot have a "script/foo" added while 
> "foo" is in .gitignore.
>> So I changed "foo" to "./foo" in .gitignore. I can could add "script/foo", 
> but now "foo" is not ignored any more!
>>
>> Is there as solution other than:?
>> --
>> foo
>> !script/foo
>> !bla/foo
>> #etc.
>> --
>>
>> If "foo" is one exception to generally using foo elsewhere, it seems to be 
> counterproductive to have to add exceptions for all the cases that are not 
> exceptions, while "foo" is the only exception...
>>
>> Did I miss something? If so, maybe add it to a future manual page.
>>
>> Regards,
>> Ulrich
>>
>>




