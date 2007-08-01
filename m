From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/9] work-tree clean ups
Date: Wed, 1 Aug 2007 02:13:59 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708010211071.14781@racer.site>
References: <Pine.LNX.4.64.0707300016470.14781@racer.site>
 <Pine.LNX.4.64.0708010058130.14781@racer.site> <7vbqdsdqfd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, matled@gmx.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 03:14:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IG2nD-0005vi-CC
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 03:14:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751742AbXHABOY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jul 2007 21:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753836AbXHABOY
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 21:14:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:44925 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751688AbXHABOX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 21:14:23 -0400
Received: (qmail invoked by alias); 01 Aug 2007 01:14:21 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp053) with SMTP; 01 Aug 2007 03:14:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/tF1M/8Hbt4x0kUFxmQLmlqXtfEmGxgXe0vIuIrH
	4WgGB8USwFQBli
X-X-Sender: gene099@racer.site
In-Reply-To: <7vbqdsdqfd.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54393>

Hi,

On Tue, 31 Jul 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > There is not really much that can be done about step 6/9: if we are in a 
> > work tree: that does not mean that we are _not_ in the git_dir.  (And no, 
> > this does not break git-clean, as a work tree is a work tree is a work 
> > tree.  If the user was stupid enough to specify the same directory as 
> > GIT_DIR and GIT_WORK_TREE, then that is _her_ problem.  Git is a powerful 
> > tool, and you can harm yourself with it.  Tough.)
> 
> I think we might have a slight misunderstanding.  The "clean"
> issue that was raised in an ancient thread was this sequence:
> 
> 	$ git init
>         $ cd .git
>         $ git clean
> 
> It did not involve GIT_DIR (nor GIT_WORK_TREE as it was not even
> there).

I very much _did_ mean that case.  When "git clean" is run in ".git/", it 
should not say that it is in the working tree.  But I guess that my patch 
series is not really looking out for that;  I'll make that an add-on 
patch.  (But that _will_ have to wait until tomorrow afternoon.)

Ciao,
Dscho
