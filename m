From: Andreas Ericsson <ae@op5.se>
Subject: Re: git push mirror mode
Date: Thu, 08 Nov 2007 14:48:22 +0100
Message-ID: <473313A6.40401@op5.se>
References: <20071108121136.GG9736@shadowen.org> <Pine.LNX.4.64.0711081218090.4362@racer.site> <20071108124435.GH9736@shadowen.org> <47330BA4.6030101@op5.se> <20071108134432.GK9736@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Andy Whitcroft <apw@shadowen.org>
X-From: git-owner@vger.kernel.org Thu Nov 08 14:48:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq7kR-0001iO-7n
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 14:48:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758110AbXKHNs1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 08:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757875AbXKHNs1
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 08:48:27 -0500
Received: from mail.op5.se ([193.201.96.20]:55702 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757866AbXKHNs0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 08:48:26 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id CC18D1F0870A;
	Thu,  8 Nov 2007 14:47:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XoZjDCoCc4sl; Thu,  8 Nov 2007 14:47:47 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id B4DC11F08708;
	Thu,  8 Nov 2007 14:47:47 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <20071108134432.GK9736@shadowen.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64022>

Andy Whitcroft wrote:
> On Thu, Nov 08, 2007 at 02:14:12PM +0100, Andreas Ericsson wrote:
> 
>> Barring any errors in my understanding of the matter, here's how it
>> works for git.
>>
>> git separates author from committer, so code attribution is done with
>> author, and "I verified this is sane" is done by committer. Those two
>> usually only ever differ when the user tells git commit that the author
>> was someone else than him/her self, or when rewriting history with git
>> rebase or similar. git am also maintains authorship (using the From:
>> line in emails), but sets $committer to the person running it, so when
>> you apply patches sent by email from someone else you get the code
>> attribution right by default.
>>
>> The Signed-off-by line is, in git, used as "I touched the code here and
>> agree that it may be included in the mothership repo and all future
>> releases" (the spirit of that sentence is also in
>> Documentation/SubmittingPatches).
>>
>> We also have Acked-by (as does the kernel, no? I think we inherited it
>> from there) to mean something along the lines of "I vote we include this",
>> but not always based on technical merit (ie, patches can have many acks
>> without having ever been tested).
>>
>> Suggested-by, Tested-by and Reported-by are used less often, not always
>> written in dash-form, but hopefully always self-explanatory ;-)
> 
> What that doesn't tell me is how when sending an email carrying a patch
> one ensures the attribution is correct when loaded into git.
> 

Ach damn. I had a sentence there reading "From: can also be specified in
the email body to attribute code to someone else than the sender." It's
in my clipboard, but I forgot to paste it :-/


> Having messed about with it a bit it does seem that if one wants git to
> attribute the patch to junio I have to add a From: line to the top of
> the email payload.
> 
> I'll resend so attributed.
> 

Thanks.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
