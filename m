From: Andreas Ericsson <ae@op5.se>
Subject: Re: Newbie: report of first experience with git-rebase.
Date: Fri, 02 Nov 2007 20:22:18 +0100
Message-ID: <472B78EA.6050502@op5.se>
References: <87d4uv3wh1.fsf@osv.gnss.ru>	<20071031195702.GB24332@atjola.homenet> <874pg73u6h.fsf@osv.gnss.ru>	<Pine.LNX.4.64.0710312111170.4362@racer.site>	<7vhck7gdzs.fsf@gitster.siamese.dyndns.org>	<87ve8m2mfn.fsf@osv.gnss.ru>	<Pine.LNX.4.64.0711011423440.4362@racer.site>	<20071101151016.GA26103@fieldses.org>	<7v8x5hbtvv.fsf@gitster.siamese.dyndns.org> <472AF840.1070609@op5.se> <7vtzo431k8.fsf@gitster.siamese.dyndns.org> <472B77AC.5080507@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sergei Organov <osv@javad.com>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 20:38:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io2LF-0004hp-GE
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 20:38:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754047AbXKBThw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 15:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753698AbXKBThv
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 15:37:51 -0400
Received: from mail.op5.se ([193.201.96.20]:60984 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753282AbXKBThv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 15:37:51 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 94ACB1730733;
	Fri,  2 Nov 2007 20:37:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wIhoDcLQAXZJ; Fri,  2 Nov 2007 20:37:37 +0100 (CET)
Received: from nox.op5.se (unknown [172.27.78.22])
	by mail.op5.se (Postfix) with ESMTP id 512EC173067D;
	Fri,  2 Nov 2007 20:37:37 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <472B77AC.5080507@midwinter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63160>

Steven Grimm wrote:
> Junio C Hamano wrote:
>> Andreas Ericsson <ae@op5.se> writes:
>>  
>>> Make "git rebase --skip" skip patches regardless of tree and index 
>>> state,
>>> but still refuse to *start* with dirty tree or index. That way, there's
>>> no risk of losing anything that can't be re-created unless the user asks
>>> for it.
>>>     
>>
>> Sounds like a plan.
>>   
> 
> I'm unclear how that helps the usability issue here at all, though it 
> doesn't sound like an unreasonable change on its own merit.
> 

Because 'git commit --skip' will not require the user to first edit the
tree so the index matches the upstream thing, and he doesn't have to
manually run 'git reset --hard' before --skip'ing.

It's a small improvement, but one that goes in the right direction.

Btw, the above sentence should've read "but still refuse to *start*
(as in, start a brand new rebase) with dirty tree or index"

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
