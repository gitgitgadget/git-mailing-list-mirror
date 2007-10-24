From: Andreas Ericsson <ae@op5.se>
Subject: Re: What's cooking in git.git (topics)
Date: Wed, 24 Oct 2007 20:27:44 +0200
Message-ID: <471F8EA0.9030902@op5.se>
References: <20071022063222.GS14735@spearce.org> <7vzly84qwf.fsf@gitster.siamese.dyndns.org> <20071024160852.GA759@srparish.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Scott Parish <sRp@srparish.net>
X-From: git-owner@vger.kernel.org Wed Oct 24 20:28:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkkxW-0004Uj-5U
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 20:28:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757841AbXJXS1t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 14:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757851AbXJXS1t
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 14:27:49 -0400
Received: from mail.op5.se ([193.201.96.20]:40234 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755268AbXJXS1r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 14:27:47 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id AD2131730678;
	Wed, 24 Oct 2007 20:27:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fwgXlYM3WUBp; Wed, 24 Oct 2007 20:27:30 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id DC288173066B;
	Wed, 24 Oct 2007 20:27:29 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <20071024160852.GA759@srparish.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62225>

Scott Parish wrote:
> On Wed, Oct 24, 2007 at 05:51:28AM -0700, Junio C Hamano wrote:
> 
>> * js/PATH (Sun Oct 21 22:59:01 2007 +0100) 1 commit
>>  - execv_git_cmd(): also try PATH if everything else fails.
>>
>> I do not quite get why this is needed; need to go back to the
>> discussion myself.  On the other hand, I found the alternative
>> approach suggested on the list very interesting (i.e. instead of
>> "also try", just letting exec*p use PATH, relying on the fact
>> that we do prepend-to-path anyway).  What happened to it?  Was
>> there a downside?
> 
> The main downside that was raised was MingW compatibility, but
> Schindelin and Sixt both said that it could wait until further
> work is done porting to MingW.
> 
> Should i resend my string of patches? I've seen people numbering
> their patches, should i do that as well?
> 

'git format-patch -n' will do it for you. I take it you've found
out about git-send-email already?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
