Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFC7C433EF
	for <git@archiver.kernel.org>; Fri, 31 Dec 2021 17:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhLaRXR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Dec 2021 12:23:17 -0500
Received: from mx2.uni-regensburg.de ([194.94.157.147]:37002 "EHLO
        mx2.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhLaRXP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Dec 2021 12:23:15 -0500
Received: from mx2.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 7B0E4600004E;
        Fri, 31 Dec 2021 18:23:12 +0100 (CET)
Received: from smtp1.uni-regensburg.de (smtp1.uni-regensburg.de [194.94.157.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "smtp.uni-regensburg.de", Issuer "DFN-Verein Global Issuing CA" (not verified))
        by mx2.uni-regensburg.de (Postfix) with ESMTPS id 605EA600004A;
        Fri, 31 Dec 2021 18:23:12 +0100 (CET)
Subject: Re: [EXT] Re: Filtering commits after filtering the tree
To:     Son Luong Ngoc <sluongng@gmail.com>
Cc:     git <git@vger.kernel.org>
References: <61CC2DD2020000A10004691F@gwsmtp.uni-regensburg.de>
 <CAL3xRKet7KXTx+6ALVZCxeFRkU3guwNc6GtAT1iofB=UKqj2fg@mail.gmail.com>
From:   Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
Message-ID: <9ba1551b-375c-fe71-3402-8a54dbeec085@rz.uni-regensburg.de>
Date:   Fri, 31 Dec 2021 18:23:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAL3xRKet7KXTx+6ALVZCxeFRkU3guwNc6GtAT1iofB=UKqj2fg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/30/21 2:19 PM, Son Luong Ngoc wrote:
> Hi Ulrich,
> 
> On Thu, Dec 30, 2021 at 12:28 PM Ulrich Windl
> <Ulrich.Windl@rz.uni-regensburg.de> wrote:
>>
>> Hi guys!
>>
>>
>> As  I know there are really smart ones around, please don't laugh how I helped myself with this problem:
>> https://stackoverflow.com/q/70505903/6607497
>> I'm sure you wouldn't have wasted hours with rebasing interactively...
>>
>>
>> Feel free to comment either on the list or at SO (comment or improved answer).
> 
> You probably want to try git-filter-repo (1)
> while using `--message-callback` as documented in (2)

Interestingly in SLES12 SP5 there is a message recommending 
git-filter-repo, but when I had tried "man git-filter-repo" there was no 
manual page. So I did not follow that path...

> 
>>
>>
>> Regards,
>> Urich
>>
>>
> 
> Hope it helps,
> Son Luong.
> 
> (1) https://github.com/newren/git-filter-repo
> (2) https://htmlpreview.github.io/?https://github.com/newren/git-filter-repo/blob/docs/html/git-filter-repo.html#CALLBACKS
> 
