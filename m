X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: Cleaning up git user-interface warts
Date: Thu, 16 Nov 2006 12:35:55 +0100
Message-ID: <455C4D1B.1040002@op5.se>
References: <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>	 <f2b55d220611151139v66fba16ax97ce6b9966b33ce7@mail.gmail.com>	 <Pine.LNX.4.64.0611151203450.3349@woody.osdl.org>	 <Pine.LNX.4.64.0611151516360.2591@xanadu.home>	 <Pine.LNX.4.64.0611151226590.3349@woody.osdl.org>	 <87velgs9hx.wl%cworth@cworth.org>	 <Pine.LNX.4.64.0611151339500.3349@woody.osdl.org>	 <87psbos4pb.wl%cworth@cworth.org> <20061115230252.GH24861@spearce.org>	 <Pine.LNX.4.64.0611151523290.3349@woody.osdl.org> <f2b55d220611151902v794edd77i9f76815e4b03a966@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 16 Nov 2006 11:36:06 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <f2b55d220611151902v794edd77i9f76815e4b03a966@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31573>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkfXG-0000Mq-L3 for gcvg-git@gmane.org; Thu, 16 Nov
 2006 12:36:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423850AbWKPLf7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 06:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031167AbWKPLf7
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 06:35:59 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:39395 "EHLO
 smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1031165AbWKPLf7 (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 06:35:59 -0500
Received: by smtp-gw1.op5.se (Postfix, from userid 588) id C87C26BD65; Thu,
 16 Nov 2006 12:35:57 +0100 (CET)
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id 4C5316BCE2; Thu, 16 Nov 2006 12:35:55 +0100 (CET)
To: "Michael K. Edwards" <medwards.linux@gmail.com>
Sender: git-owner@vger.kernel.org

Michael K. Edwards wrote:
> On 11/15/06, Linus Torvalds <torvalds@osdl.org> wrote:
>> Actually, with different people involved it's _much_ better to do it in
>> one shot.
>>
>> Why? Because doing a separate "fetch to local space" + "merge from local
>> space" actually loses the information on what you are merging.
>>
>> It's a lot more useful to have a merge message like
>>
>>         Merge branch 'for-linus' of 
>> git://one.firstfloor.org/home/andi/git/linux-2.6
>>
>> than one like
>>
>>         Merge branch 'for-linus'
>>
>> which is what you get if you fetched it first.
> 
> Full ACK from a platform integrator's perspective.  Local merge is
> great for trial runs but the history in a persistent branch should be
> as self-contained and self-explanatory as possible.  It shouldn't
> depend on what I name local tracking branches, which are just a
> convenience so that I can still do trial runs when my connectivity is
> broken.
> 

[...]

> 
> Coming from me, this is all rather theoretical, as I haven't been
> using this particular tool for the purpose long enough to have an
> independent opinion.  But for what it's worth, the workflow Linus
> describes isn't just for the guy at the top of the pyramid.
> 

I think it's unfortunate that git was originally written by Linus, since 
he so obviously is "the guy at the top of the pyramid" in many more 
senses than just "Linus said this and that patch was OK to commit", 
since git was designed to work like king Arthur's round table; "Linus is 
in the same circle as me, so ofcourse we help each other out".

All suggestions I've been reading about tracking branches, 
separate-remotes and whatnot have their merit. If any of it gets 
implemented, I'd still like to be able to do one-shot pulls from remote 
repos *without* creating specific tracking branches for it. It's 
extremely useful to fetch other peoples topic-branches into my own 
"master" (or topic-branch) when I trust their changes to be good. Please 
consider that when you're hacking away on whatever changes to do.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
