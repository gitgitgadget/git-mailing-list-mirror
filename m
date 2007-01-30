From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: MinGW port usable
Date: Tue, 30 Jan 2007 17:49:22 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701301746310.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701292320.43888.johannes.sixt@telecom.at>
 <Pine.LNX.4.64.0701291438580.3611@woody.linux-foundation.org>
 <Pine.LNX.4.63.0701301524360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070130151803.GA25779@spearce.org> <Pine.LNX.4.63.0701301635050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070130155653.GB25950@spearce.org> <Pine.LNX.4.63.0701301708160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070130162835.GD25950@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jan 30 17:49:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBwAi-0006c3-D7
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 17:49:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965613AbXA3QtZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 11:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965614AbXA3QtZ
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 11:49:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:50975 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965610AbXA3QtY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 11:49:24 -0500
Received: (qmail invoked by alias); 30 Jan 2007 16:49:22 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp002) with SMTP; 30 Jan 2007 17:49:22 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070130162835.GD25950@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38169>

Hi,

On Tue, 30 Jan 2007, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > I wonder what the difference is between NO_MMAP=Yes and NO_MMAP=
> > > on Windows.
> > Cygwin:
> > 	real    0m0.812s
> > and
> > 	real    0m2.094s
> > 
> > IOW, the numbers are slightly worse (!) than with mmap().
> 
> Slightly?  That's double the time!

Nope. What I meant is this: rev-list takes 0.8s without NO_MMAP, while it 
takes 0.75s with NO_MMAP, and similarly log takes 2.09s without NO_MMAP, 
while it takes 2.065 with NO_MMAP.

> > MinGW does not even have mmap().
> 
> But Windows has something almost there.

Yeah, CreateFile(). Very intuitive name.

>  I just read a flame war thread about implementing mmap in libiberty for 
> MinGW by stealing source from Cygwin, and how the FSF might feel about 
> someone's dirty feet after playing rugby.

;-)

> Yea... Google is good.  :)

Well, I had _horrible_ results in the last two weeks, slowly getting 
better.

Ciao,
Dscho
