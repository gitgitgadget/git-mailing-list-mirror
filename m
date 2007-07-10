From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [WIP] Get rid of msys in favor of busybox port for windows
Date: Tue, 10 Jul 2007 17:20:48 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707101719390.4047@racer.site>
References: <fcaeb9bf0707100832j3c2ff076gab5c9bd4f9d3f4a0@mail.gmail.com> 
 <Pine.LNX.4.64.0707101638521.4047@racer.site>
 <fcaeb9bf0707100908o4be761b9t920cdc65a72d9aee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 10 18:28:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8IZr-0000wn-37
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 18:28:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756152AbXGJQ2d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 12:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755667AbXGJQ2d
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 12:28:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:36659 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754655AbXGJQ2c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 12:28:32 -0400
Received: (qmail invoked by alias); 10 Jul 2007 16:28:29 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp057) with SMTP; 10 Jul 2007 18:28:29 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/eAAgnMD3eQPtaYgomDG9bRlGtN51spIxwxKcMLM
	oqR136fAyMCIC/
X-X-Sender: gene099@racer.site
In-Reply-To: <fcaeb9bf0707100908o4be761b9t920cdc65a72d9aee@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52091>

Hi,

On Tue, 10 Jul 2007, Nguyen Thai Ngoc Duy wrote:

> On 7/10/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > 
> > On Tue, 10 Jul 2007, Nguyen Thai Ngoc Duy wrote:
> > 
> > > I'm integrating some code from busybox to mingw tree so that mingw port
> > > can work without msys. Posix utilities such as sed, awk, head, tail...
> > > seem to work well. The main obstacle is ash, which is no where near
> > > usable state (fork issues as always). Busybox ash is about 13000 lines
> > > of code, not too big.
> > >
> > > Anyone interested in?
> > 
> > Definitely.
> > 
> > Last time I wanted to assess how much work it is to compile that on MinGW,
> > though, it seemed to be too much to be tractable.
> 
> The exact answer is "I don't know" :-) I cross compile all the time
> however it should build fine on MinGW as it now uses git Makefile.
> I'll push the patch into mob soon.

Do you mean the whole busybox thing?

If so, please do not put it into mingw.git.  Rather, start a busybox.git 
project (I saw that you have already some projects on repo.or.cz, so it 
should be easy for you.)

Thanks,
Dscho
