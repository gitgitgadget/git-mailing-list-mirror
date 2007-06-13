From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: pull into dirty working tree
Date: Thu, 14 Jun 2007 00:32:13 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706140030400.4059@racer.site>
References: <1HyUO6-04z4yG0@fwd28.aul.t-online.de> <Pine.LNX.4.64.0706131929020.4059@racer.site>
 <18032.15862.835008.22589@lisa.zopyra.com> <200706132217.57075.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bill Lear <rael@zopyra.com>,
	Michael Dressel <MichaelTiloDressel@t-online.de>,
	git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Thu Jun 14 01:35:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HycNG-0000HG-H1
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 01:35:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755481AbXFMXfh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 19:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755461AbXFMXfh
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 19:35:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:57640 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753850AbXFMXfg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 19:35:36 -0400
Received: (qmail invoked by alias); 13 Jun 2007 23:35:35 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp033) with SMTP; 14 Jun 2007 01:35:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+x/4VJEkmxt+R6/D6yIAC3HKi7C4UzmS0KLqU65Z
	qO8eqdtRYThmC5
X-X-Sender: gene099@racer.site
In-Reply-To: <200706132217.57075.robin.rosenberg.lists@dewire.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50148>

Ho,

On Wed, 13 Jun 2007, Robin Rosenberg wrote:

> A typical case I recognize is a few printfs or disabling a feature that 
> makes it harder to debug with no intentions whatsoever to commit them. 
> What we see when the tools more or less forces people to "temporarily" 
> commit stuff is that that stuff is often left there. "Oh, I forgot". 
> Gah.
> 
> Git has this ability when checking out, so why not on pull or merge?

You should hold your breath for git-stash. Now that Junio declared he'd 
work on it.

> With stacked git I typically create a new patch, then I can push it 
> whenever I want to have some more tracing.

My evil plan is to work git-stash into sort of a lightweight StGit. I 
never liked that dependency to Python, and I always felt that it must be 
simpler than that.

Ciao,
Dscho
