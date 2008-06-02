From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase --interactive: Compute upstream SHA1 before
 switching branches
Date: Mon, 2 Jun 2008 16:29:17 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806021628260.13507@racer.site.net>
References: <4843FD44.90905@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jun 02 17:31:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3C0R-0000u2-JG
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 17:31:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752038AbYFBPae (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 11:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752024AbYFBPae
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 11:30:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:40543 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751996AbYFBPad (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 11:30:33 -0400
Received: (qmail invoked by alias); 02 Jun 2008 15:30:31 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.2]) [141.5.10.38]
  by mail.gmx.net (mp049) with SMTP; 02 Jun 2008 17:30:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+o3Yx0ItaoET+G+hiNZKsa9oEyJVuxutOdDiQIN4
	//quKM6dAc2tHh
X-X-Sender: gene099@racer.site.net
In-Reply-To: <4843FD44.90905@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83531>

Hi,

On Mon, 2 Jun 2008, Johannes Sixt wrote:

> From: Johannes Sixt <johannes.sixt@telecom.at>
> 
> If the upstream argument to rebase (the first argument) was relative to
> HEAD and the name of the branch to rebase (the second argument) was given,
> the upstream would have been interpreted relative to the second argument.
> In particular, this command
> 
>     git rebase -i HEAD topic
> 
> would always finish with "Nothing to do". (a1bf91e fixed the same issue
> for non-interactive rebase.)
> 
> Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>

Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>

> I made this with -U5 so that you can see the checkout in the context.
> 
> BTW, methinks, this checkout is unnecessary, since before the rebase 
> begins, there is a 'git checkout $ONTO', and the branch switching is 
> certainly not needed to compute the todo list...

It is needed to determine which branch to update after finish.

Ciao,
Dscho
