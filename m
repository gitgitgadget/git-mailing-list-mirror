From: Andreas Ericsson <ae@op5.se>
Subject: Re: git /objects directory created 755 by default?
Date: Thu, 22 Dec 2005 10:45:53 +0100
Message-ID: <43AA75D1.7040009@op5.se>
References: <46a038f90512201525k5eb7cf62u65de2cd51424df37@mail.gmail.com> <7vacevgwqr.fsf@assigned-by-dhcp.cox.net> <7vlkyffcxp.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0512211502130.25834@wbgn013.biozentrum.uni-wuerzburg.de> <7vek465cev.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0512212317400.18684@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Dec 22 10:46:04 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpN1J-0007DF-Qj
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 10:45:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965148AbVLVJpz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Dec 2005 04:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965149AbVLVJpz
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Dec 2005 04:45:55 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:47744 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S965148AbVLVJpy
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2005 04:45:54 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id A6FFA6BD02
	for <git@vger.kernel.org>; Thu, 22 Dec 2005 10:45:53 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0512212317400.18684@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13937>

Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 21 Dec 2005, Junio C Hamano wrote:
> 
> 
>>Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>>
>>>If you don't use git-shell, because the same machine is used for other 
>>>purposes, it makes sense to introduce
>>>
>>>	[core]
>>>		umask = 0002
>>
>>I agree the setting should not be limited to git-shell, but I do
>>not think setting "umask" from git configuration is the right
>>way either.  For files and directories under $GIT_DIR, maybe
>>imposing the policy git configuration file has is OK, but I
>>think honoring the user's umask is the right thing for working
>>tree files.
> 
> 
> As we worked out in another thread, you should not have a working 
> directory when you write-share the repository.
> 

Which thread was that? I see no particular problem with having a working 
directory in a write-shared repo. The same care has to be taken there as 
everywhere (pull before push), but that's nothing new.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
