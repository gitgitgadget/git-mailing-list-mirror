From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git on MSys (or how to make it easy for Windows users to compile
 git)
Date: Fri, 3 Aug 2007 14:18:12 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708031411360.14781@racer.site>
References: <Pine.LNX.4.64.0708022206130.14781@racer.site> 
 <460B6BF8541C4D9B916F02A12E0576F5@ntdev.corp.microsoft.com> 
 <46B2D4D9.4020103@trolltech.com> <a1bbc6950708030258h16a6514kf5c637af13874fb7@mail.gmail.com>
 <Pine.LNX.4.64.0708031334530.14781@racer.site> <46B328EA.4030309@trolltech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dmitry Kakurin <dmitry.kakurin@gmail.com>, git@vger.kernel.org
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 15:18:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGx3J-0007zr-Qk
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 15:18:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759761AbXHCNSp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 09:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759042AbXHCNSo
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 09:18:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:36690 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757872AbXHCNSn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 09:18:43 -0400
Received: (qmail invoked by alias); 03 Aug 2007 13:18:41 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp056) with SMTP; 03 Aug 2007 15:18:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19WWoklhK1WzmRiwsxDQEW1LaUbkf0yKNskk1ooCZ
	ilxnGO91cThYq7
X-X-Sender: gene099@racer.site
In-Reply-To: <46B328EA.4030309@trolltech.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54723>

Hi,

On Fri, 3 Aug 2007, Marius Storm-Olsen wrote:

> Johannes Schindelin said the following on 03.08.2007 14:37:
> > On Fri, 3 Aug 2007, Dmitry Kakurin wrote:
> > > The changes that I've made:
> > > * removed .git in /git directory to save space
> > > * installed gdb
> > > * applied my Vista fix
> > > * made self-extracting .rar archive
> > 
> > * replace rxvt by that stupid cmd window
> > Sneaky.
> > Can you defend the choice?
> > FWIW here are my arguments for rxvt:
> > 
> > 	- it behaves the same on all Windows versions
> > 	- it has a scroll back (which you have to activate on cmd first)
> > 	- it is resizable
> > 	- it has sane copy&paste behaviour (which you have to activate on
> > cmd first, and then still have to hit the Return key after 		having
> > selected some text)
> 
> Normally, people would probably like to stay in their current
> environment/window. Let's say you're doing something in a cmd windows, then
> you want to go and compile git. If you run msys.bat, it will kill your current
> window, and show a rxvt window instead. That's kinda not nice really.
> 
> If you enable the QuickEdit in the 'CMD' window, you mark with mouse, the
> right-click to copy, then right-click again to paste. No need to move your
> hand and hit Enter/Return. (Many people don't know about the right-click to
> copy, but it's a much better work-flow)
> 
> You can do all the changes (like changing the scrollback size and edit mode)
> once, then store it, never to change it again.

Thanks for that good point (staying in your window).

Okay, tell you what: I'll let msys.bat start a cmd, and msys-rxvt.bat 
start an rxvt.  Deal?

Ciao,
Dscho
