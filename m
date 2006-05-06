From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Unresolved issues #2
Date: Sat, 6 May 2006 08:26:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605060821430.16343@g5.osdl.org>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net> <7v4q065hq0.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0605041627310.6713@iabervon.org> <Pine.LNX.4.64.0605041715500.3611@g5.osdl.org>
 <7vhd43vgnm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 06 17:27:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcOgL-0000iT-7r
	for gcvg-git@gmane.org; Sat, 06 May 2006 17:26:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbWEFP0o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 May 2006 11:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750892AbWEFP0o
	(ORCPT <rfc822;git-outgoing>); Sat, 6 May 2006 11:26:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48803 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750873AbWEFP0n (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 May 2006 11:26:43 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k46FQbtH018691
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 6 May 2006 08:26:37 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k46FQaK0032390;
	Sat, 6 May 2006 08:26:36 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhd43vgnm.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19659>



On Fri, 5 May 2006, Junio C Hamano wrote:
>
> > So I'd argue that (a) yes, we do want to have the "proto porcelain" that 
> > sets remote branch information without the user having to know the magic 
> > "git repo-config" incantation, or know which file in .git/remotes/ to 
> > edit, but that (b) it's even more important to try to decide on what the 
> > remote description format _is_.
> 
> Is it format you care about or the semantics?

I _personally_ care about the semantics, but not very deeply - since I 
tend to actually have just one main branch, and a couple of throw-away 
ones if I ended up working on something.

But I think that for this thing to become useful, we want to care about 
the format - or at least the interface to the different users (with the 
acknowledgement that "users" should often be porcelain above us).

Right now we've basically had people hand-editing the remotes files, and I 
think cogito still uses the older branches format that came from cogito in 
the first place. I think we should just try to decide on a config file 
format, and make it easy for cogito etc to use it.

		Linus
