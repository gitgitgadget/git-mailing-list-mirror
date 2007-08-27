From: Andreas Ericsson <ae@op5.se>
Subject: Re: new to git
Date: Mon, 27 Aug 2007 23:14:04 +0200
Message-ID: <46D33E9C.8000000@op5.se>
References: <46D32973.8030104@krose.org> <46D33290.20405@op5.se> <7vabsczp94.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Kyle Rose <krose@krose.org>, git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 28 00:46:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPm4r-0003tf-SE
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 23:26:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759607AbXH0VOK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 17:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759315AbXH0VOK
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 17:14:10 -0400
Received: from mail.op5.se ([193.201.96.20]:52039 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758107AbXH0VOH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 17:14:07 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id A84F81943E5;
	Mon, 27 Aug 2007 23:14:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.000, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QPnN23KjDIjS; Mon, 27 Aug 2007 23:14:06 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id DA166194014;
	Mon, 27 Aug 2007 23:14:05 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <7vabsczp94.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56887>

Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
>> git pull = git fetch + git merge. The notation you use above is obsoleted
>> and no longer works in git 1.5.3. Instead you'd have to replace
>>
>> 	git pull . foo
>>
>> with
>>
>> 	git merge foo
>>
>> which will most likely clear up some confusion.
> 
> Huh?  "git pull . foo" has always been the same as "git merge
> foo", I thought...  Have we broken anything?
> 

Possibly. I noticed some weeks ago that "pull . branch" no longer
worked and used merge instead. I shrugged it off as being of no
moment, and can't recall if there were any real reasons for
the merge to fail.

>>>
>> Here I'm clueless, except that this matches old syntax which is no longer
>> valid.
> 
> Huh again about "no longer valid" part.
> 
> In any case, the former says "I am on foo branch, and I want to
> merge 'master' from _MY_ local repository".  The latter says "I
> want to update the local branch 'foo' with what is in my
> 'master' branch, both local".  They are totally different.
> 
> Please do _not_ spread backward incompatibility FUD.

My apologies. I'll have to see if I can find what caused my own
confusion in the first place.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
