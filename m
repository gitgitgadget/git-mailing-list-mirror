From: Andreas Ericsson <ae@op5.se>
Subject: Re: git-send-mail in sh
Date: Mon, 28 Nov 2005 10:02:24 +0100
Message-ID: <438AC7A0.7030407@op5.se>
References: <4386DD45.6030308@op5.se> <20051125163358.GF16995@mythryan2.michonline.com> <43874415.8040302@op5.se> <438A5401.3070008@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Nov 28 10:03:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Egeu8-0004YJ-TW
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 10:02:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbVK1JC0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 04:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbVK1JC0
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 04:02:26 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:16552 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751256AbVK1JC0
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2005 04:02:26 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id BFD6C6BCBE
	for <git@vger.kernel.org>; Mon, 28 Nov 2005 10:02:24 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <438A5401.3070008@michonline.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12862>

Ryan Anderson wrote:
> Andreas Ericsson wrote:
> 
>>When I try to install Email::Valid (using apt) it wants an additional
>>two modules. Mail::Sendmail wants one other, so that's Data::Dumper, the
>>two actually used and the three those two use. Six, for short.
> 
> 
> Can I ask why you aren't willing to install packages, such as those?  I
> can understand a reluctance to install modules directly from CPAN, on an
> otherwise package-managed system, but I'm afraid I must confess to
> puzzlement over a reluctance to use pre-packaged modules.
> 

I don't like having lots of junk installed. Besides, I do a lot of 
development work for the Openwall distro which tries fairly hard to get 
away without installing lots of cruft. I'd rather not taint it with 
packages from other vendors since I do a fair amount of RPM building and 
testing on it but I still want to be able to use git on it.


> The major flaw in git-send-email, from my perspective, was a lack of
> support for SMTP AUTH, for situations like Junio's, where the local MTA
> (and thus "mail" as well) are not configured to handle SMTP AUTH. Moving
> to a purely shell based replacement seems to make this an even harder
> feature to support.  (Though, admittedly, I haven't even made an attempt
> to add it to the Perl version yet.)
> 

By "local" do you mean "local on Junio's laptop" or "local at cox.net"?

"mail" uses the "local on Junio's laptop" SMTP server so he can 
configure it any way he wants.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
