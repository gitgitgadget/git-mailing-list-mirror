From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: MinGW binary installer available
Date: Thu, 8 Feb 2007 22:26:05 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702082224380.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45C9E470.7030609@xs4all.nl> <45C9EB54.3040406@xs4all.nl>
 <45CADAAA.74058D21@eudaptics.com> <200702082215.50389.robin.rosenberg.lists@dewire.com>
 <Pine.LNX.4.63.0702082216000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070208212259.GA1091@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Feb 08 22:26:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFGmW-0006w0-HE
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 22:26:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423414AbXBHV0M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 16:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423415AbXBHV0M
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 16:26:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:56593 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1423414AbXBHV0K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 16:26:10 -0500
Received: (qmail invoked by alias); 08 Feb 2007 21:26:09 -0000
X-Provags-ID: V01U2FsdGVkX1/gEd9ZxMzg+UAnuyLQi00AO86Q2Pp1rqyqBRg/Q+
	khDw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070208212259.GA1091@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39097>

Hi,

On Thu, 8 Feb 2007, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Frankly, I'd rather stay away from such hackeries. For now, we can ship 
> > bash, perl and Tcl/Tk with Git, as well as git-gui, can't we? After all, 
> > Windows users are used to bloatware. Then, we just hide the command line 
> > from them!
> 
> I agree.
> 
> I'm happy to make changes in git-gui to help users who are trying
> to use Git without Cygwin, and are on Windows.  Patches would be
> even more welcome of course.  ;-)
> 
> Most of git-gui tries to stay away from shell scripts, partly for
> this reason, and partly because its Porcelain and shouldn't depend
> on the stock Porcelain-ish that comes with Git.  Oh, and shell
> scripts on Cygwin aren't speed-demons.  :-)

I was talking about MinGW. Shipping MSYS' bash, perl and tcltk would not 
be impossible. And configuring git-gui to be started with MSYS' wish would 
solve the common problems calling bash scripts.

Ciao,
Dscho
