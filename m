From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: MinGW port usable
Date: Tue, 30 Jan 2007 11:16:44 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701301114590.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701292320.43888.johannes.sixt@telecom.at> 
 <20070129223513.GA31372@spearce.org>  <46d6db660701291511v700bfcf7l4851dd6be4fc6e03@mail.gmail.com>
  <20070129232425.GB31372@spearce.org>  <46d6db660701292359v7647306fla30c9a10e5989dcc@mail.gmail.com>
 <46d6db660701300007v573832b5pc7ac41059dc4490e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Christian MICHON <christian.michon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 30 11:16:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBq2k-0006DK-1e
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 11:16:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752614AbXA3KQr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 05:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752650AbXA3KQr
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 05:16:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:59208 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752614AbXA3KQq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 05:16:46 -0500
Received: (qmail invoked by alias); 30 Jan 2007 10:16:45 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp005) with SMTP; 30 Jan 2007 11:16:45 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <46d6db660701300007v573832b5pc7ac41059dc4490e@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38148>

Hi,

On Tue, 30 Jan 2007, Christian MICHON wrote:

> On 1/30/07, Christian MICHON <christian.michon@gmail.com> wrote:
> > On 1/30/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> > > Try creating a desktop icon (Repository->Create Desktop Icon) and
> > > start git-gui from the resulting .bat file.  It *should* come up
> > > right on MinGW, but I'm only guessing here.
> > 
> > ok, yes it's working. :)
> > but call gitk from inside it fail :(
> > 
> > "error in startup script"
> > ( git-peek-remote is not working from git-gui, could be path related.
> > It's hard to tell why yet)
> > 
> > --
> > Christian
> > 
> 
> just to be more clear: when using the .bat shortcut, calling gitk
> > from within git-gui fails.

I guess you need to change the .bat shortcut, so that the tcl script is 
called via bash instead of directly from cmd.

Otherwise git-gui does not have a chance to find the MSYS environment.

Ciao,
Dscho
