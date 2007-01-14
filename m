From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Importing from tarballs; add, rm, update-index?
Date: Sun, 14 Jan 2007 13:42:04 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701141340020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <6efbd9b70701120541n5dc4d0e1va50ae96543d8c80@mail.gmail.com>
 <slrneqha0g.5sa.Peter.B.Baumann@xp.machine.xx>
 <E5A7E6A8-45FF-4A7A-A31E-DFEBAD48DF1C@silverinsanity.com>
 <200701131815.27481.alan@chandlerfamily.org.uk>
 <8E585186-FC3F-473B-BA1F-91CFEF1A63F4@silverinsanity.com>
 <20070113203456.GA17648@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Alan Chandler <alan@chandlerfamily.org.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 14 13:42:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H64gm-0004Z8-RS
	for gcvg-git@gmane.org; Sun, 14 Jan 2007 13:42:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbXANMmJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Jan 2007 07:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbXANMmJ
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jan 2007 07:42:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:57568 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751263AbXANMmH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jan 2007 07:42:07 -0500
Received: (qmail invoked by alias); 14 Jan 2007 12:42:05 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp041) with SMTP; 14 Jan 2007 13:42:05 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070113203456.GA17648@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36801>

Hi,

On Sat, 13 Jan 2007, Shawn O. Pearce wrote:

> Brian Gernhardt <benji@silverinsanity.com> wrote:
> > Yes.  It sounds very much like you want to simply do "git add . ; git  
> > commit -a".  But making that the default for "commit -a" would be  
> > obnoxious for many other people.
> 
> I find it annoying that "commit -a" isn't implemented in terms of
> "git add .".  Mainly because I'll make a number of changes in Eclipse
> then go back and do "commit -a" and only days later discover that
> I have untracked files in my working directory which should have
> been added to the commit several days ago.

You mean, you _ignored_ the text "git commit -a" gives you? It really 
shows you the output of "git status", exactly so you know what you 
committed, and sometimes more importantly, what you didn't.

I mean, "git commit" spends a lot of time getting that information, so you 
better use it.

Ciao,
Dscho
