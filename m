From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Switching from CVS to GIT
Date: Mon, 15 Oct 2007 21:46:50 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710152144480.25221@racer.site>
References: <Pine.LNX.4.64.0710142112540.25221@racer.site>
 <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org>
 <Pine.LNX.4.64.0710150039120.25221@racer.site> <4712B616.165BBF8D@dessent.net>
 <Pine.LNX.4.64.0710150217120.25221@racer.site> <20071015175606.GE2966@steel.home>
 <4713B367.52CEC7E2@dessent.net> <Pine.LNX.4.64.0710151938300.25221@racer.site>
 <4713BA89.633B86F2@dessent.net> <20071015194214.GC15541@steel.home>
 <4713C81F.A75FEFC2@dessent.net> <Pine.LNX.4.64.0710152117290.25221@racer.site>
 <7287AD62-3274-4B20-881C-D02E08C4B2EF@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Alex Riesen <raa.lkml@gmail.com>, Eli Zaretskii <eliz@gnu.org>,
	Andreas Ericsson <ae@op5.se>, tsuna@lrde.epita.fr
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Oct 15 23:41:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhWqD-00065D-5M
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 22:47:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759821AbXJOUq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 16:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758461AbXJOUq5
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 16:46:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:51864 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755158AbXJOUq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 16:46:56 -0400
Received: (qmail invoked by alias); 15 Oct 2007 20:46:55 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp028) with SMTP; 15 Oct 2007 22:46:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19SICBh6rdSYFLa9YIBZI66o1x7tuXbMHi1vQNBOV
	4YE/FRjvYK62tL
X-X-Sender: gene099@racer.site
In-Reply-To: <7287AD62-3274-4B20-881C-D02E08C4B2EF@zib.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61044>

Hi,

On Mon, 15 Oct 2007, Steffen Prohaska wrote:

> On Oct 15, 2007, at 10:19 PM, Johannes Schindelin wrote:
> 
> > There is a port of BusyBox' dash, which is nearing completion.  Once 
> > Nguyen says it is ready enough, we will try to integrate it into 
> > msysGit.
> 
> Gnuarch [1] recommends zsh from the unxutils project [2].

I have the slight suspicion that we will somehow have problems with 
/etc/gitconfig, /share/git-gui/ and friends, should we try to use zsh.  At 
least with gitbox, we can hack a "/" translation for scripts.

Ciao,
Dscho
