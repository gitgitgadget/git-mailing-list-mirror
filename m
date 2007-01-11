From: Andreas Ericsson <ae@op5.se>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 11 Jan 2007 17:00:21 +0100
Message-ID: <45A65F15.6040606@op5.se>
References: <7vr6u3cmsi.fsf@assigned-by-dhcp.cox.net> <7v3b6i75i5.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701102241230.4964@xanadu.home> <20070111080035.GA28222@spearce.org> <45A6016B.4030800@op5.se> <Pine.LNX.4.64.0701110955100.4964@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 17:00:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H52Lr-0000qH-In
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 17:00:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbXAKQAX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 11:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbXAKQAX
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 11:00:23 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:56888 "EHLO
	smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbXAKQAX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 11:00:23 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 9209E6BCBC; Thu, 11 Jan 2007 17:00:21 +0100 (CET)
User-Agent: Thunderbird 1.5.0.9 (X11/20070102)
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0701110955100.4964@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36596>

Nicolas Pitre wrote:
> On Thu, 11 Jan 2007, Andreas Ericsson wrote:
> 
>> Shawn O. Pearce wrote:
>>> Where we really get hit is the large number of possible tags.  The
>>> master branch is turning up 14 tags, some dating back to v1.4.1-rc1.
>>> I do try to abort the revision list as soon as one of those tags
>>> cannot give me a better selection than the one I have currently,
>>> but I still had to generate a revision list to reach that point.
>>>
>> It could be worth skipping tags more than 6 months older than current
>> branch-head. That would, at least for the git case, cut the number of tags
>> down by a considerable amount.
> 
> This is bound to be wrong in some cases if a project is very active with 
> many tags, or if there was a long period of inactivity. And what would 
> be the benefit?  Saving 250ms on git-describe output latency?
> 

Output latency will grow with number of tags though, won't it? I was 
thinking of the repo which users had reported problems fetching tags 
from, as there was more than 2k tags. If my memory serves me correctly, 
this report led to the packed-refs stuff.

Unless there's some bogosity going on that leads to it finding the 14 
tags in the above case.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
