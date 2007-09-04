From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add a new lstat and fstat implementation based on Win32
 API
Date: Tue, 4 Sep 2007 15:32:22 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709041530560.28586@racer.site>
References: <46DACD93.9000509@trolltech.com> <46DACE0D.5070501@trolltech.com>
 <46DBBC1E.4010407@eudaptics.com> <46DBFA2A.7050003@trolltech.com>
 <Pine.LNX.4.64.0709031428080.28586@racer.site> <46DC5ED4.8050202@trolltech.com>
 <46DD0C16.70101@eudaptics.com> <Pine.LNX.4.64.0709041145230.28586@racer.site>
 <46DD433A.5040604@eudaptics.com> <46DD473A.8010602@trolltech.com>
 <46DD63F5.5050002@trolltech.com> <46DD6694.6030701@eudaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 16:33:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISZSa-0005h3-CF
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 16:32:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754122AbXIDOcw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 10:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754099AbXIDOcw
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 10:32:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:35962 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753998AbXIDOcv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 10:32:51 -0400
Received: (qmail invoked by alias); 04 Sep 2007 14:32:49 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp040) with SMTP; 04 Sep 2007 16:32:49 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Z+BZIZGYZ4MvDQ5PapfdF0aBaZrjNCpudrGDR+v
	LAExwZ73RdR0ql
X-X-Sender: gene099@racer.site
In-Reply-To: <46DD6694.6030701@eudaptics.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57580>

Hi,

On Tue, 4 Sep 2007, Johannes Sixt wrote:

> Marius Storm-Olsen schrieb:
> > Marius Storm-Olsen said the following on 04.09.2007 13:53:
> > > In the meantime, I've pushed out a new patch
> > > http://repo.or.cz/w/git/mingw/4msysgit.git?a=commitdiff;h=683775c00d9fb95bcbe4632f95b67a96b902fa59 
> > > 
> > > /me starts another test run, to see how our tests are doing now..
> > 
> > Neat, with the custom stat() changes cherry-picked on top of 4msysgit.git
> > 'devel' branch, I only have one failing testcase
> >     t6024-recursive-merge.sh
> > when running
> >     $ NO_SYMLINKS=1 make -k
> > 
> > The rest are passing with flying colors!
> 
> And that one will eventually pass if only you try it often enough. See
> 71ee4210c in mingw.git.

Do you have Linus' patch applied?  The one where the config is read at the 
start of write-tree?

The problem only occurred since we have core.crlf = input unilaterally 
now.

Ciao,
Dscho
