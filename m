Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422E5C4332F
	for <git@archiver.kernel.org>; Sun,  1 Jan 2023 12:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjAAM7r (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Jan 2023 07:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjAAM7r (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jan 2023 07:59:47 -0500
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3262F38E
        for <git@vger.kernel.org>; Sun,  1 Jan 2023 04:59:45 -0800 (PST)
Received: from 88-110-102-84.dynamic.dsl.as9105.com ([88.110.102.84] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1pBxwD-00079P-9S;
        Sun, 01 Jan 2023 12:59:42 +0000
Message-ID: <1cf19990-8989-83f5-3b2c-e1b1725509a3@iee.email>
Date:   Sun, 1 Jan 2023 12:59:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Request to remove Junio C Hamano as the Git Maintainer
To:     Filip Lipien <aaa@164.ooo>, Theodore Ts'o <tytso@mit.edu>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
References: <7hfRSnKTRnT4uJh5Pok8U8gfLm_NXzCS6w_7_Rc9OH3a9Lv8hpjySZqxDglBFC-fTOdZHi-ODCihiEHlQD9nIhUmld5jYvRx_JvB0z2IAL0=@164.ooo>
 <Y7CLVESLXqy1ZLCn@mit.edu>
 <HJUKdhucsV1Ec9xNrCRNQLPylBS-oxmEZZzqT48oYfzyQ7hWXT5Kg3R4aF4JuI2FvVz9rjR1pysm7Xx53GRogtR1zNzDvRbRSu0P2ce876A=@164.ooo>
Content-Language: en-GB
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <HJUKdhucsV1Ec9xNrCRNQLPylBS-oxmEZZzqT48oYfzyQ7hWXT5Kg3R4aF4JuI2FvVz9rjR1pysm7Xx53GRogtR1zNzDvRbRSu0P2ce876A=@164.ooo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 31/12/2022 23:23, Filip Lipien wrote:
>> Incorrect. As of this writing, there are 146,090 quetions[1] tagged
>> [git] on stackoverflow. Compare that to the 161,963 questions[2]
>> tagged [windows], or the 2,084,537 questions[3] tagged [python].
> Please remain on the topic. Read my initial sentence again. What has "tagged" to do with related? And even if, the amount of 146,090 "tagged" questions is absolute madness. This is insane. Just look at the ratio in comparison to Python, a programming language. It is crazy to assume that this is fine and only proves my point. No, Git is not a complex programming language like Python, nor is it a Kernel API. It is supposed to be a user-facing tool made for humans.

The purpose of Git is to provide a Source Code Management system for
Linux. Linux development is *distributed*, and Linux is command line
orientated.

The need for a distributed SCM required a significant shift in mind set
compared to previous *control* systems that were historically based on
drawing and physical part management systems [1].
 
The ability to 'manufacture' duplicate copies of code, and then modify
them, at speed, makes those historical methods essentially impractical /
unworkable. Hence Git, with all it's foibles, has been widely adopted,
as control now lies with the user. Management can still be responsible
for 'authentication/designation' of specific revisions.

Git generally offers two world views, one that roughly matches the old
'change control' methods (diffs), and true 'local state' view. It is
easy to miss the subtle shift in world views.
>
> The fact is, that Junio C Hamano is doing a terrible job as a product manager. Because apparently, most users seem to have a problem with it. Why can this not be pointed out?

Junio is not a "product manager". He is not 'selling' to the wider user
base. He is maintaining a core element of the Linux ecosystem. I doubt
it's an easy job, balancing backward compatibility, future capability,
and broad usability, along with code quality, security and all the rest.

Learning Git is like learning Quantum Mechanics, it's just a few simple
rules, but the mind set shift is difficult. It has action at a distance,
and is amazingly effective.

In many ways it's the confusion between 'developer' facing, and 'user'
facing tooling. The nuances are different.

>
> ------- Original Message -------
> On Saturday, December 31st, 2022 at 8:19 PM, Theodore Ts'o <tytso@mit.edu> wrote:
>
>
>>
>> On Sat, Dec 31, 2022 at 06:11:17PM +0000, Filip Lipien wrote:
>>
>>> There are more than one million questions on Stackoverflow related to the usage of Git.
>>> This is not normal.
>>
>> Incorrect. As of this writing, there are 146,090 quetions[1] tagged
>> [git] on stackoverflow. Compare that to the 161,963 questions[2]
>> tagged [windows], or the 2,084,537 questions[3] tagged [python].
>>
>> [1] https://stackoverflow.com/questions/tagged/git
>> [2] https://stackoverflow.com/questions/tagged/windows
>> [3] https://stackoverflow.com/questions/tagged/python
>>
>> The fact that there are a large number of questions in stackoverflow
>> is more a measure of a tool's popularity than anything else. And if
>> it's popular, it's probably because a large number of developers have
>> found it to be useful.
>>
>>> Git is in its current state not a tool that's made for humans.
>>
>> It's made for developers like me, and last I checked, I'm human. :-)
>> It may not be made for you, but that's OK; you don't have to use it.
>>
>> My personal opinion is that it has probably saved a net total of
>> billions of dollars of developer time, for those who know how to use
>> it.
>>
>> Best regards,
>>
>> - Ted
>>
>> P.S. I would commend to you Neal Stephenson's essay, "In the
>> beginning was the command line". 

In the beginning was Jacquard looms and Hollerith cards ;-)

>> It was available for sale as a book,
>> but as it was published a while back in 1999, it's since been made
>> available for free download[4]. Unfortunately, because it was so
>> popular, the resulting download traffic crashed his publisher's
>> website, and it's no longer available there. The best place to get it
>> is here[5].
>>
>> [4] https://www.nealstephenson.com/in-the-beginning-was-the-command-line.html
>> [5] https://github.com/danielmkarlsson/library/blob/master/Neal Stephenson - In the Beginning was the Command Line.pdf
>>
>> It's a short read; only 60 pages in the PDF. About midway through the
>> essay, in section 11, there is a comparison made between Linux and the
>> Hole Hawg, an industrial drill made by the Milwaukee Tool Company. If
>> Linux is the Hole Hawg of Operating Systems, then perhaps git is the
>> Hole Hawg of Source Code Management systems. If it's too much SCM for
>> you; there's no shame --- you can always choose to use lesser SCM's
>> for your own personal projects. :-)
--
Philip

[1] Mil Std 483, Def Stan 05-57, etc.

note, https://en.wikipedia.org/wiki/Configuration_management#Software
doesn't yet mention Git ;-)
