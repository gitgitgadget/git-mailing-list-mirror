From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git on MSys (or how to make it easy for Windows users to compile
 git)
Date: Mon, 6 Aug 2007 15:37:19 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708061535390.14781@racer.site>
References: <Pine.LNX.4.64.0708022206130.14781@racer.site> 
 <46B2D4D9.4020103@trolltech.com>  <a1bbc6950708030258h16a6514kf5c637af13874fb7@mail.gmail.com>
  <Pine.LNX.4.64.0708031334530.14781@racer.site> 
 <E3C81783E0454702B1F38D0B68CE1AC0@ntdev.corp.microsoft.com> 
 <Pine.LNX.4.64.0708032231320.14781@racer.site> 
 <e7bda7770708031716i61f80d89o8970b3236a961613@mail.gmail.com> 
 <Pine.LNX.4.64.0708040123560.14781@racer.site> 
 <e7bda7770708051641h15bd38abo659e74322e6232c0@mail.gmail.com> 
 <Pine.LNX.4.64.0708060054020.14781@racer.site>
 <e7bda7770708060730t7c0713c4m6abe42d929d847b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Marius Storm-Olsen <marius@trolltech.com>, git@vger.kernel.org
To: Torgil Svensson <torgil.svensson@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 06 16:38:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1II3id-0000as-Vx
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 16:38:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbXHFOh7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 10:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbXHFOh7
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 10:37:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:45241 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932280AbXHFOh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 10:37:56 -0400
Received: (qmail invoked by alias); 06 Aug 2007 14:37:55 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp045) with SMTP; 06 Aug 2007 16:37:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18qijYCPuUqOnz2OzrNBDKzSCY9N+lvxqGAAGFtrX
	ewVo5Y/aTWdL7g
X-X-Sender: gene099@racer.site
In-Reply-To: <e7bda7770708060730t7c0713c4m6abe42d929d847b0@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55153>

Hi,

On Mon, 6 Aug 2007, Torgil Svensson wrote:

> On 8/6/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> > > > > 3. "gitk --all" said "Error reading commits: fatal: write 
> > > > > failure on stdout: Invalid argument"
> 
> > I have to wonder how you called it... From msys.bat, cd'ing into a 
> > valid repository, I had no issues whatsoever.
> 
> I called it from rxvt. I tried it now under cmd and it's all good. Did 
> you try rxvt in this case?

I had no issues like that in rxvt.  But "git push" via ssh was a no go.  
even with the "ssh://.." syntax.  Since it works in cmd, I'll stay with 
cmd for now, but I'd like to see a working rxvt.

> I notice that with your net installer (great job btw!), I get the 
> msysgit.git reop under /.git and the mingw.git repo under /git/.git but 
> there is no /git in /.gitignore. Is this overlap intended?  Isn't this a 
> case for submodules?

Exactly.  My bad.  Dmitry pointed out that I should not have done that, 
and I'm in the middle of setting it up as a submodule.

Ciao,
Dscho
