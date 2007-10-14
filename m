From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git User's Survey 2007 unfinished summary continued
Date: Sun, 14 Oct 2007 21:18:16 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710142117220.25221@racer.site>
References: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com>
 <8fe92b430710121508g13917080mac156250abfccf20@mail.gmail.com>
 <Pine.LNX.4.64.0710130130380.25221@racer.site> <853awepyz6.fsf@lola.goethe.zz>
 <20071013202713.GA2467@fieldses.org> <Pine.LNX.4.64.0710140135020.25221@racer.site>
 <alpine.LFD.0.999.0710131810550.6887@woody.linux-foundation.org>
 <20071014014445.GN27899@spearce.org> <3f4fd2640710140320h5c1e1f7gf9f43a626aaa6897@mail.gmail.com>
 <47125BF7.2070503@midwinter.com> <20071014184050.GB31260@fieldses.org>
 <471272F5.2000902@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Steven Grimm <koreth@midwinter.com>,
	Reece Dunn <msclrhd@googlemail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Sun Oct 14 22:18:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih9v7-0003rK-OO
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 22:18:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757621AbXJNUS0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 16:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754497AbXJNUSZ
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 16:18:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:34672 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752369AbXJNUSY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 16:18:24 -0400
Received: (qmail invoked by alias); 14 Oct 2007 20:18:23 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp031) with SMTP; 14 Oct 2007 22:18:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18sNxh4+h0sU5g/T/t3/QoJJL2Ibfz4oK1sMVTx2k
	KbDBa50UjhR2m5
X-X-Sender: gene099@racer.site
In-Reply-To: <471272F5.2000902@op5.se>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60900>

Hi,

On Sun, 14 Oct 2007, Andreas Ericsson wrote:

> J. Bruce Fields wrote:
>
> > Though actually the quickest way to checkout an arbitrary revision is 
> > with detached heads, and that doesn't require learning git-branch 
> > right away.
> 
> But the *easiest* way, where "easiest" means "involves the fewest 
> commands with smallest risk of fscking up your own repo", is to do
> 
> 
> git clone <other-devs-repo> other-devs-repo
> cd other-devs-repo
> git checkout -b thebug <the-bug-hash>

I'd just do

	git checkout <the-bug>^{commit}

and be done...

Ciao,
Dscho
