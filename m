From: Andreas Ericsson <ae@op5.se>
Subject: Re: [FEATURE REQUEST] git clone, just clone selected branches?
Date: Thu, 11 Oct 2007 11:18:38 +0200
Message-ID: <470DEA6E.5020107@op5.se>
References: <011c01c80b85$a0d8d560$04ac10ac@Jocke>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: 'Linus Torvalds' <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
X-From: git-owner@vger.kernel.org Thu Oct 11 11:19:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfuC7-0007EB-MC
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 11:19:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756867AbXJKJSy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 05:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756854AbXJKJSy
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 05:18:54 -0400
Received: from mail.op5.se ([193.201.96.20]:47520 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756824AbXJKJSx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 05:18:53 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id B8C961730684;
	Thu, 11 Oct 2007 11:18:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rjlTXf7xXfHc; Thu, 11 Oct 2007 11:18:30 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id CF9C2173069D;
	Thu, 11 Oct 2007 11:18:28 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <011c01c80b85$a0d8d560$04ac10ac@Jocke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60588>

Joakim Tjernlund wrote:
>> -----Original Message-----
>> From: Linus Torvalds [mailto:torvalds@linux-foundation.org] 
>> Sent: den 10 oktober 2007 21:38
>> To: Joakim Tjernlund
>> Cc: git@vger.kernel.org
>> Subject: Re: [FEATURE REQUEST] git clone, just clone selected 
>> branches?
>>
>>
>>
>> On Wed, 10 Oct 2007, Joakim Tjernlund wrote:
>>> I know I can use git remote to do this, but it is a bit clumsy 
>>> when starting a new repo.
>> How about just
>>
>> 	git init
>> 	.. set up remote tracking info in .git/config ..
>> 	git fetch remote
>>
>> which should do what you want.
>>
>> 		Linus
> 
> From git remote man page:
>  o  Imitate git clone but track only selected branches
> 
>           $ mkdir project.git
>           $ cd project.git
>           $ git init
>           $ git remote add -f -t master -m master origin git://example.com/git.git/
>           $ git merge origin
> 
> yes, this does the trick too but that is more to type so I thought
> it would be simpler if I could just tell git clone which branches I want.
> Now, this isn't a killer feature to me so if you don't like it, I good
> with that too.
> 

Well, that's how git-clone should probably look, now that git-remote exists.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
