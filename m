From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH] Add subcommand "help" to the list of most commonly used subcommands
Date: Thu, 5 Jun 2008 13:52:04 +0300
Message-ID: <20080605105204.GA17979@mithlond.arda.local>
References: <alpine.DEB.1.00.0806050747000.21190@racer> <20080605081911.GA5946@mithlond.arda.local> <alpine.DEB.1.00.0806051131310.21190@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 05 12:53:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4D5f-0005l1-Ij
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 12:53:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754957AbYFEKwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 06:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754455AbYFEKwK
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 06:52:10 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:47009 "EHLO
	kirsi1.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754775AbYFEKwH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 06:52:07 -0400
Received: from mithlond.arda.local (80.220.180.181) by kirsi1.rokki.sonera.fi (8.5.014)
        id 483E837C005A9212; Thu, 5 Jun 2008 13:52:05 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1K4D4e-0005BA-IW; Thu, 05 Jun 2008 13:52:04 +0300
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0806051131310.21190@racer>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83899>

Johannes Schindelin wrote (2008-06-05 11:32 +0100):

> On Thu, 5 Jun 2008, Teemu Likonen wrote:
> 
> > Add subcommand "help" to the list of most commonly used subcommands
> 
> Hrmpf.  IMO "help" is not really a _git_ command.  And I use it
> really, really rarely.

But you know git inside out, don't you? It seems common to have such
help command: svn help, bzr help, hg help. They all list "help" as one
of the subcommands. I don't know anything about "being really a git
command" but from user interface's point of view "git help" is a git
command. It's even advertised in output of other git commands (well, at
least "git gc --auto").

Anyway, I'd change the short description of "git help" to be more
informative so I'd separate the changes. Version 2 follows.
