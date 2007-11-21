From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Wishlist for a bundle-only transport mode
Date: Wed, 21 Nov 2007 16:59:52 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711211658510.27959@racer.site>
References: <8aa486160711210654p357ccd87i4809e0cda9471303@mail.gmail.com>
 <fi1heo$u4i$1@ger.gmane.org> <Pine.LNX.4.64.0711211544510.27959@racer.site>
 <200711211752.40264.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Santi =?iso-8859-1?q?B=E9jar?= <sbejar@gmail.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 18:00:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iusvx-0004yv-QQ
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 18:00:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752640AbXKUQ76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 11:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752338AbXKUQ76
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 11:59:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:52923 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751141AbXKUQ75 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 11:59:57 -0500
Received: (qmail invoked by alias); 21 Nov 2007 16:59:55 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp003) with SMTP; 21 Nov 2007 17:59:55 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX181NcAhpvc1nXmqaiSa5L9q9ETPyC66iwugEX/7ou
	QDcLh1egO1GWbe
X-X-Sender: gene099@racer.site
In-Reply-To: <200711211752.40264.jnareb@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65680>

Hi,

On Wed, 21 Nov 2007, Jakub Narebski wrote:

> Johannes Schindelin wrote:
> > On Wed, 21 Nov 2007, Jakub Narebski wrote:
> >> Santi Bejar wrote:
> >> 
> >>> 3) I can "git fetch" a bundle but I cannot "git push" a bundle, so if I have:
> >>> 
> >>> [remote "bundle"]
> >>> 	url = /file/to/bundle
> >>> 	fetch = "+refs/heads/*:refs/remotes/bundle/*"
> >>> 
> >>> $ git push bundle
> >>> 
> >>> would create a bundle in /file/to/bundle with the same branches as a
> >>> normal git push, but considering the remote branches as the local
> >>> remotes/bundle/*
> >> 
> >> And how you would differentiate between path meaning bundle, and path 
> >> meaning "local" protocol, i.e. git repository on the same filesystem? 
> > 
> > Maybe because the git repository is specified as an existing directory?  
> > The bundle is specified as a (possibly non-existing) file...
> 
> That has the disadvantage of pushing to bundle when you make an error
> in the lastpart of path to existing repository.

As I wrote in another reply, I would not allow overwriting an existing 
file.

> After thinking about it a bit, I think it would be better to use 
> bundle:// pseudoprotocol for the URL including config (bundle://file, 
> bundle:///path/to/bundle) and --bundle option to git push for 
> commandline.

I don't like that at all.

Specifying a non-existing file should be good enough.

Ciao,
Dscho
