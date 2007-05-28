From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: GIT on MinGW problem
Date: Mon, 28 May 2007 01:04:09 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705280059520.4648@racer.site>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500> <46592CFE.40303@xs4all.nl>
 <4659318B.20801@midwinter.com> <200705271109.11942.jnareb@gmail.com>
 <465A11AB.6060906@xs4all.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
X-From: git-owner@vger.kernel.org Mon May 28 02:04:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsSir-000142-2K
	for gcvg-git@gmane.org; Mon, 28 May 2007 02:04:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753016AbXE1AEW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 20:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753363AbXE1AEW
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 20:04:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:45565 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753016AbXE1AEV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 20:04:21 -0400
Received: (qmail invoked by alias); 28 May 2007 00:04:19 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp014) with SMTP; 28 May 2007 02:04:19 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+heQMWfoSh/bzQod8NDEF/b+sIMvk1uPYRHtYMv2
	n9WN97SY8ZgkbO
X-X-Sender: gene099@racer.site
In-Reply-To: <465A11AB.6060906@xs4all.nl>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48600>

Hi,

On Sun, 27 May 2007, Han-Wen Nienhuys wrote:

> Jakub Narebski escreveu:
> > On Sun, 27 May 2007, Steven Grimm wrote:
> >> Han-Wen Nienhuys wrote:
> >>> Shawn O. Pearce escreveu:
> >>>> On systems like Cygwin the fork+exec overheads are very high
> >>> A well written configure script is able to detect presence
> >>> of a linkable libcurl.
> >> IMO the reasons configure is so unwieldy, at least as it's set up in 
> >> most open source projects, are that a) it spends 95% of its time 
> >> checking for things that basically never vary (yes, I have stdlib.h, 
> >> thank you) and that b) it doesn't remember the results from previous 
> >> runs on the same host (I'm just changing the install path; my ints won't 
> >> have stopped being 32 bits as a result.)
> > 
> > ./configure _can_ cache tests results:
> > 
> > $ ./configure --help
> > [...]
> >       --cache-file=FILE   cache test results in FILE [disabled]
> >   -C, --config-cache      alias for `--cache-file=config.cache'
> > 
> > but it does not do this, and does not check chache by default. Of course
> > tests have to be written to make use of cache, IIRC...
> 
> Slowness is a misguided argument as well.  Yes, configure is slow, but 
> you only have to run it if configure.in , config.h.in or config.make.in 
> chagnes. And that doesn't happen very often during development.

Slowness is a good argument. The config does change from time to time (you 
should know, IICC LilyPond had 36 changes in configure.in through 2006). 
And it is annoying.

Especially when you are trying to debug ./configure.

Ciao,
Dscho
