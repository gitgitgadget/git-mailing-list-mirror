Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5DEC433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 22:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9AF061361
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 22:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbhKRWDQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 17:03:16 -0500
Received: from smtp-8fad.mail.infomaniak.ch ([83.166.143.173]:44165 "EHLO
        smtp-8fad.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230481AbhKRWDP (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 18 Nov 2021 17:03:15 -0500
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4HwD9W3ybYzMqLkq;
        Thu, 18 Nov 2021 22:54:55 +0100 (CET)
Received: from [10.10.10.4] (unknown [51.15.56.3])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4HwD9V5Zq6zlhP4p;
        Thu, 18 Nov 2021 22:54:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=etguillot.fr;
        s=20191114; t=1637272495;
        bh=3pyqBuNpji4YbkPBg7EFCV6txOQw5WU5yydS73uB+lQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mOvPq0Yo61uNuWm5PBkpFE0etboBmJ5RvRI7PolFespQXftVwTZ4ct8oMcFTGU/su
         Uu3sgQxA4X++AnbiCnjXV6XfH9B495Q5l4yDvfkizoPuLmoiDkp+vPBEJd7hjQFtvf
         jT41IdszjAq8MkiqBgIR1IfjRQ7JgLsDzTSwW/Pg=
Message-ID: <5a5ac5a9-dda8-ece6-2f35-6362e5085ed6@etguillot.fr>
Date:   Thu, 18 Nov 2021 22:54:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: Need help in understanding how to submit a patch
Content-Language: en-US
To:     Jiang Xin <worldhello.net@gmail.com>, Taylor Blau <me@ttaylorr.com>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Philip Oakley <philipoakley@iee.email>,
        Etienne Guillot <git@etguillot.fr>,
        =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>,
        Git List <git@vger.kernel.org>
References: <127c9dbd-4861-beea-a85b-af7412ce141f@etguillot.fr>
 <6fa0b1dd-ac20-ff55-95ea-1c22347f9199@iee.email>
 <20211117175149.7slohfqqwsmn3ua6@yadavpratyush.com>
 <YZVB5hy4Xuim5K9B@nand.local>
 <CANYiYbFq-SAq2VLcFFX8P=Y8-JzjqW63mJqTuOCgO+q+Zzf=DQ@mail.gmail.com>
 <YZWvJdWcmhIl9DxR@nand.local>
 <CANYiYbGuR8WNvD_2Kw_M0XX9H027Z2m137S0zwrfL7oURSpTUw@mail.gmail.com>
From:   Etienne Guillot <git@etguillot.fr>
In-Reply-To: <CANYiYbGuR8WNvD_2Kw_M0XX9H027Z2m137S0zwrfL7oURSpTUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/18/21 02:52, Jiang Xin wrote:
> On Thu, Nov 18, 2021 at 9:40 AM Taylor Blau <me@ttaylorr.com> wrote:
>>
>> On Thu, Nov 18, 2021 at 09:37:57AM +0800, Jiang Xin wrote:
>>> On Thu, Nov 18, 2021 at 1:54 AM Taylor Blau <me@ttaylorr.com> wrote:
>>>>
>>>> Jiang,
>>>>
>>>> On Wed, Nov 17, 2021 at 11:21:49PM +0530, Pratyush Yadav wrote:
>>>>> Hi Etienne,
>>>>>
>>>>> On 17/11/21 03:47PM, Philip Oakley wrote:
>>>>>> On 16/11/2021 21:15, Etienne Guillot wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> I found a typo mistake in the french translation of git-gui.
>>>>>>> I did read the instructions on this page
>>>>>>> https://git-scm.com/docs/SubmittingPatches
>>>>>>> but I still not sure where should I push the correction.
>>>>>>>
>>>>>>> Thanks for your help
>>>>>>>
>>>>>>> Etienne Guillot
>>>>>> Hi Etienne
>>>>>>
>>>>>> The Git Gui is managed by Pratyush Yadav (cc'd) and hosted at
>>>>>> https://github.com/prati0100/git-gui
>>>>>>
>>>>>> Not sure what the latest is on contributing translations (not covered in
>>>>>> the GitHub Readme..).
>>>>>
>>>>> I usually ask people to post patches on this mailing list and I review
>>>>> them here. But I make an exception for translation changes since they
>>>>> never get any reviews anyway.
>>>>>
>>>>> So I am fine with either a Pull Request on GitHub or a patch on the
>>>>> mailing list.
>>>>
>>>> Since Pratyush is the maintainer, does the po/TEAMS file in your tree
>>>> need updating?
>>>
>>> Git Gui is a standalone project with its own workflow. The file
>>> "po/TEAMS" is only used for Git project, so I am a little confused how
>>> to update this file?
>>
>> I misread Etienne's original message, I thought they were asking about
>> the French translation for Git, not git-gui.
>>
>>>> I'm not sure how up-to-date the file is in general, but the last commit
>>>> was made semi-recently back in August, so I assume that the entry for
>>>> the French translation is outdated.
>>>
>>> French l10n team is led by Jean-Noël Avila, and is very active.
>>>
>>>      git log --no-merges -- po/fr.po
>>>
>>> L10n for git-gui are maintained by different people though.  Because
>>> "git-gui" is merged into git using subtree merge strategy,  I cannot
>>> find commit logs of "git-gui/po/fr.po" using the same command, and
>>> have to find the original git-gui commit, and find commit logs from
>>> "po/fr.po" (which is quite different file from "po/fr.po" of Git).
>>>
>>>      git log 8a383db4b2 -- po/fr.po
>>
>> Yes, clearly no update is necessary here. Sorry for the confusion.
> 
> It's really easy to confuse. No problem.
> 
> BTW, what is the elegant way to find commit logs of a tree from a subtree merge?
> 
> I have to run git-log on "git-gui" to find the 2nd parent commit ID of
> the subtree merge, and run git-log on it.
> 
> --
> Jiang Xin
> 

Thank you everyone for your answers.
I choose the easy way and opened a pull request on github.

Etienne Guillot
