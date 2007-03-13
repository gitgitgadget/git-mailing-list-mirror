From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Remove tab character from conflicted files list part of
 the merge message
Date: Tue, 13 Mar 2007 15:42:03 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703131539430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200703131309.43767.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 15:42:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HR8Cf-000431-5z
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 15:42:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030490AbXCMOmH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Mar 2007 10:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030449AbXCMOmH
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Mar 2007 10:42:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:42840 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030494AbXCMOmF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2007 10:42:05 -0400
Received: (qmail invoked by alias); 13 Mar 2007 14:42:03 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp049) with SMTP; 13 Mar 2007 15:42:03 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+O3gBtlr2Owo0TtmUhcZziRBuHjq8XGVlHB54JQq
	uDWYiQRutuqxN3
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200703131309.43767.andyparkins@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42119>

Hi,

On Tue, 13 Mar 2007, Andy Parkins wrote:

> So what I thought I was formatting as (for example)
> 
> Conflicts:
>     file.c
>      * Chose upstream version over mine, but integrated my small typo fix.
> 
> Was appearing in the log display as
> 
> Conflicts:
>         file.c
>      * Chose upstream version over mine, but integrated my small typo fix.
> 
> Which isn't how I'd intended at all.
> 
> The fix is of course - no tabs.  Tabs for formatting is always going to 
> cause trouble, so this patch swaps the tab for spaces.

And of course the next guy will have the reverse problem, because he typed 
<TAB><SPACE> instead of <SPACE>*5. What do you tell _him_ after "fixing" 
this issue? "Do as _I_ do"?

Ciao,
Dscho
