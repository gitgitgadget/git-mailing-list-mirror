From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] git-branch --with=commit
Date: Thu, 08 Nov 2007 10:17:52 +0100
Message-ID: <4732D440.2020504@op5.se>
References: <7vpryl8x5t.fsf@gitster.siamese.dyndns.org>	<4732BC6F.7070005@viscovery.net> <7vejf140jd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 10:18:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq3Wf-0007DQ-BU
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 10:18:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753846AbXKHJR6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 04:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753541AbXKHJR5
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 04:17:57 -0500
Received: from mail.op5.se ([193.201.96.20]:53706 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751059AbXKHJR4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 04:17:56 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 44E0F1F08709;
	Thu,  8 Nov 2007 10:17:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cslA6aSWlUDr; Thu,  8 Nov 2007 10:17:21 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 3E8F11F08706;
	Thu,  8 Nov 2007 10:17:21 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <7vejf140jd.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63972>

Junio C Hamano wrote:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
>> Junio C Hamano schrieb:
> 
>>> With this patch, I could do this to find out which topic
>>> branches already contain the faulty commit:
>>>
>>>     $ git branch --with=maint^ | grep /
>>>       xx/maint-fix-foo
>> It'd be helpful if you could construct the example in this commit
>> message such that you don't need the "grep /" here; otherwise, the
>> reader doesn't know which part of the effect is hidden by the grep.
> 
> Yeah, in the example sequence, I think only maint itself and
> xx/maint-fix-foo are shown, so there is no need for grep.

And "maint" could certainly be stripped by the code itself, since the
user can reasonably be expected to know that plain maint will have
everything maint^ has.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
