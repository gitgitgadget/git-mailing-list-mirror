From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Rss produced by git is not valid xml?
Date: Sat, 19 Nov 2005 01:34:54 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511190130240.29239@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200511181833.40048.ismail@uludag.org.tr> <200511182127.06958.ismail@uludag.org.tr>
 <20051118200217.GA2831@vrfy.org> <200511182208.24248.ismail@uludag.org.tr>
 <Pine.LNX.4.64.0511181220350.13959@g5.osdl.org> <20051118205513.GA3168@vrfy.org>
 <Pine.LNX.4.64.0511181314470.13959@g5.osdl.org> <Pine.LNX.4.64.0511181338460.13959@g5.osdl.org>
 <437E51EB.7050100@zytor.com> <Pine.LNX.4.64.0511181520390.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Kay Sievers <kay.sievers@vrfy.org>,
	Ismail Donmez <ismail@uludag.org.tr>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 19 01:36:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdGh1-0001HU-FB
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 01:34:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbVKSAe4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 19:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbVKSAe4
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 19:34:56 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:27589 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751129AbVKSAez (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 19:34:55 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E8BC71400E9; Sat, 19 Nov 2005 01:34:54 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id CB0B19F36D; Sat, 19 Nov 2005 01:34:54 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B622F9D87B; Sat, 19 Nov 2005 01:34:54 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 9B50F1400E9; Sat, 19 Nov 2005 01:34:54 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511181520390.13959@g5.osdl.org>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12309>

Hi,

On Fri, 18 Nov 2005, Linus Torvalds wrote:

> This I agree with, btw. We could easily have a
> 
> 	[core]
> 		utf=1
> 
> thing, and make git-commit-tree refuse to commit a non-UTF8 message.
> 
> Of course, you could equally easily (more so?) make it just a commit 
> trigger instead, which might well be the right thing.

Actually, hooks have been introduced for exactly that purpose! Besides, 
they are a much more powerful tool. For example, you can not only enforce 
utf-8, but also replace words from a swear words list by "*beep*".

So, hooks are the way to go. Introducing another way to accomplish the 
same thing would be like Microsoft, implementing hundreds of APIs for the 
same task, none of them correct.

I can only underline what Linus said here: Software should work for 
people, not the other way round. Please, before you send some BS like 
"utf-8 is the only reasonable thing for everybody, everywhere, ever", read 
that sentence in Linus' mail again. Software should *not* restrict anybody 
for non-technical reasons. ever. Period.

Ciao,
Dscho
