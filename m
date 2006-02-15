From: Andreas Ericsson <ae@op5.se>
Subject: Re: several quick questions
Date: Wed, 15 Feb 2006 10:06:17 +0100
Message-ID: <43F2EF09.5060603@op5.se>
References: <43F20532.5000609@iaglans.de>	<Pine.LNX.4.64.0602141026570.3691@g5.osdl.org>	<87fymlvgzv.wl%cworth@cworth.org>	<200602142230.11442.Josef.Weidendorfer@gmx.de>	<7v7j7xr54u.fsf@assigned-by-dhcp.cox.net> <43F26129.4040804@op5.se> <7vwtfxm917.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 15 10:06:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9IcD-0006Ef-JO
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 10:06:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423054AbWBOJGU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Feb 2006 04:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423056AbWBOJGU
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Feb 2006 04:06:20 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:20358 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1423054AbWBOJGT
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2006 04:06:19 -0500
Received: from [192.168.1.20] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id F023E6BCFF; Wed, 15 Feb 2006 10:06:17 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtfxm917.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16225>

Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
> 
>>Junio C Hamano wrote:
>>
>>
>>>Now, read-only ref does not interest me, but "do not commit on
>>>top of this yourself, only fast-forward from somewhere else is
>>>allowed" may be useful, for the reason why you mentioned
>>>"origin".
>>
>>Do my suggestion and you wouldn't have to worry about read-only
>>branches, and although merging any changes from it might be more
>>trouble than its worth, it might be possible to cherry-pick the commit
>>rather than reverting and re-applying it.
> 
> 
> Sorry, is this "do my suggestion" a solution to my "do not
> commit on top of this yourself, only fast-forward from somewhere
> else is allowed -- e.g. to protect 'origin'" issue, or is it
> something completely different?
> 

The "git checkout -b foo HEAD~15", which was already supported, although 
I missed that. All programmers have names to use just for throwaway 
variables (never heard "frotz" and "nitfol" before though), so adding 
the burden of selecting a name for the throw-away search branch 
shouldn't be too hard on them. Then it would be possible to commit to 
it, and merge or cherry-pick from it later. It's usually preferrable to 
amend to a broken patch than to revert it completely.

In essence, I claim that git-seek is superfluous and inferior to "git 
checkout -b foo <commit-ish>" and shouldn't be implemented. If anyone 
wants to distribute the source to non-scm people as per a given point in 
the history I think "git tar-tree" works marvelously as is.

The good thing about being past 1.0 in a project is that it's 
feature-complete, or close to. The bad thing is that bloat usually 
starts to happen around 1.1.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
