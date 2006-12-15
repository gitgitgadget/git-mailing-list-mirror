X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: svn versus git
Date: Fri, 15 Dec 2006 16:41:39 +0100
Message-ID: <4582C233.1000706@op5.se>
References: <200612151519.kBFFJSYn012227@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 15 Dec 2006 15:41:50 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <200612151519.kBFFJSYn012227@laptop13.inf.utfsm.cl>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34521>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvFBx-0003cm-Ta for gcvg-git@gmane.org; Fri, 15 Dec
 2006 16:41:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752711AbWLOPln (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 10:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752753AbWLOPln
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 10:41:43 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:55114 "EHLO
 smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1752711AbWLOPlm (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006
 10:41:42 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id 4FF696BCC4; Fri, 15 Dec 2006 16:41:40 +0100 (CET)
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Sender: git-owner@vger.kernel.org

Horst H. von Brand wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:
>> Andy Parkins wrote:
>>
>>> On Wednesday 2006 December 13 22:56, Shawn Pearce wrote:
>>>
>>>>   git cat-file -p $REV:$file
>>>>
>>>> not sure how much easier it gets than that.  Load in the bash
>>>> completion from contrib/completion and you can even tab complete
>>>> the $file part.
>>> Yes.  I was a little unfair on that one; I forgot about the REV:file syntax.  
>>> However, it's still not simple for a new user; I think I'd say "draw" if 
>>> the "-p" weren't a requirement.
>>   $ git repo-config alias.less "-p cat-file -p"
>>   $ git repo-config alias.cat     "cat-file -p"
>>
>> remedies that.
>>
>> [...]
>>>> How is it unfriendly?  What specifically would you change to make
>>>> it more friendly?
>>> $ git-ls-tree v1.0.0
>>> 100644 blob 906e98492080d2fde9467a9970fc92d7a8cfeaf8    Makefile
> 
>>> I'm a newbie: what's that number at the front?  What's a blob?  What's
>>> that great big number - I've only seen commit hashes that look like
>>> that, and that isn't one.  Definitely not friendly.
> 
>> The number in front is octal mode of a file or directory. "blob"
>> is a file (or symbolic link), "tree" is a directory, all of this
>> can be found in git(7).
> 
> I don't want to come through as rude, but that you can find the explanation
> somewhere (and as an old(ish) Unix/git hand you know (or should be able to
> guess easily) what it means) doesn't help the _newbie_ confronted with this
> gibberish one iota.


I think it would help if we could write out things ls-style though and 
I'm all for axing the SHA1 (I don't even think the SHA1 of specific 
files of a tree can be *used* for anything), so the above would be

-rw-r--r-- Makefile

which most newbies should grok fairly quickly. Not least because it's 
familiar, and we can even toss in the size in that string without taking 
up too much screen real estate. If we try really hard to cater to people 
who have never seen ls output we're gonna end up annoying the other side 
of the camp so much that they'll walk away in disgust.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
