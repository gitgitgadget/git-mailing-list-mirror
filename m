From: Andreas Ericsson <ae@op5.se>
Subject: Re: git-send-mail in sh
Date: Fri, 25 Nov 2005 18:04:21 +0100
Message-ID: <43874415.8040302@op5.se>
References: <4386DD45.6030308@op5.se> <20051125163358.GF16995@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 25 18:06:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Efh0G-0006ON-Em
	for gcvg-git@gmane.org; Fri, 25 Nov 2005 18:04:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161126AbVKYREW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Nov 2005 12:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161127AbVKYREW
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Nov 2005 12:04:22 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:40351 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1161126AbVKYREW
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Nov 2005 12:04:22 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 3CFB16BCBE; Fri, 25 Nov 2005 18:04:21 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <20051125163358.GF16995@mythryan2.michonline.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12742>

Ryan Anderson wrote:
> On Fri, Nov 25, 2005 at 10:45:41AM +0100, Andreas Ericsson wrote:
> 
>>Finally giving up on git-send-email (I won't install the 6 perl-modules 
>>it requires and I don't know perl enough to remove the need for them), I 
>>hacked up a replacement in sh. It's more aptly named as well. ;)
> 
> 
> Scanning the list, 2 are related to option handling (one of which is
> builtin), one isn't used (Data::Dumper), and two are related to sending
> valid emails.


When I try to install Email::Valid (using apt) it wants an additional 
two modules. Mail::Sendmail wants one other, so that's Data::Dumper, the 
two actually used and the three those two use. Six, for short.


> The email address verification is ridiculously hard to get
> correct, so using pre-written code for that seemed justified.
> 

But it isn't necessary to validate it to such exactness. Nothing worse 
will happen than the user chiding himself for his butterfingers if 
he/she makes a mistake.

Besides, I think typos are by far the most common error. Those are 
usually valid email addresses while still not being correct.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
