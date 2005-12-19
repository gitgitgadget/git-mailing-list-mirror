From: Andreas Ericsson <ae@op5.se>
Subject: Re: Branches and all commits
Date: Mon, 19 Dec 2005 20:32:13 +0100
Message-ID: <43A70ABD.4090003@op5.se>
References: <Pine.LNX.4.63.0512190908140.6812@gheavc.wnzcbav.cig> <43A6DC90.3040403@op5.se> <Pine.LNX.4.63.0512191104080.6812@gheavc.wnzcbav.cig> <43A6F378.6010503@op5.se> <Pine.LNX.4.63.0512191257240.6812@gheavc.wnzcbav.cig>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Dec 19 20:34:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EoQk5-0000Sj-Sn
	for gcvg-git@gmane.org; Mon, 19 Dec 2005 20:32:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964892AbVLSTcO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Dec 2005 14:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964893AbVLSTcO
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Dec 2005 14:32:14 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:24025 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S964892AbVLSTcO
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2005 14:32:14 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 3F6766BD06
	for <git@vger.kernel.org>; Mon, 19 Dec 2005 20:32:13 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0512191257240.6812@gheavc.wnzcbav.cig>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13833>

Jon Nelson wrote:
> On Mon, 19 Dec 2005, Andreas Ericsson wrote:
> 
>>>I suspect that the root cause was a 'git branch -D' I issued a while back.
>>>My question is this: if deleting a branch in that manner caused me to enter
>>>this situation, is that a bug or no?
>>
>>It's not a bug. You probably meant to do
>>
>>	$ git branch -d
>>
>>-D forces removal even if there are objects reachable only through that
>>branch. The man-page says so, but in git'ish, which isn't always intuitive
>>until you've grown familiar with the glossary.txt doc.
> 
> 
> I tried 'git branch -d' initially and it refused to delete the branch.
> So I tried 'git branch -D'.
> 
> Re-reading your last paragraph makes it clear what happened, then.
> I'll note that I ran 'git branch -D' *days* ago and I've run git-prune 
> literally a couple dozen times since then. Is it possible the objects 
> weren't removed because they were still referenced by tags?
> 

I suppose it must have been, which sort of contradicts how I thought 
tags worked. Lucky thing though, eh? :)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
