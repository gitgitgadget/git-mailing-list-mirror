From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] git-merge: add option --no-ff
Date: Mon, 17 Sep 2007 14:39:32 +0200
Message-ID: <46EE7584.8010202@op5.se>
References: <11900314321506-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 14:40:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXFt5-0007jy-Vp
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 14:39:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753137AbXIQMjf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 08:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753227AbXIQMjf
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 08:39:35 -0400
Received: from mail.op5.se ([193.201.96.20]:54806 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752192AbXIQMjf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 08:39:35 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id DE4C4194462;
	Mon, 17 Sep 2007 14:39:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id phpix2+pQ1Ou; Mon, 17 Sep 2007 14:39:33 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.178])
	by mail.op5.se (Postfix) with ESMTP id 445AB19444E;
	Mon, 17 Sep 2007 14:39:33 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <11900314321506-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58431>

Lars Hjemli wrote:
> This new option forces all merges to create a "true" merge commit, i.e. a
> commit with multiple parents.
> 
> Although a fast-forward would normally be The Right Thing, it isn't when the
> branches to be merged originated in subversion and the merge commit will
> be pushed back by means of 'git svn dcommit'. In these cases, a fast-
> forward merge simply will not work.
> 
>  	If there is no `-s` option, a built-in list of strategies
>  	is used instead (`git-merge-recursive` when merging a single
>  	head, `git-merge-octopus` otherwise).
> +
> +--no-ff::
> +	Force the creation of a merge commit even when the merge would
> +	have resolved as a fast-forward operation.

+ Although a fast-forward would normally be The Right Thing, it isn't when the
+ branches to be merged originated in subversion and the merge commit will
+ be pushed back by means of 'git svn dcommit'. In these cases, a fast-
+ forward merge simply will not work.

Otherwise someone will sit down and try to figure out why this is necessary.

I'm having trouble understanding why this is needed, but I'll take your word
for it ;-)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
