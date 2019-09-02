Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 270631F461
	for <e@80x24.org>; Mon,  2 Sep 2019 17:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfIBRXL (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 13:23:11 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:29648 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbfIBRXL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 13:23:11 -0400
Received: from [92.7.169.237] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1i4q2k-00012X-3a; Mon, 02 Sep 2019 18:23:06 +0100
Subject: Re: [PATCH] git-gui: Add hotkeys to set widget focus
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Birger Skogeng Pedersen <birger.sp@gmail.com>, git@vger.kernel.org
References: <xmqqbmg13sxq.fsf@gitster-ct.c.googlers.com>
 <20190831122326.9071-1-birger.sp@gmail.com>
 <20190901113218.3lfu4ifsxhzrsw4g@yadavpratyush.com>
 <e2b35f49-5578-c58f-326d-3111333737a0@iee.email>
 <20190902122527.6cbcizo5dsewrl57@yadavpratyush.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <ca5052b8-32ea-5d38-76ba-2389b5f95e45@iee.email>
Date:   Mon, 2 Sep 2019 18:23:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190902122527.6cbcizo5dsewrl57@yadavpratyush.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/09/2019 13:25, Pratyush Yadav wrote:
> On 01/09/19 11:27PM, Philip Oakley wrote:
>> Hi Pratyus,
>> On 01/09/2019 12:32, Pratyush Yadav wrote:
>>> Hi Birger,
>>>
>>> In case you haven't been following the list, Pat has been inactive
>>> recently, so I am acting as the interim maintainer of git-gui for now,
>>> because no one else stepped up and Junio would rather not maintain it.
>>>
>>> You can find my fork over athttps://github.com/prati0100/git-gui. I
>>> munged your patches to apply on my tree (which is separate from the
>>> git.git tree), but it would be great if you base them on my tree next
>>> time around.
>> Are there any plans or thoughts about creating a more inclusive man page for
>> the git-gui?
>   
> Having better documentation has been one of the things I have in my
> future plans, but I can't really say when I can get to it depending on
> my schedule and time available. I have a couple other topics active
> which I'd like to get resolved first.
>
> Of course, if someone else is willing to take the initiative, I'm happy
> to help :)

The main aspect that would help for providing a contribution would be to 
at least decide the (rough) framework/format for a full Gui 'man page'. 
The existing one 
https://github.com/git/git/blob/master/Documentation/git-gui.txt is 
rather short. (would also need the sub-tree integration to be finessed)

e.g.
1. how much should it be done via 'include' files (like the git-config 
man page now does include::config.txt[] and onwards).

2. Does it use the doc-book man-page format, or something akin to the 
former tutorial format? (everything appears to have shifted to the man 
page format, so looks like man format is the one.. [1,2,3,4]

I'm thinking that, as it is a big job, it will need the documentation to 
be split over a number of small include files so that more folk can be 
contributors.

>> Such things as the Options dialog linkages [1], and how to drive the command
>> line options are areas I've wondered about over the years.
>>
>> Not exactly sure how our plain text man pages and formatted HTML would fare
>> for describing the gui layout and where to click. One thing I am noting is
>> that these hotkey nicely have numbers so can easily be used for reference..
>   
> For the options dialog, I think a "tooltip" (something like what you get
> when you hover over a image in a browser) that describes the option is a
> better idea than having a separate man page. I don't expect the option
> descriptions to be too long or complicated. This approach has the added
> benefit of not having to maintain a separate man page. Whenever someone
> adds a new options, they have to add its description as well.
A tool tip that says 'see git help config.. ' could be done. Any 
pointers to an existing one for trying a cookie cutter approach getting 
started on those ones?
>
> I also think the "tools" feature needs some documentation, especially
> about what environment variables we export.
>
> Other than these two, I don't see many places that need too much
> documentation. Rest of the UI is pretty self-intuitive, at least to me.
>
>> Philip
>>
>> [1] https://stackoverflow.com/questions/6007823/is-there-a-help-page-for-the-git-gui-options-dialog
[1,2,3,4] 
https://github.com/git/git/blob/master/Documentation/giteveryday.txt
https://github.com/git/git/blob/master/Documentation/gittutorial.txt
https://github.com/git/git/blob/master/Documentation/gitcore-tutorial.txt
https://github.com/git/git/blob/master/Documentation/everyday.txto

