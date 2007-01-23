From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: MinGW port - initial work uploaded
Date: Tue, 23 Jan 2007 15:18:25 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701231517290.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701192148.20206.johannes.sixt@telecom.at> 
 <46d6db660701220506t20214d3bi4d0e1e93abd01aad@mail.gmail.com> 
 <200701222127.09601.johannes.sixt@telecom.at> 
 <Pine.LNX.4.63.0701231227200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <46d6db660701230512l571d8c35k24e475c3fe0933cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 15:18:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9MTm-0008EP-1W
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 15:18:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932911AbXAWOS1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 09:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932950AbXAWOS1
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 09:18:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:38373 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932911AbXAWOS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 09:18:26 -0500
Received: (qmail invoked by alias); 23 Jan 2007 14:18:25 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp042) with SMTP; 23 Jan 2007 15:18:25 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Christian MICHON <christian.michon@gmail.com>
In-Reply-To: <46d6db660701230512l571d8c35k24e475c3fe0933cf@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37522>

Hi,

On Tue, 23 Jan 2007, Christian MICHON wrote:

> On 1/23/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Maybe we have to go the other way round, just as POSIX git does: instead
> > of spawning the pager, we should _beginthread() the actual work, and
> > execl() the pager.
> 
> actually, one other issue is the spawning of vim when doing commits.
> I usually end up in using -m "my commit message" because of these
> 2 errors (basically terminal not recognized, I tried many different
> options to no avail)
> 
> $ git commit -a
> Vim: Warning: Output is not to a terminal
> Vim: Warning: Input is not from a terminal
> 
> > On the third hand, I fully expect git on Windows to be used only by GUI
> > wieners who cannot handle the command line, let alone a pager! ("WTF! How
> > do I go back to that dollar thingie? You know, where I type git-blabla?")
> 
> maybe I'm stuck with windows at work, but I still use vim inside mingw.

I don't:

$ vi
m.AllocationBase 0x0, m.BaseAddress 0x715B0000, m.RegionSize 0x4D0000, 
m.State 0x10000
C:\msys1\bin\vim.exe: *** Couldn't reserve space for cygwin's heap 
(0x715B0000 <0xB10000>) in child, Win32 error 487

> it would be nice to fix the pager issue...

Go ahead!

Ciao,
Dscho
