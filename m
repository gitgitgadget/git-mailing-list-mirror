From: Andreas Ericsson <ae@op5.se>
Subject: Re: interactive rebase not rebasing
Date: Wed, 01 Oct 2008 17:26:39 +0200
Message-ID: <48E396AF.2000100@op5.se>
References: <20080928235013.5c749c6e.stephen@exigencecorp.com>	<48E078BF.5030806@op5.se>	<20081001010306.01cc34eb.stephen@exigencecorp.com>	<48E32BD4.1050107@op5.se> <20081001095225.d28de16a.stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stephen Haberman <stephen@exigencecorp.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 17:29:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl3cV-0001ZQ-24
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 17:28:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753168AbYJAP0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 11:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753078AbYJAP0o
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 11:26:44 -0400
Received: from mail.op5.se ([193.201.96.20]:43533 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752477AbYJAP0n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 11:26:43 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id DB0021B80066;
	Wed,  1 Oct 2008 17:18:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.751
X-Spam-Level: 
X-Spam-Status: No, score=-3.751 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.648, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nNXnhDGx-KTU; Wed,  1 Oct 2008 17:18:06 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 6EB761B8005F;
	Wed,  1 Oct 2008 17:18:05 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20081001095225.d28de16a.stephen@exigencecorp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97237>

Stephen Haberman wrote:
> 
> But given /this/ scenario (hehe), with the implementation's existing
> explicit usage of "--left-right --cherry-pick" to drop no-op commits,
> but then it's forgetting of this information later, leading to `git
> rebase` not performing a rebase at all, I think it is an obvious bug,
> and one that can be fixed without changing any of `git rebase`s
> existing semantics.
> 

Agreed.

>> Merely that you should think hard about it and then make sure it
>> doesn't break anything people are already doing today with the current
>> toolset.
> 
> I've attempted to do that. Now that I sent in the patch, if you could
> review it, I would appreciate your feedback.

I'm heading home from work now. I'll look it over tonight or tomorrow
morning. Thanks for the confidence :-)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
