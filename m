From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: 'git diff' in rebase--interactive
Date: Tue, 9 Oct 2007 13:22:18 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710091319400.4174@racer.site>
References: <470B410F.1040506@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Oct 09 14:22:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfE6n-0006on-A3
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 14:22:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752523AbXJIMWg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 08:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752542AbXJIMWf
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 08:22:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:41392 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752523AbXJIMWf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 08:22:35 -0400
Received: (qmail invoked by alias); 09 Oct 2007 12:22:33 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp018) with SMTP; 09 Oct 2007 14:22:33 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18dm7w7vL4dt6fT2I8FzdfnQhcsMGeu9ht2CbU5p+
	bbW82yenjhBbwW
X-X-Sender: gene099@racer.site
In-Reply-To: <470B410F.1040506@viscovery.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60390>

Hi,

On Tue, 9 Oct 2007, Johannes Sixt wrote:

> I wonder for what reason rebase--interactive generates a patch using 
> 'git diff' in the make_patch function. Is this an artefact?

It was an explicit request by people who use git-rebase regularly, and 
missed being able to see the patch in --interactive.

> I'd like to get rid of this use of 'git diff' because it invokes 
> external diff drivers, which is totally unwanted if the driver is 
> interactive - like the 'windiff' thing that I posted a week ago.

So you do not want to be able to run git-rebase (without -i)?

Ciao,
Dscho
