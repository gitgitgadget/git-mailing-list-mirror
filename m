From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Q: howto rebase
Date: Tue, 25 Sep 2007 15:49:24 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709251548390.28395@racer.site>
References: <BAY105-F33DC84FACB8B66BFEB9EC8FFB70@phx.gbl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: lode leroy <lode_leroy@hotmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 25 16:50:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaBkB-0004u3-Kg
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 16:50:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754038AbXIYOua (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 10:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753980AbXIYOua
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 10:50:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:52819 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751439AbXIYOu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 10:50:28 -0400
Received: (qmail invoked by alias); 25 Sep 2007 14:50:26 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp003) with SMTP; 25 Sep 2007 16:50:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX182MeQIOaM2gd0pls87AA702Qa9otDuqv5/Zs6U0I
	NcCiUHmlEq6z7s
X-X-Sender: gene099@racer.site
In-Reply-To: <BAY105-F33DC84FACB8B66BFEB9EC8FFB70@phx.gbl>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59131>

Hi,

On Tue, 25 Sep 2007, lode leroy wrote:

> I'm trying to understand how rebase works, but I need some help to get it.
> Suppose I do the following workflow... (see below)
> 
> In "version B" I introduce the "fix c", but in "version D" I realize it
> should have
> been in some other place. (commit D moves the fix to its proper place).
> A-B-C-D-E
> 
> Now I want to 'rewrite history'.
> I would like to move commit D after B
> A-B-D'-C'-E
> 
> and then fold the commits B and D' into a single commit.
> A-B'-C'-E
> 
> I somehow managed to get this done using "rebase -i"
> by exchanging the 2 appropriate lines, and then deleting the second one,
> but I'd like to understand how to do this from the command line...

Almost.  Your "fold" is called "squash".  So instead of deleting the 
second one, you probably wanted to squash it.

Hth,
Dscho
