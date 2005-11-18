From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 1/5] Library code for user-relative paths, take three.
Date: Fri, 18 Nov 2005 11:14:22 +0100
Message-ID: <437DA97E.20203@op5.se>
References: <20051117193714.2B8995BF93@nox.op5.se> <7v8xvmsu9o.fsf@assigned-by-dhcp.cox.net> <437DA828.6020207@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 11:15:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ed3GF-0000W9-0s
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 11:14:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030603AbVKRKOY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 05:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030604AbVKRKOY
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 05:14:24 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:13277 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1030603AbVKRKOY
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 05:14:24 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id F18756BD02; Fri, 18 Nov 2005 11:14:22 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
In-Reply-To: <437DA828.6020207@op5.se>
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12219>

Andreas Ericsson wrote:
> Junio C Hamano wrote:
> 
>>
>>> +    /* This is perfectly safe, and people tend to think of the 
>>> directory
>>> +     * where they ran git-init-db as their repository, so humour 
>>> them. */
>>> +    (void)chdir(".git");
>>
>>
>>
>> It might be safe, but I think it changes the behaviour of
>> upload-pack with strict case.  My gut reaction is we would want
>> "if (!strict)" in front.  Thoughts?
>>
> 
> As it says in the comment; People tend to think of the directory where 
> they ran "git init-db" as their repository, so humour them. It's nice 
> for sharing files between devs in the office, and it *is* safe. Do as 
> you please though. It's the generality of the
> 

Butter-fingers be me. Sorry about that.

What I meant to say was that:

"it's the general idea of the patchset I'm after".

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
