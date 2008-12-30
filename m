From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-cherry: make <upstream> parameter optional
Date: Tue, 30 Dec 2008 14:13:00 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812301411480.30769@pacific.mpi-cbg.de>
References: <200812291845.20500.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Tue Dec 30 14:13:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHePi-0006ZC-KB
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 14:13:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbYL3NMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 08:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751683AbYL3NMQ
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 08:12:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:54301 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751530AbYL3NMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 08:12:16 -0500
Received: (qmail invoked by alias); 30 Dec 2008 13:12:14 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp071) with SMTP; 30 Dec 2008 14:12:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19bWlRiZUZbblBdUXjz+AMH0nXaJgy7L1NM/L7NUS
	J6Bwl5Vx7HBsB8
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200812291845.20500.markus.heidelberg@web.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104183>

Hi,

On Mon, 29 Dec 2008, Markus Heidelberg wrote:

> The upstream branch <upstream> now defaults to the first tracked
> remote branch, which is set by the configuration variables
> branch.<name>.remote and branch.<name>.merge of the current branch.
> 
> Without such a remote branch, the command "git cherry [-v]" fails with
> usage output as before and an additional message.
> 
> Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>

This would be a massively visible user interface change.  At the moment, 
it does this (which I like):

	$ git cherry-pick
	usage: git cherry-pick [options] <commit-ish>

	    -n, --no-commit       don't automatically commit
	    -e, --edit            edit the commit message
	    -x                    append commit name when cherry-picking
	    -r                    no-op (backward compatibility)
	    -s, --signoff         add Signed-off-by:
	    -m, --mainline <n>    parent number

Opposed,
Dscho
