From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Memory overrun in http-push.c
Date: Fri, 2 Mar 2007 20:16:25 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703022014410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070228151516.GC57456@codelabs.ru> <200703011931.32170.andyparkins@gmail.com>
 <Pine.LNX.4.63.0703012140370.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <200703021005.13620.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Eygene Ryabinkin <rea-git@codelabs.ru>,
	Junio C Hamano <junkio@cox.net>,
	Alex Riesen <raa.lkml@gmail.com>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 20:16:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNDF0-0004ZK-R0
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 20:16:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965144AbXCBTQ1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 14:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965145AbXCBTQ1
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 14:16:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:41559 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965144AbXCBTQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 14:16:27 -0500
Received: (qmail invoked by alias); 02 Mar 2007 19:16:25 -0000
X-Provags-ID: V01U2FsdGVkX1/scEAIPKLs6N8AivRJCnxLIE96+etyaoZ6IqZrMS
	u7f24c7hOa6/j+
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200703021005.13620.andyparkins@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41236>

Hi,

On Fri, 2 Mar 2007, Andy Parkins wrote:

> Here's another similar idea: generating copyright lines.  Let's say we 
> want to copyright every source file - that means writing "(C) Junio, (C) 
> Johannes, etc" at the top of every file.  Wouldn't it be nicer if we 
> could put $Copyright$ in the file, then have some git-blame-like 
> machinery fill in the copyrights automatically based on who's made 
> contributions?

That's a horrible idea. A typo fix is not copyrightable. You'd add these. 
An obious fix is not copyrightable. You'd add these cases, too.

Besides, IMHO adding copyright should be a _concious_ act.

Ciao,
Dscho
