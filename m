From: Andreas Ericsson <ae@op5.se>
Subject: Re: Using the --track option when creating a branch
Date: Thu, 30 Oct 2008 16:25:50 +0100
Message-ID: <4909D1FE.2080403@op5.se>
References: <18696.32778.842933.486171@lisa.zopyra.com> <1225343538.10803.9.camel@maia.lan> <18697.41702.241183.408377@lisa.zopyra.com> <18697.42140.459170.891195@lisa.zopyra.com> <4909A7C4.30507@op5.se> <2008-10-30-14-52-52+trackit+sam@rfc1149.net> <4909BF58.9010500@op5.se> <2008-10-30-15-23-16+trackit+sam@rfc1149.net> <4909CABD.1040708@op5.se> <2008-10-30-16-04-08+trackit+sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Samuel Tardieu <sam@rfc1149.net>
X-From: git-owner@vger.kernel.org Thu Oct 30 16:36:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvZZI-0004a3-96
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 16:36:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753583AbYJ3PfA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 11:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753528AbYJ3PfA
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 11:35:00 -0400
Received: from mail.op5.se ([193.201.96.20]:54708 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753384AbYJ3Pe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 11:34:59 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id CF6001B800A6;
	Thu, 30 Oct 2008 16:20:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bXRdY9mkAYS9; Thu, 30 Oct 2008 16:20:26 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id BDE5D1B80087;
	Thu, 30 Oct 2008 16:20:25 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <2008-10-30-16-04-08+trackit+sam@rfc1149.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99488>

Samuel Tardieu wrote:
> * Andreas Ericsson <ae@op5.se> [2008-10-30 15:54:53 +0100]
> 
>> Correct me if I'm wrong, but wouldn't my suggestion of not trying to
>> push (even matching) branches that haven't been updated since we last
>> fetched from the remote do exactly the same thing for your particular
>> use-case, but without syntax change and all the annoying minor parts
>> that it entails?
> 
> Not exactly. I often do some work on a branch which does not mandate
> a topic branch and have to switch branches to fix a bug for example.
> This would continue to push unterminated changes as well.
> 
> Typical use case, which happens (to me) quite frequently:
> 

...

>
> Argh, "master" has been pushed as well. Ok, I could have done
> 

Ah, I see. I sympathize, although I really do think you'd be
better off by learning to explicitly push things.

>   % git branch
>     (because I know I am on the right branch but do not necessarily
>      remember its full name all the time)

offtopic: Use shell-completion and set your PS1 to include the __git_ps1
output.

>   % git push origin 2.0-beta1-release-candidate
> 
> or I could have started a topic branch, but I often push 2 or 3
> commits at a time instead, the first one being a refactoring of
> existing code to ease the subsequent one.
> 

I fail to see why this would prevent you from starting a topic-branch.
In fact, I would have thought it was a reason *for* starting a topic.

>>From what I have seen, people I am working with often have the
> same workflow (do not systematically start a topic branch when
> in active development mode)
> 
>> Define "many". Perhaps as often as 2-3 times per day. Not very often,
>> but frequent enough that I definitely want some short sweet way of
>> doing it. OTOH, I also find the "rejected" messages annoying, and I
>> definitely feel one could do something about them. However, it's my
>> birthday today and I plan on being far too drunk/hungover the entire
>> weekend for me to take any actions in that direction.
> 
> Happy birthday :)
> 

Thank you :-)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
