From: Andreas Ericsson <ae@op5.se>
Subject: Re: Something wrong with pickaxe?
Date: Thu, 19 Jan 2006 10:12:54 +0100
Message-ID: <43CF5816.1010004@op5.se>
References: <Pine.LNX.4.63.0601190004130.15298@wbgn013.biozentrum.uni-wuerzburg.de>	<Pine.LNX.4.64.0601181541150.3240@g5.osdl.org> <7v3bjlt66q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Jan 19 10:13:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzVqm-0003nn-Oj
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 10:13:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbWASJM6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 04:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751047AbWASJM6
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 04:12:58 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:64739 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1750826AbWASJM5
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2006 04:12:57 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id C1A9E6BD03; Thu, 19 Jan 2006 10:12:54 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3bjlt66q.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14894>

Junio C Hamano wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> 
>>... Junio would be open to 
>>more friendly pickaxe semantics if the suggested semantics change was 
>>accompanied by an actual diff to implement them.
> 
> 
> True again.  It is hard to be "more friendly" without actually
> generating a diff ;-).
> 

I thought generating diffs was fairly cheap. I agree with Linus somewhat 
though. I've been puzzled more than once with the pickaxe behaviour when 
I give it a function name to search for and want to know when the 
calling semantics changed for that function. I usually also end up doing 
a whatchanged -p and search it.

It would be neat if the current behaviour could be kept with 
--pickaxe-exact but all commits containing changes to lines matching the 
string was returned by default. Or possibly --pickaxe-thourough to do 
the other way around.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
