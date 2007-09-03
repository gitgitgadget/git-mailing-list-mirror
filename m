From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add a new lstat and fstat implementation based on Win32
 API
Date: Mon, 3 Sep 2007 17:55:12 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709031753500.28586@racer.site>
References: <46DACD93.9000509@trolltech.com> <46DACE0D.5070501@trolltech.com>
 <46DBBC1E.4010407@eudaptics.com> <46DBFA2A.7050003@trolltech.com>
 <46DC10FE.1080805@eudaptics.com> <Pine.LNX.4.64.0709031536060.28586@racer.site>
 <46DC3320.1010408@trolltech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@eudaptics.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 18:55:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISFCz-0000sM-Bg
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 18:55:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752304AbXICQzZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 12:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751861AbXICQzZ
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 12:55:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:59222 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751844AbXICQzY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 12:55:24 -0400
Received: (qmail invoked by alias); 03 Sep 2007 16:55:22 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp056) with SMTP; 03 Sep 2007 18:55:22 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+2GPdoIYK2BMADtAWqDHNfCBo5xZqn6jHJTqR+Yu
	9HXk6qmJuaOS3B
X-X-Sender: gene099@racer.site
In-Reply-To: <46DC3320.1010408@trolltech.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57495>

Hi,

On Mon, 3 Sep 2007, Marius Storm-Olsen wrote:

> Johannes Schindelin wrote:
> 
> > t4200-rerere,
> > t5510-fetch,
> > t5515-fetch-merge-logic,
> > t5700-clone-reference,
> > t5701-clone-local,
> > t7004
> > 
> > This is all on top of 4msysgit's "devel" branch, and the t5* and t7004 
> > failed there already.
> > 
> > Oh, and I actually run from sh, not from cmd.  (Wouldn't you have 
> > guessed?)
> 
> I was also running the tests under sh, however on top of mingw.git, and 
> not 4msysgit.git.

I switched back recently, as more tests are succeeding in 
4msysgit.git's "devel" ATM.

Ciao,
Dscho
