From: Petr Baudis <pasky@suse.cz>
Subject: Re: [ANNOUNCE] Cogito-0.16.1
Date: Tue, 13 Dec 2005 17:56:45 +0100
Message-ID: <20051213165645.GC22159@pasky.or.cz>
References: <20051212011210.GC12373@pasky.or.cz> <20051212182636.d3b73900.paul@permanentmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 13 18:00:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmDSN-0003fn-EC
	for gcvg-git@gmane.org; Tue, 13 Dec 2005 17:56:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbVLMQ4t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Dec 2005 11:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964842AbVLMQ4s
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Dec 2005 11:56:48 -0500
Received: from w241.dkm.cz ([62.24.88.241]:60576 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964780AbVLMQ4s (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Dec 2005 11:56:48 -0500
Received: (qmail 9727 invoked by uid 2001); 13 Dec 2005 17:56:45 +0100
To: Paul Dickson <paul@permanentmail.com>
Content-Disposition: inline
In-Reply-To: <20051212182636.d3b73900.paul@permanentmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13579>

Dear diary, on Tue, Dec 13, 2005 at 02:26:36AM CET, I got a letter
where Paul Dickson <paul@permanentmail.com> said that...
> On Mon, 12 Dec 2005 02:12:10 +0100, Petr Baudis wrote:
> 
> >   this is Cogito version 0.16.1, the next stable release of the
> > human-friendly version control UI for the Linus' GIT tool.
> 
> Can the -help argument be supported too?  It's pretty annoying to end up
> typing -help and having that used as a tag or commit.

Both -h and --help is supported. -help should always yield "unknown
argument", but supporting it directly would be inconsistent and might
make the users think that they can actually use that for all the long
arguments.

> Any chance of man files?  I'm more use to type man than cg-help.

You can make the man files by

	make doc

and install them by

	make install-doc


This isn't done by default so that you won't need asciidoc for the
build. This is exactly the same way in GIT.

> How about giving instructions in the edited commit message about how to
> abort the commit.  I've figured out you can just delete all the
> referenced files, but this was just by accident. (0.15.1)  I had my emacs
> segfault and that commit was performed too.

Thanks for the idea:

+[ "$commitalways" ] && echo "CG: Do not save this file and just quit if
	you want to abort the commit." >>$LOGMSG

> Any chance a creating a very simple cg-mv?  Having to switch is a lower
> level (git) to perform this function takes time (verifying the
> functionality).

Yes. That's planned for 0.17, and I have the patch in my queue.

> Is there a cogito equivalent of "git-branch foo"?  It seems cg-branch-add
> does everything but that.

cg-switch, but it's not in 0.16. It's in the 0.17pre git tree and will
be in 0.17.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
