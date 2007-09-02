From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-gui i18n status?
Date: Sun, 2 Sep 2007 13:20:48 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709021320230.28586@racer.site>
References: <20070901042924.GE18160@spearce.org> <Pine.LNX.4.64.0709020003480.28586@racer.site>
 <20070902014242.GJ18160@spearce.org> <20070902022444.GK18160@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christian Stimming <stimming@tuhh.de>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Nanako Shiraishi <nanako3@bluebottle.com>,
	Michele Ballabio <barra_cuda@katamail.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Xudong Guan <xudong.guan@gmail.com>,
	Harri Ilari Tapio Liusvaara <hliusvaa@cc.hut.fi>,
	Junio C Hamano <gitster@pobox.com>,
	Irina Riesen <irina.riesen@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Sep 02 14:21:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRoS3-0006oy-Sj
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 14:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757328AbXIBMVL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 08:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756903AbXIBMVK
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 08:21:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:44945 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757214AbXIBMVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 08:21:09 -0400
Received: (qmail invoked by alias); 02 Sep 2007 12:21:07 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp027) with SMTP; 02 Sep 2007 14:21:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19hBvZIbkxhLjBfbL7VDDNwmCJl0RbpDRV3I7Ma2e
	xOCDGkIVZyvlJA
X-X-Sender: gene099@racer.site
In-Reply-To: <20070902022444.GK18160@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57319>

Hi,

On Sat, 1 Sep 2007, Shawn O. Pearce wrote:

> "Shawn O. Pearce" <spearce@spearce.org> wrote:
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > Hmm.  I am not enough involved in i18n stuff to form a proper opinion 
> > > here...  Do you suggest to move the initialisation earlier?
> > 
> > Yea, I think that's what we are going to have to do here.  If we don't
> > setup the directory for the .msg files early enough than we cannot do
> > translations through [mc].  Unfortunately that means we have to also
> > break up the library initialization.
> > 
> > I'll try to work up a patch that does this.
> 
> This two patch series is based on my current master (gitgui-0.8.2).
> Its also now in my pu branch.

Sound both good to me.  Christian?

Ciao,
Dscho
