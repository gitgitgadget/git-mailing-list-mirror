From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH v2] Teach 'git pull' about --rebase
Date: Thu, 29 Nov 2007 09:36:00 +0100
Message-ID: <474E79F0.4080101@op5.se>
References: <7v3avy21il.fsf@gitster.siamese.dyndns.org>	<Pine.LNX.4.64.0710261047450.4362@racer.site>	<7v3aurcjpq.fsf@gitster.siamese.dyndns.org>	<Pine.LNX.4.64.0711281307420.27959@racer.site>	<27E5EF3C-19EF-441C-BB12-0F5B29BEAEDB@midwinter.com>	<Pine.LNX.4.64.0711282039430.27959@racer.site>	<8c5c35580711281310h8764a33pba48e65010abf859@mail.gmail.com>	<7vhcj63uhw.fsf@gitster.siamese.dyndns.org>	<Pine.LNX.4.64.0711282156520.27959@racer.site>	<20071128223339.GF7376@fieldses.org>	<20071128224717.GG7376@fieldses.org>	<Pine.LNX.4.64.0711282309030.27959@racer.site> <7v1waa2bfi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Lars Hjemli <hjemli@gmail.com>,
	Steven Grimm <koreth@midwinter.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 09:36:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ixesm-0004fA-C6
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 09:36:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754823AbXK2IgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 03:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754587AbXK2IgH
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 03:36:07 -0500
Received: from mail.op5.se ([193.201.96.20]:58232 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751451AbXK2IgG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 03:36:06 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id AC3E81F08070;
	Thu, 29 Nov 2007 09:36:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g-BhyAPV7Twe; Thu, 29 Nov 2007 09:36:03 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 2F5251F08004;
	Thu, 29 Nov 2007 09:36:03 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <7v1waa2bfi.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66518>

Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>> So my rationale was: if we already have an existing framework to integrate 
>> remote changes with our current branch, why not just go ahead and use it?  
>> That's the reason BTW why I originally wanted a "rebase" merge stragegy.  
>> Even if it is not technically a merge.
>>
>> I really rather have no user-friendly support for fetch+rebase (and utter 
>> a friendly, but loud curse everytime I made a "git pull" by mistake) than 
>> yet another command.
> 
> I suspect that people who do not like the two modes of checkout will
> certainly not appreciate the overloading two behaviours to create
> different kind of histories and two different ways to continue when the
> integration do not go smoothly upon conflicts these two behaviours have.
> 
> However, I agree very much with an earlier comment made by Daniel about
> our UI being task oriented instead of being command oriented, and I
> actually consider it a good thing.  So it does not bother me too much
> that "git pull --rebase" has a quite different workflow from the regular
> "merge" kind of pull.
> 
> So let's queue "pull --rebase" and see what happens.
> 

I've used the --rebase option to git pull, explained it to my co-workers
and also made sure they're using a version of git that has it. So far
there hasn't been a single complaint about "git pull" being any harder
to grok.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
