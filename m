From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] resend: really plug memory leaks in git-svnimport
Date: Tue, 25 Sep 2007 20:37:52 +0200
Message-ID: <46F95580.1050907@op5.se>
References: <20070924105740.GB8900@ted> <7vr6km6354.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Stefan Sperling <stsp@elego.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 25 20:38:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaFIM-0000Go-8P
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 20:38:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752908AbXIYSh7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 14:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752391AbXIYSh7
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 14:37:59 -0400
Received: from mail.op5.se ([193.201.96.20]:43359 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751899AbXIYSh6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 14:37:58 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 9C342194443;
	Tue, 25 Sep 2007 20:37:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tm8DHpWhAKZ8; Tue, 25 Sep 2007 20:37:53 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id 034E3194433;
	Tue, 25 Sep 2007 20:37:52 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <7vr6km6354.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59150>

Junio C Hamano wrote:
> Stefan Sperling <stsp@elego.de> writes:
> 
>> Junio asked me to resend this patch to the mailing list.
>>
>> This version of the patch is adjusted to apply cleanly
>> to current HEAD.
>>
>> @Junio: I'm not resending the multiple branch/tag dirs patch
>> just yet, because I want to polish it first -- I've got another
>> idea how to improve it.
> 
> Ok.
> 
> People on the list who still use git-svnimport, could you help
> with testing this patch?  Will queue for 'pu' in the meantime.
> 

I used to use it, but I've given up on it in favour of git svn.
Partly because git-svn seems to get cases right that git-svnimport
didn't, but mostly because it remembers where I fetched from, which
is damn handy.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
