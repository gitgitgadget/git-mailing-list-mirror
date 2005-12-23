From: Andreas Ericsson <ae@op5.se>
Subject: Re: git /objects directory created 755 by default?
Date: Fri, 23 Dec 2005 13:07:53 +0100
Message-ID: <43ABE899.6030002@op5.se>
References: <46a038f90512201525k5eb7cf62u65de2cd51424df37@mail.gmail.com>	<7vacevgwqr.fsf@assigned-by-dhcp.cox.net>	<7vlkyffcxp.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.63.0512211502130.25834@wbgn013.biozentrum.uni-wuerzburg.de>	<7vek465cev.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.63.0512212317400.18684@wbgn013.biozentrum.uni-wuerzburg.de>	<43AA75D1.7040009@op5.se>	<Pine.LNX.4.63.0512221220220.7112@wbgn013.biozentrum.uni-wuerzburg.de>	<43AA9BE6.7000601@op5.se> <7vslsllz17.fsf@totally-fudged-out-message-id>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 23 13:08:17 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpliX-0004pu-LF
	for gcvg-git@gmane.org; Fri, 23 Dec 2005 13:08:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030493AbVLWMHz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Dec 2005 07:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030509AbVLWMHz
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Dec 2005 07:07:55 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:8332 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S1030493AbVLWMHz (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Dec 2005 07:07:55 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 2A1956BD22; Fri, 23 Dec 2005 13:07:54 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslsllz17.fsf@totally-fudged-out-message-id>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13991>

Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
> 
>>Ahh. Sorry. We use this method a lot, really, but always only for 
>>running gitk and archaeology tools to check newly pushed changes, so the 
>>write-shared repo is only write-shared for remote users, and the local 
>>one never does a commit.
> 
> 
> Do you need a working tree to run gitk?
> 

No, but it makes for a nice shorthand, especially since most of our 
projects are riddled with sub-repos.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
