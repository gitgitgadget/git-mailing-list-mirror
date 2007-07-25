From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Windows support
Date: Wed, 25 Jul 2007 13:41:59 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0707251332100.29679@iabervon.org>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Dmitry Kakurin <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 19:42:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDks8-0001dg-QR
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 19:42:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756989AbXGYRmB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 13:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759673AbXGYRmB
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 13:42:01 -0400
Received: from iabervon.org ([66.92.72.58]:4569 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756989AbXGYRmA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 13:42:00 -0400
Received: (qmail 5560 invoked by uid 1000); 25 Jul 2007 17:41:59 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Jul 2007 17:41:59 -0000
In-Reply-To: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53703>

On Wed, 25 Jul 2007, Dmitry Kakurin wrote:

> How serious are you guys about Windows support?
> I'm talking fully-functional port, not Cygwin.
> I did a lot of searching for a new SCM to switch to (from Perforce).
> And Git is my #1 choice. I love it's internals design and it's
> expressive power. I've also tested git-p4 and it has worked like a
> charm with my depot (with few tweaks that I may contribute later).
> But I do all my work on Windows so I need Git-For-Windows-Done-Right :-).
> The current mingw port is not there yet.
> 
> Transition to the new SCM must happen now, so basically I have 2 choices:
> 1. Survive for a few months with the current CygWin port of Git
> knowing that Windows support is coming
> 2. Use another SCM (#2 is Mercurial, #3 is Monotone)
> 
> I'd realy love to do #1, but I need to know how long do I have to wait.

If the issue is the shell scripts, replacing those with C code is coming 
along nicely; there's a big section (fetch and everything it uses) which 
is ready to go after 1.5.3 comes out, and I believe a number of the other 
core parts are being taken care of in the same sort of time frame by the 
GSoC people.

I've also been working on reducing the fork/exec usage, if that's the 
issue, but I'm not sure how much of that is left to do or how long it will 
take.

(Personally, I don't touch windows at all, but I have been working on 
fixing things that seem to be problems for porting to windows, which may 
be relevant)

	-Daniel
*This .sig left intentionally blank*
