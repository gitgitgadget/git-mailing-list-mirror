From: Andreas Ericsson <ae@op5.se>
Subject: Re: Problem with https and git-pull
Date: Thu, 08 Nov 2007 10:37:07 +0100
Message-ID: <4732D8C3.4080300@op5.se>
References: <4732BDE6.4020509@vidanti.com> <4732BEDD.3010703@vidanti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Luke Diamand <luke@vidanti.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 10:37:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq3pI-0004EP-Gr
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 10:37:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758214AbXKHJhN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 04:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757652AbXKHJhN
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 04:37:13 -0500
Received: from mail.op5.se ([193.201.96.20]:42041 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757627AbXKHJhL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 04:37:11 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 85DC11F08709;
	Thu,  8 Nov 2007 10:37:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[AWL=0.000, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EKpjobIwrfXh; Thu,  8 Nov 2007 10:37:08 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 300001F0870D;
	Thu,  8 Nov 2007 10:37:08 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <4732BEDD.3010703@vidanti.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63979>

Luke Diamand wrote:
> OK, I just read the FAQ.
> 

... and found that "git update-server-info" needs to be run on the remote
side in order for dumb protocols (http, rsync, ftp...) to work.

Directed at any poor soul who finds this solution in the mailing list
archives before posting to the list. Hello there, poor soul ;-)

> Luke Diamand wrote:
>> I'm finding that git-pull using https does not work in the way I would 
>> expect.
>>
>> I created a bare repository, test.git, available by https://
>>
>> I then cloned it:
>>
>> % git-clone https://host/git/test.git
>>
>> So far, so good.
>>
>> Then I made a change in a different clone and pushed it.
>>
>> When I next did git-pull it just said:
>>
>> % git-pull
>> Fetching refs/heads/master from https://host/git/test.git using https
>> Already up-to-date.
>>
>> But it *isn't* up-to-date! If I do the same exercise with git:// or 
>> ssh:// on the same repo then it pulls down my changes as expected.
>>
>> Tried with:
>>   git version 1.5.3.4 (debian testing)
>>   git 1.5.3.5-dirty
>>
>> curl is 7.16.4
>>
>> The server access log shows the git-pull happening, and there are no 
>> errors reported by the server.
>>
>> Is there something obvious I'm missing?
>>
>> Thanks
>> Luke
>>
>>
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
