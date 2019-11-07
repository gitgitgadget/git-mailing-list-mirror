Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99FCE1F454
	for <e@80x24.org>; Thu,  7 Nov 2019 09:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733164AbfKGJSi (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 04:18:38 -0500
Received: from fossies.org ([144.76.163.196]:54314 "EHLO fossies.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727562AbfKGJSi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 04:18:38 -0500
Received: from fossies.org (localhost [127.0.0.1])
        by fossies.org (8.15.2/8.15.2) with ESMTP id xA79IQ2g028201;
        Thu, 7 Nov 2019 10:18:30 +0100
Received: from localhost (admin@localhost)
        by fossies.org (8.15.2/8.15.2/Submit) with ESMTP id xA79IQap028132;
        Thu, 7 Nov 2019 10:18:26 +0100
Date:   Thu, 7 Nov 2019 10:18:26 +0100 (CET)
From:   Fossies Administrator <Jens.Schleusener@fossies.org>
To:     Elijah Newren <newren@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Some misspelling errors in the git release 2.24.0
In-Reply-To: <CABPp-BH=XxwJod8XpXYzpmXuo2-8LBozQGH4eEps_r4C798+ag@mail.gmail.com>
Message-ID: <alpine.LSU.2.21.1911071007260.10631@fossies.org>
References: <alpine.LSU.2.21.1911041704520.3956@fossies.org> <20191105171107.27379-1-newren@gmail.com> <alpine.LSU.2.21.1911061026130.15790@fossies.org> <CABPp-BH=XxwJod8XpXYzpmXuo2-8LBozQGH4eEps_r4C798+ag@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Scanned-By: MIMEDefang 2.84 on 144.76.163.196
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Wed, 6 Nov 2019, Elijah Newren wrote:

> On Wed, Nov 6, 2019 at 3:08 AM Fossies Administrator
> <Jens.Schleusener@fossies.org> wrote:
>>
>> Hi Elijah,
>>
>>> On Mon, Nov 4, 2019 at 8:14 AM Fossies Administrator <Jens.Schleusener@fossies.org> wrote:
>>>>
>>>> Hi Elijah,
>>>>
>>>>> On Mon, Nov 4, 2019 at 7:07 AM Fossies Administrator
>>>>> <Jens.Schleusener@fossies.org> wrote:
>
>>> So, I used your codespell program
>>
>> That seems to be a misunderstanding: I'm not the author of the codespell
>> program but I only use that program to detect spelling errors and point to
>> their existence while offering the option to inspect the context of the
>> probably misspelled words in a fast and comfortable way via a Web page.
>
> Oops, sorry for the misunderstanding; thanks for clearing it up.
>
> [...]
>> Some of the according FPs are excluded by Fossies generally, some other
>> obvious FPs are excluded by Fossies specifically for each FOSS project
>> (see always the bold item "Codespell configuration" with a link to
>> "Project-specific additions" or to "(no project-specific adaptions yet
>> done)" that shows all the excluded words and directories/files).
> [...]
>> As one can see on the page
>>
>>   https://fossies.org/linux/misc/git-2.24.0.tar.xz/codespell_conf_info.html
>>
>> there are already done some according attempts.
>
> Ah, thanks for the pointer.  Could you add t/t9150/svk-merge.dump and
> t/t9151/svn-mergeinfo.dump the the list of files to exclude?  Both
> have the 'hapenning' typo, but both are a dump of some repository and
> editing it means recomputing sha1sums and whatnot for tests that just
> isn't worth it.

Sure, done.

Principally test directories and files seem to be a "special" area
also for spelling checks.

> I thought maybe I could get away with correcting
> those spelling errors but backed out once I saw further knock-on
> effects.

That is one reason that only the developers should made such corrections.

> Thanks for the report and the background and corrections!

Regards

Jens

-- 
FOSSIES - The Fresh Open Source Software archive
mainly for Internet, Engineering and Science
https://fossies.org/
