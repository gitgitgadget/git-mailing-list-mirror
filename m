From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Allow git-diff exit with codes similar to diff(1)
Date: Wed, 14 Mar 2007 02:03:16 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703140201240.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <81b0412b0703131717k7106ee1cg964628f0bda2c83e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 02:03:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRHtk-0001Yg-8d
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 02:03:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752675AbXCNBDU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Mar 2007 21:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752660AbXCNBDU
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Mar 2007 21:03:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:40369 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752675AbXCNBDT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2007 21:03:19 -0400
Received: (qmail invoked by alias); 14 Mar 2007 01:03:17 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp002) with SMTP; 14 Mar 2007 02:03:17 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18U9n0oeMcURtAkhPRauKz6We+1SRm/pQH8J0/o+G
	on7WtuFBlIThp4
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <81b0412b0703131717k7106ee1cg964628f0bda2c83e@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42159>

Hi,

On Wed, 14 Mar 2007, Alex Riesen wrote:

> This introduces a new command-line option: --exit-code. The diff 
> programs will return 1 for differences, return 0 for equality, and 
> something else for errors.

I am not convinced that this exit code (even if expected by experience) 
makes sense. A diff should _only_ fail if anything goes _wrong_, not if 
the files are _different. That is what cmp is for, no?

Ciao,
Dscho
