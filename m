From: Andreas Ericsson <ae@op5.se>
Subject: Re: What's cooking in git.git (topics)
Date: Fri, 02 Nov 2007 10:38:39 +0100
Message-ID: <472AF01F.9030002@op5.se>
References: <20071022063222.GS14735@spearce.org> <7vzly84qwf.fsf@gitster.siamese.dyndns.org> <7vmytycykt.fsf@gitster.siamese.dyndns.org> <alpine.LFD.0.999.0711011129460.3342@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Nov 02 10:39:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InszT-00039g-1D
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 10:38:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770AbXKBJip (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 05:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752831AbXKBJip
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 05:38:45 -0400
Received: from mail.op5.se ([193.201.96.20]:45475 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752534AbXKBJio (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 05:38:44 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id C753E1730733;
	Fri,  2 Nov 2007 10:37:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SajH-caSXFvy; Fri,  2 Nov 2007 10:37:51 +0100 (CET)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id B37BE1730731;
	Fri,  2 Nov 2007 10:37:50 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <alpine.LFD.0.999.0711011129460.3342@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63086>

Linus Torvalds wrote:
> 
> On Wed, 31 Oct 2007, Junio C Hamano wrote:
>> * ph/parseopt (Tue Oct 30 14:15:21 2007 -0500) 23 commits
>>  + ...
>>
>> It appears 1.5.4 will be, to a certain extent, a "Let's clean up
>> the internal implementation" release.  This series should become
>> part of it.  Hopefully will merge to 'master' soon, but I
>> haven't looked this series very closely yet.
> 
> I certainly think this should go in, but it does make one deficiency 
> painfully clear: the remaining shell scripts end up having all the old 
> flags behaviour.
> 
> So while you can combine flags for *most* programs, you still won't 
> be able to say things like
> 
> 	git clean -qdx
> 
> just because that's still a shellscript, and doing any fancy argument 
> parsing in shell is just painful.
> 
> Is somebody still working on doing the shell->C conversion?
> 

Me, although my git work is happening with the speed of continental drift
at the moment.

git-merge and git-pull are (slowly) being converted. It's more in the
nature of a learning experience for me than "oh shit I need this fast"
though. Hence the blazing speed with which I work ;-)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
