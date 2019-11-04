Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7105B1F454
	for <e@80x24.org>; Mon,  4 Nov 2019 16:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbfKDQOa (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 11:14:30 -0500
Received: from fossies.org ([144.76.163.196]:42572 "EHLO fossies.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727838AbfKDQOa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 11:14:30 -0500
Received: from fossies.org (localhost [127.0.0.1])
        by fossies.org (8.15.2/8.15.2) with ESMTP id xA4GEI76029533;
        Mon, 4 Nov 2019 17:14:22 +0100
Received: from localhost (admin@localhost)
        by fossies.org (8.15.2/8.15.2/Submit) with ESMTP id xA4GEIqa029390;
        Mon, 4 Nov 2019 17:14:18 +0100
Date:   Mon, 4 Nov 2019 17:14:18 +0100 (CET)
From:   Fossies Administrator <Jens.Schleusener@fossies.org>
To:     Elijah Newren <newren@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Some misspelling errors in the git release 2.24.0
In-Reply-To: <CABPp-BFUPhJ1wmJa5htnjXrHkFKLuj2ggAuyPvrM0TP-0TZwuw@mail.gmail.com>
Message-ID: <alpine.LSU.2.21.1911041704520.3956@fossies.org>
References: <alpine.LSU.2.21.1911041316270.23271@fossies.org> <CABPp-BFUPhJ1wmJa5htnjXrHkFKLuj2ggAuyPvrM0TP-0TZwuw@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Scanned-By: MIMEDefang 2.84 on 144.76.163.196
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

> On Mon, Nov 4, 2019 at 7:07 AM Fossies Administrator
> <Jens.Schleusener@fossies.org> wrote:
>>
>> Hi,
>>
>> although misspelling corrections are not the most exciting issues and the
>> spelling errors are rarely true code bugs but mostly contained in the
>> comments and documentation parts they correction may still improve the
>> overall quality of a software project a little bit.
>>
>> In this sense I created a code misspelling report for "git" using the
>> program "codespell"
>>
>>   https://fossies.org/linux/misc/git-2.24.0.tar.xz/codespell.html
>>
>> or version independent
>>
>>   https://fossies.org/linux/misc/git/codespell.html
>
> Cool, thanks for sending this report along.  The typos within the
> Documentation/ subdirectory have mostly been addressed by the
> en/doc-typofix branch (in next, not yet merged to master).  There are
> also some false positives in this report (e.g. mmaped should not be
> changed to mapped, CREAT should not be changed to CREATE, examples in
> format-patch showing how to correct spelling errors need to keep their
> spelling errors or it won't make sense, and perhaps some others), but
> most of them look like actual spelling errors that should be
> corrected.  I'll send in a patch, and mark you as the reporter of the
> issues.
>
> Elijah

Thanks for your feedback. Yes, the words "mmaped" and "CREAT" I noticed as 
possible FPs but I was not really sure. And the character of the file 
"format-patch" I have simply overseen. So I have done a rerun and the 
mentioned two words and the file are now excluded.

Jens
