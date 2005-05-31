From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: I want to release a "git-1.0"
Date: Mon, 30 May 2005 17:58:39 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505301752320.1876@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org>
 <20050530221922.GC21076@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 31 02:55:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dcv1h-0002A0-Hi
	for gcvg-git@gmane.org; Tue, 31 May 2005 02:54:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261635AbVEaA46 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 May 2005 20:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261831AbVEaA46
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 20:56:58 -0400
Received: from fire.osdl.org ([65.172.181.4]:41900 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261635AbVEaA4j (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2005 20:56:39 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4V0uYjA010448
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 30 May 2005 17:56:35 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4V0uXQ8025054;
	Mon, 30 May 2005 17:56:34 -0700
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <20050530221922.GC21076@mythryan2.michonline.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 30 May 2005, Ryan Anderson wrote:
> 
> Umm, why do you maintain two seperate "git" related trees?

Well, my "tools" thing really isn't git proper, and may not make much 
sense in the git distribution.

That said, I'm actually moving things into git as they turn useful. For 
example, I move the "stripspace" program into git (which means it got 
renamed into "git-stripspace", since it ended up being useful for the 
stand-alone git-commit-scripts too. 

But how many non-Linux projects really apply mailboxes of patches? It 
doesn't seem to be very "core".

> Why not merge all of git-tools in, in a tools/ subdirectory?

I'll think about it. It does look like at least about half of the git
tools end up being pretty core.

> I've been meaning to ask the same question about "gitweb" for that
> matter.

Well, there the issue definitely boils down to "different maintainers". I 
don't want to connect things that don't need to be connected. 

> I'd guess part of this is a holdover from the fact that you needed an
> independent tree for BitKeeper, but does it still make sense?

Well, I see the "tools" thing really as my private tools that may or may
not make sense for anybody else. Even the cvs2git thing is just so
_stupid_, since I bet you can do it quite cleanly in perl without having
that strange "convert cvsps output into a shellscript" stage (admittedly,
it was _really_ convenient for debugging to have that separate stage, so
while it looks a bit hacky, it ended up being very powerful).

		Linus
