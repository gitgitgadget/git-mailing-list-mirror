From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: user manual question
Date: Mon, 29 Dec 2008 14:30:21 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0812291358460.19665@iabervon.org>
References: <gj7mmo$fvk$4@ger.gmane.org> <slrnglf3qh.c7j.sitaramc@sitaramc.homelinux.net> <gj96pl$885$4@ger.gmane.org> <slrnglg90m.olt.sitaramc@sitaramc.homelinux.net> <gjauel$94s$4@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Zorba <cr@altmore.co.uk>
X-From: git-owner@vger.kernel.org Mon Dec 29 20:31:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHNq6-0007Et-0O
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 20:31:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752302AbYL2TaX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 14:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752243AbYL2TaX
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 14:30:23 -0500
Received: from iabervon.org ([66.92.72.58]:57321 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751921AbYL2TaW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 14:30:22 -0500
Received: (qmail 5689 invoked by uid 1000); 29 Dec 2008 19:30:21 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Dec 2008 19:30:21 -0000
In-Reply-To: <gjauel$94s$4@ger.gmane.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104122>

On Mon, 29 Dec 2008, Zorba wrote:

> so a detached HEAD is just a HEAD that is not sitting on a tip ?

If you used CVS (extensively) back in the day, a detached HEAD is like 
what you get if you do something like "cvs checkout -D yesterday" (CVS 
called it "sticky tags"); you have a working directory that contains some 
revision that isn't your latest revision. If you make changes, they can't 
go into the history in the normal fashion, but you can build the project 
and figure out how it worked back then.

With git, of course, you can do things you couldn't do from that state 
with CVS. Because git supports forking history, you can make commits and 
create a new branch to be on. Because git can handle having visibility 
into other people's branches, you can get a detached HEAD by checking out 
somebody else's branch (something like origin/next, for example).

The normal "attached HEAD" state is that there's some branch that you 
update when you make a commit; the "detached HEAD" state means that, when 
you make a commit, no branch is affected.

> i.e. if I do $ git reset --hard HEAD^
> 
> ...pointing HEAD to the previous committ
> 
> this is a detached HEAD

Nope, it's "git checkout (something that isn't one of your branches)", 
just like CVS.

Git is like knitting. Commits are loops of yarn that hold other loops 
(their parents) in place; branches are knitting needles that keep new 
loops from falling out before other loops are holding them, and which hold 
different loops at different times as you work; HEAD is the tip of a 
needle that you use to make new loops. You usually use the tip of one of 
your regular needles to make new loops, and then the body of the needle 
holds the loop, but you could also use your fingers or something that will 
just make the loop temporarily; that's a detached HEAD, because it doesn't 
have the body of a needle behind it to hold loops when you use it for 
something else.

	-Daniel
*This .sig left intentionally blank*
