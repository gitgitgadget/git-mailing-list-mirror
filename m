From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Volume of commits
Date: Sat, 21 Jul 2007 18:12:03 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707211811280.14781@racer.site>
References: <m3ps2xu5hc.fsf@pc7.dolda2000.com> <20070712132937.GQ19386@genesis.frugalware.org>
 <Pine.LNX.4.64.0707121451290.4516@racer.site> <20070713103025.GR1528MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sat Jul 21 19:12:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICIVM-0008PG-5p
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 19:12:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753153AbXGURMS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 13:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753149AbXGURMR
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 13:12:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:54627 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752374AbXGURMP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2007 13:12:15 -0400
Received: (qmail invoked by alias); 21 Jul 2007 17:12:12 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp053) with SMTP; 21 Jul 2007 19:12:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19NMBlaO5pNODeAuupX/o7bnP5LU8sDFEE0XjulpR
	jt/e69FWRkYilA
X-X-Sender: gene099@racer.site
In-Reply-To: <20070713103025.GR1528MdfPADPa@greensroom.kotnet.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53174>

Hi,

On Fri, 13 Jul 2007, Sven Verdoolaege wrote:

> [...] if I do the following:
> 
> bash-3.00$ git init
> Initialized empty Git repository in .git/
> bash-3.00$ for i in a b c; do touch $i; git add $i; git commit -m $i -a; done
> Created initial commit 19a8485: a
>  0 files changed, 0 insertions(+), 0 deletions(-)
>  create mode 100644 a
> Created commit 4a00f85: b
>  0 files changed, 0 insertions(+), 0 deletions(-)
>  create mode 100644 b
> Created commit defe3b5: c
>  0 files changed, 0 insertions(+), 0 deletions(-)
>  create mode 100644 c
> bash-3.00$ git rebase -i  HEAD~2
> 
> and then replace the second "pick" by "squash", then I get presented
> a commit message that contains the commit message of "c" twice and
> after the rebase there are still three commits in the history.
> This is with git version 1.5.3.rc1.10.gae1ae
> (on top of v1.5.3-rc1-4-gaf83bed).

It no longer reproduces, which probably means that I inadvertently fixed 
the bug ;-)

Ciao,
Dscho
