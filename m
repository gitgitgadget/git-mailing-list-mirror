From: Andreas Ericsson <ae@op5.se>
Subject: Re: n-heads and patch dependency chains
Date: Fri, 21 Apr 2006 10:50:44 +0200
Message-ID: <44489CE4.1050101@op5.se>
References: <4430D352.4010707@vilain.net>	<7vsloucuxk.fsf@assigned-by-dhcp.cox.net>	<4431B60E.3030008@vilain.net> <44323C52.2030803@op5.se>	<e0tjpk$ktu$1@sea.gmane.org> <44325CDB.2000101@op5.se>	<1145556505.5314.149.camel@cashmere.sps.mot.com> <7v4q0oyt3w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 21 10:51:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWrLl-0005YJ-Uf
	for gcvg-git@gmane.org; Fri, 21 Apr 2006 10:50:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbWDUIur (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Apr 2006 04:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbWDUIur
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Apr 2006 04:50:47 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:13527 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1750866AbWDUIuq
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Apr 2006 04:50:46 -0400
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 1FA156BCC0; Fri, 21 Apr 2006 10:50:45 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4q0oyt3w.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19018>

Junio C Hamano wrote:
> Jon Loeliger <jdl@freescale.com> writes:
> 
> 
>>On Tue, 2006-04-04 at 06:47, Andreas Ericsson wrote:
>>
>>
>>>No, I mean that this would commit both to the testing branch (being the 
>>>result of several merged topic-branches) and to the topic-branch merged 
>>>in. Commit as in regular commit, with a commit-message and a patch. The 
>>>resulting repository would be the exact same as if the change was 
>>>committed only to the topic-branch and then cherry-picked on to the 
>>>testing-branch.
> 
> 
> To be consistent, I think the result should be "as if the change
> was commited only to the topic-branch and then the topic-branch
> was *merged* into the testing-branch", since you start your
> testing branch as "being the result of several merged topic-branches".
> 
> I do that (manually) all the time, with:
> 
> 	$ git checkout next
>         $ hack hack hack
> 
>         $ git checkout -m one/topic
>         $ git commit -o this-path that-path
>         $ git checkout next
>         $ git pull . one/topic
> 
> Giving a short-hand for the last four-command sequence would
> certainly be nice.
> 

Ah. That's easier than what I originally looked at doing.

> 
>>I am your number one fan!  If I finish reading these 600+
>>messages, will I find out you have already implemented it,
>>it's committed, and you just need me to test it now? :-)
> 
> 
> Likewise... ;-)
> 

Sorry to disappoint you so far. I'll see if I can turn up my 
shell-skills a notch or two and get the hang of the commit-script enough 
to implement it.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
