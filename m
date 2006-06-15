From: Phil Richards <news@derived-software.ltd.uk>
Subject: Re: Autoconf/Automake
Date: Thu, 15 Jun 2006 21:10:00 +0100 (BST)
Organization: Derived Software Ltd
Message-ID: <20060615201000.600939E2BC@derisoft.derived-software.demon.co.uk>
References: <1150324030.23268.12.camel@dv> <20060615072450.GF7766@nowhere.earth> <20060615133146.GA5794@steel.home>
X-From: git-owner@vger.kernel.org Thu Jun 15 22:10:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqyAJ-00073q-U2
	for gcvg-git@gmane.org; Thu, 15 Jun 2006 22:10:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031250AbWFOUKE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Jun 2006 16:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031252AbWFOUKE
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jun 2006 16:10:04 -0400
Received: from anchor-post-36.mail.demon.net ([194.217.242.86]:31758 "EHLO
	anchor-post-36.mail.demon.net") by vger.kernel.org with ESMTP
	id S1031250AbWFOUKC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jun 2006 16:10:02 -0400
Received: from derived-software.demon.co.uk ([83.104.60.195] helo=derisoft.derived-software.demon.co.uk)
	by anchor-post-36.mail.demon.net with esmtp (Exim 4.42)
	id 1FqyAD-000Ma5-Jt
	for git@vger.kernel.org; Thu, 15 Jun 2006 20:10:01 +0000
Received: by derisoft.derived-software.demon.co.uk (Postfix, from userid 9)
	id 600939E2BC; Thu, 15 Jun 2006 21:10:00 +0100 (BST)
Received: from 127.0.0.1 by 127.0.0.1 with nntp; 15 Jun 2006 21:10:00 BST
To: git@vger.kernel.org
In-Reply-To: <20060615133146.GA5794@steel.home>
X-Newsreader: slrn/0.9.8.1 (Linux)
NNTP-Posting-Host: 127.0.0.1
NNTP-Posting-Date: Thu, 15 Jun 2006 20:10:00 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21903>

On 2006-06-15, Alex Riesen <fork0@t-online.de> wrote:
>  Yann Dirson, Thu, Jun 15, 2006 09:24:50 +0200:
> > Since there are many people objecting to autotools, what about using
> > Jam instead ?  It has the advantage of being designed to be
> > cross-platform, and should have all the features we would need for *git.
>  Except that it is not readily available everywhere, has unreadable
>  and illogical syntax, and lots of unknown assumptions built in.
>  We are forced to use that thing at work, and it is mostly hated.

FWIW, I like Boost and use it every day.  I hate bjam.

>  Git already has enough external dependencies (crypto, Python, Perl,
>  bash, gmake), why create another one?
> 
>  If we are about to need a configuration system (and I doubt it), may
>  be we should at least select a system small enough to have it always
>  in git repo? (yes, as linux kernel configuration system is)

Well, since Python is already a dependency, why not use a build system
that has Python as its scripting/extension language?  It's also quite
small, and it's called SCons.  I found it rather easy to learn
when I was having a quick look around at alternative build systems.

Just a thought.

phil
-- 
change name before "@" to "phil" for email
