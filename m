From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [RFC] Embedding asciidoc manpages in the cg scripts
Date: Thu, 12 May 2005 00:48:06 +0200
Message-ID: <20050511224806.GJ22686@pasky.ji.cz>
References: <20050511014445.GA14377@diku.dk> <20050511213217.GG22686@pasky.ji.cz> <4282851A.2010305@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonas Fonseca <fonseca@diku.dk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 00:41:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVzsq-0002Pc-5E
	for gcvg-git@gmane.org; Thu, 12 May 2005 00:40:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbVEKWsV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 18:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbVEKWsV
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 18:48:21 -0400
Received: from w241.dkm.cz ([62.24.88.241]:41155 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261744AbVEKWsI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 May 2005 18:48:08 -0400
Received: (qmail 12423 invoked by uid 2001); 11 May 2005 22:48:07 -0000
To: David Greaves <david@dgreaves.com>
Content-Disposition: inline
In-Reply-To: <4282851A.2010305@dgreaves.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, May 12, 2005 at 12:20:10AM CEST, I got a letter
where David Greaves <david@dgreaves.com> told me that...
> Petr Baudis wrote:
> 
> >> #
> >>+# NAME
> >>+# ----
> >>+# cg-add - add files to a GIT repository
> >>    
> >>
> >
> >Half of this is useless, too.
> >
> >I think you should just keep the first paragraph of the files as it is
> >now. Don't touch it, just parse it.
> >  
> >
> A bit harsh Petr.

Sorry, I didn't mean to sound (too) harsh. ;-)

> Isn't the idea of using an already written tool that you don't _have_ to
> parse it?

No, the idea is to get nice output while keeping the input easily human
readable. I'm only stretching that further, since we know more than
asciidoc itself does about the file. :-)

> Where, consistently, do the cg-files have a 1 line summary.

I can't parse this sentence, I fear. All the cg-files have a 1 line
summary, then one or more copyright lines, then the description 'n
stuff. That's fixed format, much like the git commit format.

> >>+#
> >>+# SYNOPSIS
> >>+# --------
> >>    
> >>
> >No need for this heading either.
> >  
> >
> Actually there is :)
> asciidoc won't produce a manpage without it.

So the script piping this to asciidoc can add this at the proper point.

> >>+USAGE="cg-add FILE..."
> >>+#
> >>+# DESCRIPTION
> >>+# -----------
> >> # Takes a list of file names at the command line, and schedules them
> >> # for addition to the GIT repository at the next commit.
> >>+#
> >>+# The command will fail if one of the given files does not exist.
> >>+#
> >>+# cg-add is part of Cogito, an SCM-like toolkit for managing GIT trees.
> >>    
> >>
> >
> >Useless.
> >  
> >
> Yes - if you happen to have written and breathed the code - not so
> useless if you're a normal user.

Sorry, I've meant only the "cg-add is part of Cogito, an SCM-like
toolkit for managing GIT trees" part is useless.

> It cogito is ever installed as part of a distro (maybe even by default)
> then it would be nice if "man cg-add" actually mentioned it was part of
> cogito and git...

Yes. I'm fine with it being in the manpage. I just don't want it in the
code since again, it is obvious there. And code (be it program code or
documentation code) duplication is wrong, if you have a non-trivial
chunk repeated over and over everywhere, you probably want to move it to
a single place. That'd be the conversion script here.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
