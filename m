Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 315EB1F731
	for <e@80x24.org>; Fri,  9 Aug 2019 14:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406921AbfHIOmk (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Aug 2019 10:42:40 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:53831 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfHIOmj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Aug 2019 10:42:39 -0400
X-Originating-IP: 157.45.48.36
Received: from localhost.localdomain (unknown [157.45.48.36])
        (Authenticated sender: me@yadavpratyush.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 867841C0007;
        Fri,  9 Aug 2019 14:42:35 +0000 (UTC)
From:   Pratyush Yadav <me@yadavpratyush.com>
Subject: Re: [PATCH] git-gui: Call do_quit before destroying the main window
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20190804143919.10732-1-me@yadavpratyush.com>
 <b7cbe50d-879f-68b9-30b2-181c3058297f@yadavpratyush.com>
 <xmqqftmejgr1.fsf@gitster-ct.c.googlers.com>
 <549ad583-5ca1-7096-f4ce-10e8a836f7f9@yadavpratyush.com>
 <xmqq5zn8j25p.fsf@gitster-ct.c.googlers.com>
 <9a425bf6-1138-48db-3506-6bee1eff21ee@yadavpratyush.com>
 <xmqqa7ckhcc4.fsf@gitster-ct.c.googlers.com>
Message-ID: <7a515181-d73f-f21c-a564-db5602d91e93@yadavpratyush.com>
Date:   Fri, 9 Aug 2019 20:12:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqa7ckhcc4.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/8/19 3:23 AM, Junio C Hamano wrote:
> Pratyush Yadav <me@yadavpratyush.com> writes:
> 
>> I think you misunderstood me. I do not mean to create a GitHub pull
>> request, because as you say, no one other than me and you will look at
>> it. What I meant was that I can pile up a bunch of commits, and send
>> them on this list here for you to merge. I can explain those changes
>> in the cover letter, so people not very familiar with git-gui or
>> Tcl/Tk can still get a general idea of what's happening.
> 
> If you meant to volunteer to act as a git-gui maintainer, that would
> be wonderful.  Then I do not have to play an interim maintainer.

Yes, I do mean to volunteer to act as a git-gui maintainer.

Is there something I should know other than 
Documentation/howto/maintain-git.txt?

> Or did you mean to do that only for your own patches, forcing _me_
> to become a de-facto interim maintainer for git-gui project?  You
> effectively ended up doing so for this single patch already ;-)
> 
> I will not be able to continue doing so for anything more complex or
> controversial, though.
> 
> Thanks.
> 


-- 
Regards,
Pratyush Yadav
