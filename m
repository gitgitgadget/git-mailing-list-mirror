From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 7/7] make "git fetch" update all fetch repositories
Date: Tue, 29 Apr 2008 10:48:54 +0200
Message-ID: <4816E0F6.3030302@op5.se>
References: <cover.1209391614.git.bonzini@gnu.org> <55a4068681841e6c3579f4183b469fc7aa4de266.1209391615.git.bonzini@gnu.org> <20080428181012.GB6710@steel.home> <48161544.90500@gnu.org> <20080428213339.GC10600@steel.home> <4816A989.2010204@gnu.org> <20080429053814.GA3332@steel.home> <4816C527.4000406@gnu.org> <4816CB46.1050100@op5.se> <4816D505.1000208@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	spearce@spearce.org, gitster@pobox.com, peff@peff.net,
	johannes.schindelin@gmx.de, srb@cuci.nl
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 10:50:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqlX5-0001NY-GQ
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 10:49:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752940AbYD2ItB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 04:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbYD2ItB
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 04:49:01 -0400
Received: from mail.op5.se ([193.201.96.20]:36511 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751306AbYD2ItA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 04:49:00 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 7844C1F08088;
	Tue, 29 Apr 2008 10:49:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1Q7xpdjGcD4Q; Tue, 29 Apr 2008 10:49:00 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.27])
	by mail.op5.se (Postfix) with ESMTP id 10D0E1F08085;
	Tue, 29 Apr 2008 10:48:59 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
In-Reply-To: <4816D505.1000208@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80670>

Paolo Bonzini wrote:
> 
>>> Man, that's what release notes are for.  You are expected to read those.
>>
>> So you actually read the release-notes for every application you have
>> installed?
> 
> Not for every one, but I do for some applications.  Right now only git 
> and autoconf come to mind.  Especially searching for the magic words 
> "backwards incompatible" -- the more "power user" you are of an 
> application, the more you should read the release notes.  And in the 
> case of git I don't consider myself a power user but I learnt quite a 
> few tricks from the release notes.
> 
>> Remind me to never employ you. I doubt you'd ever get any
>> work done.
> 
> Well, the same should apply to reading mailing lists...
> 
>> Failing that, would you get slightly annoyed, or perhaps even quite
>> vexed if you find out that insert-program-used-to-do-some-work-with-here
>> did omething stupid that made you lose some of your work?
> 
> Sorry, how does the patch make you lose some of your work (as opposed to 
> some of your time, which is possible as is the case for every backwards 
> incompatible change)?
> 

Because I will lose some of the refs and then have to dig them up in the
reflog.

> 1) what about the reflog?
> 

I'm not comfortable with the reflog. I appreciate its usefulness, but I'm
thoroughly unhappy when I'm forced to use it.

> 2) the patch does not touch refs/heads/* unless you are tweaking your 
> configuration (and quite heavily so).  IMHO that's using enough rope 
> that you really ought to know about the reflog and... look for backwards 
> incompatible changes in the release notes!
> 

No, but it does touch refs/remotes/*/heads

> 3) your complaint was that it gave errors.  Alex did talk about losing 
> his work, but questions 1 and 2 would apply to him too.
> 
> 4) one man's stupidity is another man's... [fill in]  In particular, did 
> you understand the rationale for this change?  Do you have any 
> alternative ideas?
> 

Yes, I understand the rationale, and I do have an alternative idea, which
is to make it configurable. Now that I think about it, it's probably useful
to have it togglable via command-line switch as well. Something along the
lines of "git fetch --all-remotes", perhaps. I'm not against the idea as
such. I'm against making it the default.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
