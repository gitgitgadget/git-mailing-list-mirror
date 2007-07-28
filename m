From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: suggestion for git rebase -i
Date: Sat, 28 Jul 2007 09:43:15 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707280941380.14781@racer.site>
References: <m26445t98z.fsf@ziti.fhcrc.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Seth Falcon <sfalcon@fhcrc.org>
X-From: git-owner@vger.kernel.org Sat Jul 28 10:43:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEhth-0001R8-83
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 10:43:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935656AbXG1Inc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 04:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935339AbXG1Inc
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 04:43:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:35160 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934221AbXG1In3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 04:43:29 -0400
Received: (qmail invoked by alias); 28 Jul 2007 08:43:28 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp045) with SMTP; 28 Jul 2007 10:43:28 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ZjjF3T5kZBneVOoHZOG7Vv8kRiIXgsdWn32xcPj
	RnyYkmzXK0WGHw
X-X-Sender: gene099@racer.site
In-Reply-To: <m26445t98z.fsf@ziti.fhcrc.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54007>

Hi,

On Fri, 27 Jul 2007, Seth Falcon wrote:

> The tempfile used by git rebase -i is called "todo".  For those using
> something like emacsclient, this is a bit too generic for the name of
> a file in a pre-existing editor session.  I realize this is a small
> nit, but how about renaming the file to "git-rebase-todo"?

Why?  This is an implementation detail, and should not concern the user.

However, I was thinking about adding a "git rebase --status" to show where 
you are, but that will have to be implemented by someone else, or it has 
to wait a little.

Ciao,
Dscho
