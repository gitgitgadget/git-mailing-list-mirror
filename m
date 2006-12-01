X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 01 Dec 2006 14:43:16 +0100
Message-ID: <45703174.8000609@op5.se>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200611292000.23778.andyparkins@gmail.com> <20061130170625.GH18810@admingilde.org> <200612010902.51264.andyparkins@gmail.com> <20061201110032.GL18810@admingilde.org> <45701B8D.1030508@b-i-t.de> <20061201121234.GQ18810@admingilde.org> <4570289D.9050802@b-i-t.de> <20061201133558.GU18810@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 13:43:32 +0000 (UTC)
Cc: sf <sf@b-i-t.de>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <20061201133558.GU18810@admingilde.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32922>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq8fj-0000Ab-LG for gcvg-git@gmane.org; Fri, 01 Dec
 2006 14:43:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031493AbWLANnS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 08:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031507AbWLANnS
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 08:43:18 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:7317 "EHLO
 smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1031493AbWLANnR (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 08:43:17 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id 8460D6BCCF; Fri,  1 Dec 2006 14:43:16 +0100 (CET)
To: Martin Waitz <tali@admingilde.org>
Sender: git-owner@vger.kernel.org

Martin Waitz wrote:
> hoi :)
> 
> On Fri, Dec 01, 2006 at 02:05:33PM +0100, sf wrote:
>>> On Fri, Dec 01, 2006 at 01:09:49PM +0100, sf wrote:
>>>> Martin Waitz wrote:
>>>>> So you not only store your submodule HEAD commit in the supermodule
>>>>> when you do commit to the supermodule, it also means that your
>>>>> submodule HEAD will be updated when you update your supermodule.
>>>> Why the magic? The typical workflow in git is
>>>>
>>>> 1. You work on a branch, i.e. edit and commit and so on.
>>>> 2. At some point, you decide to share the work you did on that branch 
>>>> (e-mail a patch, merge into another branch, push upstream or let it by 
>>>> pulled by upstream)
>>> 3. Other people want to use your new work.
>> Sorry, if that was not obvious: You actually procceed with one of the 
>> options I listed in Step 2. What I wanted to state is that with git you 
>> do not mix up committing (which is local to your repository and your 
>> branch) and publishing.
> 
> I guess you are refering to not mix up committing to the submodule and
> updating the supermodule index.
> These are really two separate steps, I just combined them above because I
> wanted to put emphasis on the other part: it is not a one-way flow, it
> is bidirectional, so your HEAD would have to changed if the supermodule
> gets updated.
> And I consider changing HEAD, without looking at the branch it points
> to, to be a bad thing.
> 

So a commit in the supermodule turns into a commit in the submodule? 
That's just plain wrong. If it doesn't, why would the submodule HEAD 
have to change?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
