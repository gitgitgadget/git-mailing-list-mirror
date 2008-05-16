From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Why do git submodules require manual checkouts and commits?
Date: Fri, 16 May 2008 11:17:14 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805161055540.30431@racer>
References: <2729632a0805152116o3c998324xb401674207dd2e1e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Fri May 16 12:18:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jwx0l-0008OW-O0
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 12:18:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752457AbYEPKRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 06:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752675AbYEPKRN
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 06:17:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:52553 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752407AbYEPKRM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 06:17:12 -0400
Received: (qmail invoked by alias); 16 May 2008 10:17:09 -0000
Received: from R4f5c.r.pppool.de (EHLO racer.local) [89.54.79.92]
  by mail.gmx.net (mp041) with SMTP; 16 May 2008 12:17:09 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18IesQeCJkI9s6hC50xMvCziswW+tbVhlFf90nhTR
	DZ+3Ngdt1bhaZg
X-X-Sender: gene099@racer
In-Reply-To: <2729632a0805152116o3c998324xb401674207dd2e1e@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82263>

Hi,

On Thu, 15 May 2008, skillzero@gmail.com wrote:

> Why do git submodules require manually committing the submodule itself
> to each super repository after something in the submodule repository
> changes?

Submodules are special.

You cannot recreate the exact state from a commit in the superproject, for 
one, and often not even from the commit itself, since the submodule can 
contain more than just the tracked files.

Also, no submodule _has_ to be checked out.  If you are working inside a 
superproject, chances are that you are uninterested in most of the 
submodules.

So no, there is nothing to change here, please move along.

Ciao,
Dscho
