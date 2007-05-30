From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: GIT on MinGW problem
Date: Wed, 30 May 2007 03:39:08 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705300337510.4011@racer.site>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500> <464534EE.30904@xs4all.nl>
   <4656A304.AF39A0B6@eudaptics.com> <f3a2ke$9s7$1@sea.gmane.org>  
 <465C064F.B9CE9379@eudaptics.com> <465C1252.9020801@trolltech.com>  
 <Pine.LNX.4.64.0705291305540.4648@racer.site>   <465C2516.7040607@trolltech.com>
   <Pine.LNX.4.64.0705291446170.4648@racer.site>   <465C3502.BE134BC9@eudaptics.com>
 <fcaeb9bf0705290828j3703cfa9g11f2f7afb17a8c91@mail.gmail.com>
 <465C4B0E.C34795B@eudaptics.com> <465CDE61.40103@xs4all.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <J.Sixt@eudaptics.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Marius Storm-Olsen <marius@trolltech.com>, git@vger.kernel.org
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
X-From: git-owner@vger.kernel.org Wed May 30 04:41:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtE7Y-00054m-Re
	for gcvg-git@gmane.org; Wed, 30 May 2007 04:41:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752001AbXE3Ck4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 22:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752125AbXE3Ck4
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 22:40:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:38668 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752001AbXE3Cky (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 22:40:54 -0400
Received: (qmail invoked by alias); 30 May 2007 02:40:52 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp026) with SMTP; 30 May 2007 04:40:52 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+rk9h0o7CrC4tclR12+F79JHsqcxe97eyc3+6wi/
	PhyubLhI58H8Ib
X-X-Sender: gene099@racer.site
In-Reply-To: <465CDE61.40103@xs4all.nl>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48725>

Hi,

On Tue, 29 May 2007, Han-Wen Nienhuys wrote:

> Johannes Sixt escreveu:
> >> I'd suggest create a small C wrapper to launch gitk. It would be much
> >> easier that way IMHO.
> > 
> > Doh! You're right! It's even there already, right before our eyes:
> > 
> > pointy..clicky..pointy..clicky  (aka: cp gitk git-k)
> > 
> > $ git k
> > 
> > :)
> 
> how about 
> 
>   git tk 
> 
> that's more in line what actually happens. We can ship a gitk.bat
> that runs git-tk.
> 
> BTW, I got one report that gitk doesn't work with the tcl/tk that I
> ship.  Can I have other reports too? ie. 
> 
>   "It doesn't work for me, I use windows 92" 

It worked for me, using Windows XP. (But I don't remember if I had to do 
some adjustments for it, or only for git-gui.)

BTW Almost any operation I run in git-gui fails, because cat is not found.

Ciao,
Dscho
