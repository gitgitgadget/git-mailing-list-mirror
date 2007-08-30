From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Add commands that git-gc runs underneath
Date: Thu, 30 Aug 2007 14:13:18 +0200
Message-ID: <46D6B45E.4020800@op5.se>
References: <lkbtwek0.fsf@cante.net> <Pine.LNX.4.64.0708301107320.28586@racer.site> <46D6984D.9040802@op5.se> <Pine.LNX.4.64.0708301254420.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 30 14:14:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQiuN-0005Su-06
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 14:13:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759117AbXH3MNv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 08:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752554AbXH3MNv
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 08:13:51 -0400
Received: from mail.op5.se ([193.201.96.20]:42943 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759117AbXH3MNu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 08:13:50 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id B5B90194412;
	Thu, 30 Aug 2007 14:13:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RbyYUBW6SfkC; Thu, 30 Aug 2007 14:13:20 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.178])
	by mail.op5.se (Postfix) with ESMTP id DD1B519441D;
	Thu, 30 Aug 2007 14:13:19 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <Pine.LNX.4.64.0708301254420.28586@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57032>

Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 30 Aug 2007, Andreas Ericsson wrote:
> 
>> I kinda like it [listing the commands git-gc calls], and it might be 
>> helpful if someone's got a large repo and one part of gc for some reason 
>> didn't complete so they want to start at whatever step it broke off on.
> 
> Let me clarify: I do not like the listing in the man page.  This suggests 
> to the user to delve into plumbing areas where it is all too easy to shoot 
> yourself in the foot.
> 

I misunderstood.

> I have nothing against listing the commands per se.  But the man page is 
> too exposed IMHO.  (Or would you like to add the original shell script to 
> git-log's man page, too?)
> 
> My preferred location would be somewhere near Documentation/technical/, so 
> that people reading the commands are more likely to understand the 
> consequences.
> 
> But maybe I'm wrong.
> 

Having read the reasoning, I confess myself convinced. Thanks for clarifying.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
