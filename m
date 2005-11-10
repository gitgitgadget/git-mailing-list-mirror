From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Add --pretty=fuller
Date: Thu, 10 Nov 2005 10:11:25 +0100
Message-ID: <43730EBD.90307@op5.se>
References: <7vzmod58ot.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 10:13:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ea8Sw-0006cz-G7
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 10:11:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbVKJJL1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 04:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750703AbVKJJL0
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 04:11:26 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:26003 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1750702AbVKJJL0
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2005 04:11:26 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 5A5266BCFF
	for <git@vger.kernel.org>; Thu, 10 Nov 2005 10:11:25 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
In-Reply-To: <7vzmod58ot.fsf@assigned-by-dhcp.cox.net>
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11472>

Junio C Hamano wrote:
> git log without --pretty showed author and author-date, while
> with --pretty=full showed author and committer but no dates.
> The new formatting option, --pretty=fuller, shows both name and
> timestamp for author and committer.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>
> 
> ---
> 
>  * again, likes, dislikes, don't-cares?
> 

Why not use:

--show=cdm,atn

for
Committer: date, mail
Author: timestamp,name

or

--show-author=date,timestamp,name
--show-committer=name,time
--show=name,date (for both author and committer)

or some such, with --pretty=<something> just a short-hand for those 
show-options?

We'll run out of superlatives really quickly if there are more author 
and committer info added sometime in the future, while the --show 
flag(s) can be extended more or less indefinitely.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
