From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] help.autocorrect: do not run a command if the command
 given is junk
Date: Mon, 14 Dec 2009 15:16:01 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0912141515430.4985@pacific.mpi-cbg.de>
References: <4B263797.5070808@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Dec 14 15:11:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKBe7-0007Cb-7c
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 15:11:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757310AbZLNOL0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2009 09:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756318AbZLNOLZ
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 09:11:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:54659 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754767AbZLNOLZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 09:11:25 -0500
Received: (qmail invoked by alias); 14 Dec 2009 14:11:23 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp061) with SMTP; 14 Dec 2009 15:11:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX199PLYZJtF9VNPRmp28XAfPExbfvA11SePT+Lw1NZ
	yMHrfMOwx9ASDD
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4B263797.5070808@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135212>

Hi,

On Mon, 14 Dec 2009, Johannes Sixt wrote:

> From: Johannes Sixt <j6t@kdbg.org>
> 
> If a given command is not found, then help.c tries to guess which one the
> user could have meant. If help.autocorrect is 0 or unset, then a list of
> suggestions is given as long as the dissimilarity between the given command
> and the candidates is not excessively high. But if help.autocorrect was
> non-zero (i.e., a delay after which the command is run automatically), the
> latter restriction on dissimilarity was not obeyed.
> 
> In my case, this happened:
> 
>  $ git ..daab02
>  WARNING: You called a Git command named '..daab02', which does not exist.
>  Continuing under the assumption that you meant 'read-tree'
>  in 4.0 seconds automatically...
> 
> The similarity limit that this patch introduces is already used a few lines
> later where the list of suggested commands is printed.
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---

Obvious ACK from me.
