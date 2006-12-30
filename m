From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: SIGSEGV in merge recursive
Date: Sat, 30 Dec 2006 12:07:47 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612301204280.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <898450.11823.qm@web31804.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 30 12:08:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0c4O-0004pM-TJ
	for gcvg-git@gmane.org; Sat, 30 Dec 2006 12:08:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754323AbWL3LHu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Dec 2006 06:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754338AbWL3LHu
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Dec 2006 06:07:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:53665 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754323AbWL3LHt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Dec 2006 06:07:49 -0500
Received: (qmail invoked by alias); 30 Dec 2006 11:07:47 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp052) with SMTP; 30 Dec 2006 12:07:47 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Luben Tuikov <ltuikov@yahoo.com>
In-Reply-To: <898450.11823.qm@web31804.mail.mud.yahoo.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35614>

Hi,

On Fri, 29 Dec 2006, Luben Tuikov wrote:

> > > Failed to read a valid object file image from memory.
> > 
> > Who says this?

Again, who says this? I cannot find _anything_ in my local repo (with its 
own set of modifications, which do not hide such a message).

Given that there is a fix in master for a segfault, I have to admit that I 
believe you did not use _that_ version, but a git without that fix.

Besides, Alexandre hit an interesting bug, which is not at all easy to 
reproduce (except with three 70k files which I don't want to include in 
the test set). Since Alexandre provided _examples_ where I can _reproduce_ 
the problem, I will be working on that bug, and not yours.

Ciao,
Dscho
