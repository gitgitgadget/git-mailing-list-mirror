From: Andreas Ericsson <ae@op5.se>
Subject: Re: Joining Repositories
Date: Wed, 18 Jan 2006 15:14:51 +0100
Message-ID: <43CE4D5B.10604@op5.se>
References: <200601181325.59832.Mathias.Waack@rantzau.de> <20060118125158.GN28365@pasky.or.cz> <20060118125857.GO28365@pasky.or.cz> <200601181501.38791.Mathias.Waack@rantzau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 18 15:15:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzE5Q-0001aS-Qr
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 15:14:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030326AbWAROOx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 09:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030325AbWAROOx
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 09:14:53 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:31453 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1030324AbWAROOw
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2006 09:14:52 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 804A66BCBE; Wed, 18 Jan 2006 15:14:51 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Mathias Waack <Mathias.Waack@rantzau.de>
In-Reply-To: <200601181501.38791.Mathias.Waack@rantzau.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14829>

Mathias Waack wrote:
> Hello Petr, 
> 
> thanks for your quick answer, but...
> 
> On Wednesday 18 January 2006 01:58 pm, Petr Baudis wrote:
> 
>>Dear diary, on Wed, Jan 18, 2006 at 01:51:58PM CET, I got a letter
>>where Petr Baudis <pasky@suse.cz> said that...
>>
>>
>>>  But if you want r1/a, r2/b to turn to r/r1/a, r/r2/b, you will have
>>>to rewrite the history of each (and then do the above). One rough
>>>and untested sketch...
>>>
>>>	mkdir r1-rewritten
>>>	cd r1-rewritten
>>>	cp -a ../r1/.git .
>>
>>	mkdir commitmap
>>
>>
>>>	for commit in $(git-rev-list --topo-order HEAD | tac); do
>>>		git-read-tree --prefix=r1/ $commit
> 
> 
> ...git-read-tree doesn't know the parameter --prefix (just downloaded and 
> tried it on 0.99.9i). What version shall I use?
> 


If you're using 0.99.9i you're missing out on the 584 commits that has 
been committed since then. 1.1.3 was released a couple of days ago. I 
suggest you upgrade.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
