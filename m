From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: MinGW binary installer available
Date: Thu, 8 Feb 2007 22:18:41 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702082216000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45C9E470.7030609@xs4all.nl> <45C9EB54.3040406@xs4all.nl>
 <45CADAAA.74058D21@eudaptics.com> <200702082215.50389.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Thu Feb 08 22:18:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFGfP-0003BO-Lw
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 22:18:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423407AbXBHVSq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 16:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423409AbXBHVSq
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 16:18:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:33120 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1423407AbXBHVSo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 16:18:44 -0500
Received: (qmail invoked by alias); 08 Feb 2007 21:18:43 -0000
X-Provags-ID: V01U2FsdGVkX1/S7gFibgnSHjC7AAqPNTXJEwj+2zzvQOEykoW2R0
	KVag==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200702082215.50389.robin.rosenberg.lists@dewire.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39094>

Hi,

On Thu, 8 Feb 2007, Robin Rosenberg wrote:

> torsdag 08 februari 2007 09:09 skrev Johannes Sixt:
> > 
> > @echo off
> > rem () { :; } ; : \
> > sh %0 %1 %2 %3 %4 %5 %6 %7 %8 %9
> > rem ; : \
> > exit /B %ERRORLEVEL%
> > 
> > 
> > in place of the usual "#!/bin/sh". It requires you to have a command
> > named @echo.exe in the path that is a noop. Also, it is limited to 9
> > command line arguments.
> > 
> > What a hack! (*)
> 
> Yes... I suggest you use %* to pass on all arguments. It works with more 
> than 10 arguemtns, including quoted arguemnts (presumably whatever limit 
> windows has)

... but probably breaks down on Windows 98, and maybe on ME, too, and just 
maybe on XP pre-SP1 with full moon, unless you end the life of a black 
goat before trying that.

Frankly, I'd rather stay away from such hackeries. For now, we can ship 
bash, perl and Tcl/Tk with Git, as well as git-gui, can't we? After all, 
Windows users are used to bloatware. Then, we just hide the command line 
from them!

Ciao,
Dscho
