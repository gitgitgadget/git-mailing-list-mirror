From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Add color to git-add--interactive diffs (Take 2: now
 without spurious line break!)
Date: Sun, 14 Oct 2007 19:55:05 +0200
Message-ID: <471257F9.2090705@op5.se>
References: <1192351494.7226.18.camel@athena> <EFADE863-FC59-4A50-B165-9D30D9648B97@wincent.com> <Pine.LNX.4.64.0710141814100.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Wincent Colaiuta <win@wincent.com>,
	Tom Tobin <korpios@korpios.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Oct 14 19:57:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih7gR-0006og-V9
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 19:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758432AbXJNRzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 13:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758498AbXJNRzL
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 13:55:11 -0400
Received: from mail.op5.se ([193.201.96.20]:56551 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758383AbXJNRzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 13:55:09 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id BFFA71730648;
	Sun, 14 Oct 2007 19:55:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qboejNHjg-c2; Sun, 14 Oct 2007 19:55:07 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id BA5061730569;
	Sun, 14 Oct 2007 19:55:06 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <Pine.LNX.4.64.0710141814100.25221@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60884>

Johannes Schindelin wrote:
> Hi,
> 
> On Sun, 14 Oct 2007, Wincent Colaiuta wrote:
> 
>>> +sub parse_color {
>> You could simplify the manual escape sequence construction that you're 
>> doing here by using Term::ANSIColor like the other patches did. I see 
>> that git-send-email.perl uses that module too, so I guess depending on 
>> that module is ok.
> 
> Wrong.  Depending on that module is not correct, you always have to wrap 
> it into an "if (<is_color>) {...}".
> 
> I use git add -i quite often, and I _never_ use git send-email.  My guess 
> is that I am not alone with that.
> 

Not by a longshot, no. Personally I find git-send-email so tricky to use I've
rolled my own sender. I circulated it on the list a year or so back, but it's
not nearly so feature-full as git-send-email, so it never got much of an
audience.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
