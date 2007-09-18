From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 1/1] git-send-email: Add a --suppress-all option
Date: Tue, 18 Sep 2007 09:40:55 +0200
Message-ID: <46EF8107.1030607@op5.se>
References: <11900540373215-git-send-email-felipebalbi@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Felipe Balbi <felipe.lima@indt.org.br>
To: Felipe Balbi <felipebalbi@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Sep 18 09:41:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXXhh-0004uK-HN
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 09:41:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754443AbXIRHk6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 03:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754373AbXIRHk6
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 03:40:58 -0400
Received: from mail.op5.se ([193.201.96.20]:55696 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753732AbXIRHk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 03:40:57 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 256E919439E;
	Tue, 18 Sep 2007 09:40:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M5oAzj91MUPG; Tue, 18 Sep 2007 09:40:55 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.178])
	by mail.op5.se (Postfix) with ESMTP id AD13D194345;
	Tue, 18 Sep 2007 09:40:55 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <11900540373215-git-send-email-felipebalbi@users.sourceforge.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58538>

Felipe Balbi wrote:
> From: Felipe Balbi <felipe.lima@indt.org.br>
> 
> This patch adds a --suppress-all option to avoid sending emails
> to everybody but the ones listed by --to option.
> 

To my minds eye, --suppress-all is equivalent to --dry-run. Could you
rename it to "--cc-nobody" or some such?

On a side-note, I've never really understood why git-send-email *by default*
sends to a bazillion people. Does anybody ever use it without suppressing
most of the CC targets?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
