From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Thu, 14 May 2009 07:44:34 -0700
Message-ID: <20090514144433.GD30527@spearce.org>
References: <200905122329.15379.jnareb@gmail.com> <20090512233450.GY30527@spearce.org> <d411cc4a0905140655y244f21aem44f1e246dd74d80c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 14 16:44:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4cAr-00014n-Gx
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 16:44:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753565AbZENOod (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 10:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753064AbZENOod
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 10:44:33 -0400
Received: from george.spearce.org ([209.20.77.23]:48082 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752510AbZENOod (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 10:44:33 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2909E381D6; Thu, 14 May 2009 14:44:34 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <d411cc4a0905140655y244f21aem44f1e246dd74d80c@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119196>

Scott Chacon <schacon@gmail.com> wrote:
> On Tue, May 12, 2009 at 4:34 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> >
> > Dulwich - off in its own world and not even trying to match basic
> > protocol rules by just watching what happens when you telnet to a
> > git port. ??No clue how that's going to fair.
> 
> Oddly enough, I'm in Dulwich land too. I've been working on a
> Mercurial plugin that will provide a two way lossless bridge for Hg to
> be able to push and pull to/from a Git server.

How are you going to represent an n-way merge in Git in Hg?

> I've fixed some of the
> issues I've found with the client side work and both pushes and pulls
> will work now. (I did turn off 'thin-pack' capability announcement,
> since you're correct that it simply was not properly implemented).

I'm half interested in Dulwich for "repo"[1] but I need the #@!*
library to be stable and correctly implement Git conventions.  :-)

[1] http://android.git.kernel.org/?p=tools/repo.git;a=summary

> If we're going to round out the list, I've also worked on an
> ActionScript partial implementation, but it never got to the packfile
> level,

ActionScript?  WTF?  As in that thing that embeds in Flash?

> and some of the Erlang guys are interested in writing at least
> a partial Erlang implementation too, which I may get involved in at
> some point.

I heard they moved their official repository to Git.  Their VM as
a network server is just plain awesome.  I half wish I was using
that for the Gerrit backend rather than Apache MINA.  Erlang is
rock-solid and doesn't have major threading bugs in its core.

Oh heck, I just found the documentation for the Erlang sshd.  Nice.
Sadly it lacks public key support it seems, and a solid Git library
with server protocols fully implemented, but, eh, its management
is way better than Java.

> It seems like if anyone would do what you're asking, it's probably me.
> In the next few weeks, I do what I can to fix up the remainder of the
> Dulwich code as part of my hg-git work.  I'm also working with Shawn
> on the Apress book, where I was going to try to document much of this
> information, perhaps I could try writing an RFC as an appendix or
> something - then that will force him to spend time correcting
> everything I got wrong :)

Hah!

Even if you don't write it for the book, I'll certainly try to
give a technical review over the content.  That goes for anyone
who takes the time to write the protocol out, and has a fair clue
as to how it currently works.

-- 
Shawn.
