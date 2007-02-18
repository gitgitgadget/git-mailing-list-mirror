From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: piped to a pager (was: how to speed up "git log"?)
Date: Sun, 18 Feb 2007 01:10:00 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702180109400.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200702111252.28393.bruno@clisp.org> <200702172019.20536.bruno@clisp.org>
 <Pine.LNX.4.63.0702180019040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <200702180109.26412.bruno@clisp.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Bruno Haible <bruno@clisp.org>
X-From: git-owner@vger.kernel.org Sun Feb 18 01:10:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIZd2-0006jW-IY
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 01:10:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965437AbXBRAKF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 19:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965438AbXBRAKF
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 19:10:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:52698 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965437AbXBRAKD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 19:10:03 -0500
Received: (qmail invoked by alias); 18 Feb 2007 00:10:00 -0000
X-Provags-ID: V01U2FsdGVkX18I4VR5FzMIPfJChIbrFdw7UrPxuXBFz55yWKesJw
	eO6w==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200702180109.26412.bruno@clisp.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40036>

Hi,

On Sun, 18 Feb 2007, Bruno Haible wrote:

> Johannes Schindelin wrote:
> > you can blame the person calling git log and waiting until it 
> > finishes. See the list archives for reasons why.
> ... and earlier:
> > Usually the output of git-log -- even with pathname 
> > filtering -- starts almost instantaneous, and is piped to your pager.
> 
> The pager ('less') in a console is not a good solution for everone:
>   - People used to GUI editors (kate, nedit, ...) miss a scroll bar for
>     navigation. You can't use kate or nedit as a pager.
>   - PAGER="vi -" also reads all input before it displays anything.
>   - PAGER="xless" likewise.
>   - In Emacs shell-mode, with PAGER="", you see the output as it is produced,
>     but it's disturbing to work in a buffer which is growing, where the scrollbar
>     continues to change its position.
> 
> It's OK for many people, but not for everyone.

So why don't you go scratch that itch, and write a decent GUI pager?

Ciao,
Dscho
