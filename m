From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 9/9] Build in checkout
Date: Tue, 5 Feb 2008 22:45:53 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802052244160.8543@racer.site>
References: <alpine.LNX.1.00.0802041336060.13593@iabervon.org> <alpine.LSU.1.00.0802050143050.8543@racer.site> <alpine.LNX.1.00.0802042201060.13593@iabervon.org> <alpine.LSU.1.00.0802052205210.8543@racer.site>
 <alpine.LNX.1.00.0802051716220.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Feb 05 23:47:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMWZR-0002IQ-Lo
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 23:47:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758161AbYBEWqh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 17:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762691AbYBEWqh
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 17:46:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:35705 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762355AbYBEWqe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 17:46:34 -0500
Received: (qmail invoked by alias); 05 Feb 2008 22:46:32 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp044) with SMTP; 05 Feb 2008 23:46:32 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19wUSsxx41wSfCbRY3g45FCBR+WcMWoR++wzXq38m
	wIQ7TdgoHDta4x
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LNX.1.00.0802051716220.13593@iabervon.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72714>

Hi,

On Tue, 5 Feb 2008, Daniel Barkalow wrote:

> On Tue, 5 Feb 2008, Johannes Schindelin wrote:
> 
> > I suggested that: to prevent the index from needing an update.
> > 
> > This is quite important if you have a large working tree, and switch 
> > branches from A to B.  For example, "make" will punish you where it 
> > hurts.
> 
> This isn't used for switching branches; this is used for checking out 
> paths. If you do "git checkout <not-head> -- <every single path>", make 
> will punish you, but why would you do that? I'd guess that people are 
> unlikely to have a significant number of non-changes in this piece of 
> code, just because they wouldn't list things that they didn't think had 
> changes.

For convenience, you can also say

	$ git checkout -- <path>

and expect checkout to not really touch the unchanged files.

Ciao,
Dscho
