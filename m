From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Workflow question: A case for git-rebase?
Date: Wed, 8 Aug 2007 22:47:50 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708082246370.21857@racer.site>
References: <18071eea0708081411p41eaa44ai105adaef0e4b10a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Thomas Adam <thomas.adam22@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 23:48:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IItOM-0002E6-UT
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 23:48:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754089AbXHHVsb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 17:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752531AbXHHVsb
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 17:48:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:58874 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753166AbXHHVsa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 17:48:30 -0400
Received: (qmail invoked by alias); 08 Aug 2007 21:48:29 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp031) with SMTP; 08 Aug 2007 23:48:29 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19h3y5tsFVhU8KW6/avrXh0Kx+yv0sbhHOUFEmmmE
	yrju43Dz2SFCeX
X-X-Sender: gene099@racer.site
In-Reply-To: <18071eea0708081411p41eaa44ai105adaef0e4b10a5@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55375>

Hi,

On Wed, 8 Aug 2007, Thomas Adam wrote:

> As for myself, I maintain _locally_ a few branches (branchX, branchY)
> which dictate some bits and pieces I'm working on.  Periodically, I
> will tend to merge either merge to master and then push those changes
> out.  So far so good...
> 
> But, I've now come up against a case whereby if one of my colleagues
> changes a file (call it fileA) in branch master, and, in the course of
> my working in branchX means i modify fileA also, when I come to merge
> branchX into master I find the original change in master (as submitted
> by my colleague) being reverted by my changes in branchX.

I have a hard time seeing that.  If you touch the same code, 
unidentically, merge-recursive will not be nice to you: it will show 
conflicts, and you have to resolve them.

Or do you use "-s ours"?

Ciao,
Dscho
