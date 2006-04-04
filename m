From: Andreas Ericsson <ae@op5.se>
Subject: Re: n-heads and patch dependency chains
Date: Tue, 04 Apr 2006 11:28:50 +0200
Message-ID: <44323C52.2030803@op5.se>
References: <4430D352.4010707@vilain.net> <7vsloucuxk.fsf@assigned-by-dhcp.cox.net> <4431B60E.3030008@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 04 11:29:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQhqW-0002fp-Rq
	for gcvg-git@gmane.org; Tue, 04 Apr 2006 11:29:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbWDDJ2x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Apr 2006 05:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbWDDJ2w
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Apr 2006 05:28:52 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:25032 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932417AbWDDJ2v
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 4 Apr 2006 05:28:51 -0400
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 7C4936BD01; Tue,  4 Apr 2006 11:28:50 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Sam Vilain <sam@vilain.net>
In-Reply-To: <4431B60E.3030008@vilain.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18381>

Sam Vilain wrote:
> Junio C Hamano wrote:
> 
>>For example, the point jdl raised during the discussion is far
>>easier to understand.  When working on multiple topics, he often
>>needs to test them as a whole, so he pulls them into a test
>>branch (can be a throwaway branch).  When he needs to do fixups,
>>it is most efficient to do compile/run test while still in the
>>test branch, but after things test out, in order to keep
>>logically different things separate, he needs to go back to
>>relevant topic branches and make a commit.  This is painful --
>>are there ways to make this easier [*2*]?
>>
>>Would patch commutation calculus help with his problem?
>> 
>>
> 
> 
> I'd provisionally say "yes, that's the fit". It's just like having
> multiple topic branches all checked out at once, with commits going to
> the appropriate branch as necessary.
> 


Wouldn't "git commit -M -b topic", for committing to a different branch 
than what is checked out (-b) and also to the checked out branch (-M) 
have the same beneficial effects, but without the complexity of hydras 
and patch dependency theory? It would only remove the cherry-pick stage 
though, but perhaps it's good enough. Although when I think about it, -b 
<branch> for committing to another branch and -B <branch> for doing the 
above probably makes more sense.

Those flags don't exist currently btw, in case someone's reading this on 
the archives.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
