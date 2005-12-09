From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: as promised, docs: git for the confused
Date: Fri, 9 Dec 2005 08:49:39 -0800 (PST)
Message-ID: <Pine.LNX.4.58.0512090846480.23358@shark.he.net>
References: <20051209140123.3234.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: pasky@suse.cz, alan@chandlerfamily.org.uk, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 09 17:52:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EklRJ-0007Id-9x
	for gcvg-git@gmane.org; Fri, 09 Dec 2005 17:49:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbVLIQtm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Dec 2005 11:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbVLIQtm
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Dec 2005 11:49:42 -0500
Received: from xenotime.net ([66.160.160.81]:44674 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932283AbVLIQtm (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Dec 2005 11:49:42 -0500
Received: from shark.he.net ([66.160.160.2]) by xenotime.net for <git@vger.kernel.org>; Fri, 9 Dec 2005 08:49:39 -0800
X-X-Sender: rddunlap@shark.he.net
To: linux@horizon.com
In-Reply-To: <20051209140123.3234.qmail@science.horizon.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13429>

On Fri, 9 Dec 2005 linux@horizon.com wrote:

> >> Unfortunately, given the number of commands, you can't just document
> >> them well individually.  Some overview of how they fit together into
> >> a system is required.
>
> > Hmm. Well, actually... what's the point? If I want to get a really quick
> > overview, I do
> >
> >	whatis git
> >
> > and it will DTRT. But when do I need something more detailed but not yet
> > the manual page of the given command?
>
> "I want to do X and Y but not Z.  What commands are worth knowing?"

I agree big time.  Even for quilt (about 30 commands),
I wrote a summary (cheat sheet) of usage models:

a.  making a new patch:  use this series of commands
b.  importing patches:  use this other series of commands
c.  other patch management commands


> I have 106 git-* commands available to me (my document covers 105;
> I'll have to find the extra), and the biggest question I have is
> "how many of those man pages can I get away with NOT reading?"
>
> Heck, that categorized list is what I started out writing, and I happen
> to think it's the most important part of the whole document.
>
> The man page tells me HOW to execute a command.  But before I'm ready for
> that level of detail, I need to figure out WHICH command to execute.
> To be specific, I need to know the terrain just well enough so I can
> plan a route from where I am to where I want to be.  Then I can look
> into the details of each step.
>
> But without that overview, my trip is going to take me into a lot of dead
> ends, because I'm executing commands that I think are getting me closer,
> but I have the wrong mental model of what "close" is.

-- 
~Randy
