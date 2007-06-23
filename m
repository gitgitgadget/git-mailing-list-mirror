From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] transplant: move a series of commits to a different
 parent
Date: Sat, 23 Jun 2007 21:54:30 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706232151480.4059@racer.site>
References: <1BD13366-B4BD-4630-9046-49567A345CBC@zib.de>
 <11826268772950-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sat Jun 23 22:54:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2Ccz-0005be-Df
	for gcvg-git@gmane.org; Sat, 23 Jun 2007 22:54:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531AbXFWUyk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jun 2007 16:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbXFWUyk
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jun 2007 16:54:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:59485 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751504AbXFWUyj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2007 16:54:39 -0400
Received: (qmail invoked by alias); 23 Jun 2007 20:54:37 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp050) with SMTP; 23 Jun 2007 22:54:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/m3sJRkD/m2g0QdLW8Y8/gpj1r1giW+J6ACA1bRl
	qpdovelIpxGSY/
X-X-Sender: gene099@racer.site
In-Reply-To: <11826268772950-git-send-email-prohaska@zib.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50752>

Hi,

On Sat, 23 Jun 2007, Steffen Prohaska wrote:

> git-transplant.sh <onto> <from> <to>
> 
> transplant starts with the contents of <onto> and puts on top of
> it the contents of files if they are touched by the series of
> commits <from>..<to>.

This reeks of rebase.

IOW, I suspect that it does almost the same as

	git checkout <to>
	git rebase -s ours --onto <onto> <from>^

Ciao,
Dscho
