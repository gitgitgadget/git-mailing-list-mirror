From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Temporary directories getting errantly added into trees
Date: Thu, 22 Nov 2007 10:55:00 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711221052280.27959@racer.site>
References: <4744FCD9.7020102@vilain.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Thu Nov 22 11:55:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv9iP-0007eN-CW
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 11:55:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752081AbXKVKzH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 05:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbXKVKzH
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 05:55:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:41441 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751604AbXKVKzE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 05:55:04 -0500
Received: (qmail invoked by alias); 22 Nov 2007 10:55:02 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp047) with SMTP; 22 Nov 2007 11:55:02 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+DgPtmHXSD4EsCsxi0XZcWEP6PlSE0/qK4jGPmF0
	P4aKwBQcrU/l8e
X-X-Sender: gene099@racer.site
In-Reply-To: <4744FCD9.7020102@vilain.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65782>

Hi,

On Thu, 22 Nov 2007, Sam Vilain wrote:

> I just got through a rather nasty debugging session with git-rebase, 
> which relies on a .dotest directory.  Turns out that .dotest was 
> accidentally added to the tree in the history of the commit that was 
> being rebased onto.

While we're at it, could we change the name so that it is .git/rebase, and 
not .dotest or .git/.dotest-merge?

Yes, I know, existing tools could rely on the location.  But then, I do 
not think that tools should be allowed to be _that_ married to particular 
implementations.  And indeed, I see no reason why a tool should access 
.dotest, except for accessing .dotest/patch, and then it will be very 
obvious where it fails.

But I don't know about QGit, StGit, etc...

Ciao,
Dscho
