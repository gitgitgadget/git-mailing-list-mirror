From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Ensure that SSH runs in non-interactive mode
Date: Sun, 20 Jul 2008 20:33:30 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807202029310.3305@eeepc-johanness>
References: <1216487215-6927-1-git-send-email-fredrik@dolda2000.com>  <1216490252.10694.58.camel@koto.keithp.com>  <1216491512.3911.9.camel@pc7.dolda2000.com>  <alpine.DEB.1.00.0807201214060.3305@eeepc-johanness> <1216576183.3673.2.camel@pc7.dolda2000.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Keith Packard <keithp@keithp.com>, git@vger.kernel.org,
	"Edward Z. Yang" <edwardzyang@thewritingpot.com>,
	Steffen Prohaska <prohaska@zib.de>
To: Fredrik Tolf <fredrik@dolda2000.com>
X-From: git-owner@vger.kernel.org Sun Jul 20 20:33:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKdj4-0002MN-5Q
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 20:33:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbYGTScn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 14:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbYGTScn
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 14:32:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:60598 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750702AbYGTScm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 14:32:42 -0400
Received: (qmail invoked by alias); 20 Jul 2008 18:32:40 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp026) with SMTP; 20 Jul 2008 20:32:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18r90hSR+krVxC4Q1/7Z0jIh7zVmI0zVcxKtUSjqA
	PIijwt0f1+fWjW
X-X-Sender: user@eeepc-johanness
In-Reply-To: <1216576183.3673.2.camel@pc7.dolda2000.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89211>

Hi,

On Sun, 20 Jul 2008, Fredrik Tolf wrote:

> On Sun, 2008-07-20 at 12:27 +0200, Johannes Schindelin wrote:
>
> > Well, this was to be expected, after what I wrote in response to 3. in 
> > http://thread.gmane.org/gmane.comp.version-control.git/76650/focus=2598
> > 
> > Reality always catches up with you, and here again we see that plink 
> > and other siblings of OpenSSH should be best handled with scripts, 
> > preferably ones that strip out options they do not recognize.
> 
> Otherwise, an alternative may be to always install a script, say 
> `git-ssh', that would invoke the real SSH in a manner specific for the 
> platform. The exact script installed could even be parametrized by the 
> Makefile. For systems using OpenSSH, it would probably just consist of 
> `ssh -xT "$@"'.
> 
> What do you think?

Umm, why?  I fully expect OpenSSH to be the most common ssh helper.  I 
fail to see why we should optimize for something else.

The GIT_SSH solution works.  Why not just leave things like they are?

Ciao,
Dscho
