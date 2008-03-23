From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Working copy revision and push pain
Date: Sun, 23 Mar 2008 15:11:12 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803231508320.4353@racer.site>
References: <47E64F71.3020204@jwatt.org> <alpine.LSU.1.00.0803231401340.4353@racer.site> <47E658D3.1060104@jwatt.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jonathan Watt <jwatt@jwatt.org>
X-From: git-owner@vger.kernel.org Sun Mar 23 15:12:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdQvS-0007G7-57
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 15:11:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755724AbYCWOLO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 10:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756027AbYCWOLN
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 10:11:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:60976 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755686AbYCWOLN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 10:11:13 -0400
Received: (qmail invoked by alias); 23 Mar 2008 14:11:11 -0000
Received: from host86-148-26-43.range86-148.btcentralplus.com (EHLO racer.home) [86.148.26.43]
  by mail.gmx.net (mp051) with SMTP; 23 Mar 2008 15:11:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+X64VBKtSXf+OLZOPpbCKhaKd3ooiU8QnJMK3sSY
	xh/SnC3TlwyFVo
X-X-Sender: gene099@racer.site
In-Reply-To: <47E658D3.1060104@jwatt.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77903>

Hi,

On Sun, 23 Mar 2008, Jonathan Watt wrote:

> Johannes Schindelin wrote:
> 
> > On Sun, 23 Mar 2008, Jonathan Watt wrote:
> > 
> >> There seems to be a problem with git-push when the working copy of 
> >> the directory being pushed to came from the magic revision HEAD, but 
> >> not when the working copy came from some other revision.
> > 
> > http://git.or.cz/gitwiki/GitFaq#head-b96f48bc9c925074be9f95c0fce69bcece5f6e73
> > 
> > Sidenote: I am constantly amazed how people have no problem accepting 
> > that a CVS-Server has no working directory, but all of a sudden think 
> > that a Git-server should have one, and auto-update it.
> 
> I think you've misread my email. (Or not read it. ;-))

Well, I did.  Thank you very much.

> I do not expect git-push to update the working copy of the repository 
> being pushed to. In fact my complaint would be more that it *does* 
> appear to modify the working copy (well, not so much modify the working 
> copy as get confused about which revision the working copy came from) 
> when the working copy came from HEAD.

You changed the current branch via push.  HEAD is the tip of the current 
branch.  <rhetoric>What else should happen?</rhetoric>

Your notion that the working tree has somehow a magic state that is not 
dependent on the current branch is somewhat strange to me.

Ciao,
Dscho
