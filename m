From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC] builtin-checkout: suggest creating local branch when
 appropriate to do so
Date: Mon, 5 Oct 2009 23:17:09 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910052314580.4985@pacific.mpi-cbg.de>
References: <1254775583-49452-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 23:24:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Muv2E-0004P2-1L
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 23:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754863AbZJEVPg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 17:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754861AbZJEVPf
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 17:15:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:36626 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754860AbZJEVPd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 17:15:33 -0400
Received: (qmail invoked by alias); 05 Oct 2009 21:14:45 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp006) with SMTP; 05 Oct 2009 23:14:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18YYTFVKPQYZXf8siUwoy++/HcNvRyUEsT0B2PY6H
	J6s/+RvrzbtCt7
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1254775583-49452-1-git-send-email-jaysoffian@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129592>

Hi,

On Mon, 5 Oct 2009, Jay Soffian wrote:

> A user who has just cloned a remote repository and wishes to then work on a
> branch other than master may not realize they first need to create the local
> branch. e.g.:
> 
> $ git clone git://git.kernel.org/pub/scm/git/git.git
> $ cd git
> $ git checkout next
> error: pathspec 'next' did not match any file(s) known to git.
> 
> This commit teaches git to make a suggestion to the user:
> 
> $ git clone git://git.kernel.org/pub/scm/git/git.git
> $ cd git
> $ git checkout next
> error: pathspec 'next' did not match any file(s) known to git.
> To create a local branch from the same named remote branch, use
>   git checkout -b next origin/next
> 
> Motivated by http://article.gmane.org/gmane.comp.version-control.git/129528

Actually, we should really think long and hard why we should not 
automatically check out the local branch "next" in that case.  I mean, 
really long and hard, and making sure to take user-friendliness into 
account at least as much as simplicity of implementation.

Ciao,
Dscho
