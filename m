From: Andreas Ericsson <ae@op5.se>
Subject: Re: Using the --track option when creating a branch
Date: Thu, 30 Oct 2008 15:54:53 +0100
Message-ID: <4909CABD.1040708@op5.se>
References: <18696.32778.842933.486171@lisa.zopyra.com> <1225343538.10803.9.camel@maia.lan> <18697.41702.241183.408377@lisa.zopyra.com> <18697.42140.459170.891195@lisa.zopyra.com> <4909A7C4.30507@op5.se> <2008-10-30-14-52-52+trackit+sam@rfc1149.net> <4909BF58.9010500@op5.se> <2008-10-30-15-23-16+trackit+sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Samuel Tardieu <sam@rfc1149.net>
X-From: git-owner@vger.kernel.org Thu Oct 30 15:56:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvYwc-0006Et-UM
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 15:56:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755074AbYJ3OzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 10:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754928AbYJ3OzE
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 10:55:04 -0400
Received: from mail.op5.se ([193.201.96.20]:42403 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754819AbYJ3OzC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 10:55:02 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id EB9D91B80087;
	Thu, 30 Oct 2008 15:49:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JCqe6hkQQnnz; Thu, 30 Oct 2008 15:49:28 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 79F201B80051;
	Thu, 30 Oct 2008 15:49:28 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <2008-10-30-15-23-16+trackit+sam@rfc1149.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99477>

Samuel Tardieu wrote:
> * Andreas Ericsson <ae@op5.se> [2008-10-30 15:06:16 +0100]
> 
>> --all pushes all refs, even the non-matching ones, which is very
>> rarely desirable and only accidentally sometimes the same as "push all
>> matching refs".
>>
>>> I know that I've never had the intent to push all the refs without
>>> thinking about it first. Most of the time, I intend to push only
>>> the current branch I am in.
>> Then say so. There's a very simple command syntax for it:
>> "git push <remote> <current-branch>"
> 
> I update the branches I'm working in maybe 20 times a day, sometimes
> more. When I make a change and all the tests pass, I prefer to call
> 
>   git push
> 
> rather than
> 
>   git push origin 2.0-beta1
> 

So why don't you? Unless you also make lots of changes on other branches,
the two commands will result in exactly the same thing.

> (and "2.0-beta1" is a short name here, some branches have much longer
> names)
> 
> I think it would be better to have :
> 
>   git push                <= push the current branch
>   git push --all          <= push all matching refs
>   git push --all --create <= push all matching refs, create if needed
> 

Correct me if I'm wrong, but wouldn't my suggestion of not trying to
push (even matching) branches that haven't been updated since we last
fetched from the remote do exactly the same thing for your particular
use-case, but without syntax change and all the annoying minor parts
that it entails?


> The latest command is probably used so rarely (compared to the others)
> that it wouldn't be a problem to make it longer. Of course, if a
> refspec is given explicitely, it should be honored and remote refs
> created if needed.
> 
> I am curious of what other people workflows are. Do you often push
> multiple branches at the same time?

Quite often, yes.

> More often than one at a time?

No.

> Many times a day?
> 

Define "many". Perhaps as often as 2-3 times per day. Not very often,
but frequent enough that I definitely want some short sweet way of
doing it. OTOH, I also find the "rejected" messages annoying, and I
definitely feel one could do something about them. However, it's my
birthday today and I plan on being far too drunk/hungover the entire
weekend for me to take any actions in that direction.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
