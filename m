From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git on MSys (or how to make it easy for Windows users to compile
 git)
Date: Sat, 4 Aug 2007 01:26:01 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708040123560.14781@racer.site>
References: <Pine.LNX.4.64.0708022206130.14781@racer.site> 
 <460B6BF8541C4D9B916F02A12E0576F5@ntdev.corp.microsoft.com> 
 <46B2D4D9.4020103@trolltech.com>  <a1bbc6950708030258h16a6514kf5c637af13874fb7@mail.gmail.com>
  <Pine.LNX.4.64.0708031334530.14781@racer.site> 
 <E3C81783E0454702B1F38D0B68CE1AC0@ntdev.corp.microsoft.com> 
 <Pine.LNX.4.64.0708032231320.14781@racer.site>
 <e7bda7770708031716i61f80d89o8970b3236a961613@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Marius Storm-Olsen <marius@trolltech.com>, git@vger.kernel.org
To: Torgil Svensson <torgil.svensson@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 02:26:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IH7TX-0004yU-Le
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 02:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763775AbXHDA0d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 20:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763754AbXHDA0d
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 20:26:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:32930 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763744AbXHDA0c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 20:26:32 -0400
Received: (qmail invoked by alias); 04 Aug 2007 00:26:30 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp049) with SMTP; 04 Aug 2007 02:26:30 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+ooptijQOoLtHwTN8dIQrIb+WJIRloY4Ruiof0cL
	10VvSbXurxwdSC
X-X-Sender: gene099@racer.site
In-Reply-To: <e7bda7770708031716i61f80d89o8970b3236a961613@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54777>

Hi,

On Sat, 4 Aug 2007, Torgil Svensson wrote:

> Hi,
> 
> This is great news for win(-stuck)-users. I've tried
> "msysGit-0.2.exe", a few glitches
> 
> 1. Unpacking in a folder that have space in it's path gave various
> errors of this type (here, msysGit is unpacked on the desktop
> C:\Documents and settings\.... ) : make[1]: C:/Documents: Command not
> found

Good point.  Did you fix it?  If so, where is the patch?  Or even better, 
what is your account on repo.or.cz so I can add it, and you can commit 
your fix yourself?

> 2. rxvt-terminal had some freezes (echoed input but programs didn't
> output anything and didn't seem to respond to ctrl-c). Had it once
> during "make" and once during "ls".  I't might be related to me
> resizing the terminal during command execution (=I didn't see it
> otherwise).

I did not experience those.  Could you research further?

> 3. "gitk --all" said "Error reading commits: fatal: write failure on
> stdout: Invalid argument" on start - my other msys installation
> didn't. (I didn't do anything to make git dirty - i'm on master and
> gitk shows no uncommited changes)
> $ git --version
> git version mingw.v1.5.2.4.883.g3822-dirty

I did not even bother testing gitk...  Any idea what is going wrong?

> 4. Mouse-wheel didn't work to scroll views in gitk

Again, no idea why.  Could you please investigate?

> => it works with minor installation effort!  I've done both MSYS and 
> Cygwin installs - I think this will lower the git barrier on Win 
> significantly. Thanks & good work all involved!

Thanks.  Your feedback is much appreciated.

Ciao,
Dscho
