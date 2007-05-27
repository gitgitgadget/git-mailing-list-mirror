From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: GIT on MinGW - No symbolic links support
Date: Mon, 28 May 2007 00:56:01 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705280054140.4648@racer.site>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500> <464534EE.30904@xs4all.nl>
 <4656A304.AF39A0B6@eudaptics.com> <f3a2ke$9s7$1@sea.gmane.org>
 <4659D306.6030803@xs4all.nl> <f3cnm6$gda$1@sea.gmane.org>
 <00a601c7a09f$218c1020$0200a8c0@AMD2500> <4659F5D0.2070406@xs4all.nl>
 <00b901c7a0a5$77983420$0200a8c0@AMD2500> <00c401c7a0a7$8a5690a0$0200a8c0@AMD2500>
 <f329bf540705271455m4c0f5a55v14b9a8cc6bd7778d@mail.gmail.com>
 <00ef01c7a0ad$78508e00$0200a8c0@AMD2500>  <465A061C.7010803@xs4all.nl>
 <012d01c7a0b2$374eea50$0200a8c0@AMD2500>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: hanwen@xs4all.nl, git@vger.kernel.org
To: Aaron Gray <angray@beeb.net>
X-From: git-owner@vger.kernel.org Mon May 28 01:56:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsSbA-00085A-UD
	for gcvg-git@gmane.org; Mon, 28 May 2007 01:56:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752905AbXE0X4M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 19:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753305AbXE0X4M
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 19:56:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:42477 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752905AbXE0X4M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 19:56:12 -0400
Received: (qmail invoked by alias); 27 May 2007 23:56:09 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp032) with SMTP; 28 May 2007 01:56:09 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/2jOY8DFL2DFTQGfxLEni0QtMhiUCCv5wUOwi96o
	1vBHAMPJsxqMXg
X-X-Sender: gene099@racer.site
In-Reply-To: <012d01c7a0b2$374eea50$0200a8c0@AMD2500>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48599>

Hi,

On Sun, 27 May 2007, Aaron Gray wrote:

> Bit of a dampener on GIT on MinGW :-
> 
>        $ git clone git://git.kernel.org/pub/scm/git/git.git
>        Initialized empty Git repository in C:/MSYS/src/git/.git/
>        error: git-checkout-index: unable to create symlink RelNotes (Function
> not implemented)
> 
> No Symbolic links !
> 
> There are symbolic links provided by Windows by SFU (Services For Unix)
> apparently.

Does not work on FAT. Has lots of problems.

That's why Johannes Sixt pushed for core.symlinks, and got it. So maybe 
the templates should set core.symlinks=false?

Ciao,
Dscho
