From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Add commands that git-gc runs underneath
Date: Thu, 30 Aug 2007 12:13:33 +0200
Message-ID: <46D6984D.9040802@op5.se>
References: <lkbtwek0.fsf@cante.net> <Pine.LNX.4.64.0708301107320.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 30 12:13:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQh1v-00021B-SN
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 12:13:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755478AbXH3KNg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 06:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755232AbXH3KNg
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 06:13:36 -0400
Received: from mail.op5.se ([193.201.96.20]:38707 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755266AbXH3KNf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 06:13:35 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id E545719441D;
	Thu, 30 Aug 2007 12:13:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S7fWHCBHV1uB; Thu, 30 Aug 2007 12:13:34 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.178])
	by mail.op5.se (Postfix) with ESMTP id 5CF481943F7;
	Thu, 30 Aug 2007 12:13:34 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <Pine.LNX.4.64.0708301107320.28586@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57018>

Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 30 Aug 2007, Jari Aalto wrote:
> 
>> git-gc is a higher level utility to "do the right thing". However there 
>> are many other lower level utilities for the house keeping and it is not 
>> clear what git-gc actually does. Adding the actual lower level command 
>> and their parameters explain "what's going on".x
> 
> Isn't the whole purpose of git-gc to make it _unnecessary_ to know which 
> lowlevel commands are run?
> 
> NACK.
> 

I think of it as a handy way of doing all those tasks in the correct order
without having to remember more than a single command.

I kinda like it, and it might be helpful if someone's got a large repo and
one part of gc for some reason didn't complete so they want to start at
whatever step it broke off on.

When gc was a shell-script, it was fairly easy to find out the command-
sequence. Now it's a built-in and that deduction actually takes some
time and brainpower, so...

Acked-by: Andreas Ericsson <ae@op5.se>


-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
