From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Wed, 9 May 2007 19:39:01 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705091934440.4062@woody.linux-foundation.org>
References: <vpqwszm9bm9.fsf@bauges.imag.fr>
 <alpine.LFD.0.98.0705060951460.25245@woody.linux-foundation.org>
 <vpqbqgxak1i.fsf@bauges.imag.fr> <46a038f90705072016x17bd60c3ic779459438ffc19@mail.gmail.com>
 <alpine.LFD.0.98.0705072137450.3974@woody.linux-foundation.org>
 <20070509134151.GT4489@pasky.or.cz> <alpine.LFD.0.98.0705090825090.4062@woody.linux-foundation.org>
 <7vzm4dplhu.fsf@assigned-by-dhcp.cox.net> <4642831C.2090401@midwinter.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@suse.cz>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Thu May 10 04:39:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlyZH-0006Pj-Iv
	for gcvg-git@gmane.org; Thu, 10 May 2007 04:39:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743AbXEJCjm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 22:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751793AbXEJCjm
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 22:39:42 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:48056 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751743AbXEJCjl (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 May 2007 22:39:41 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l4A2d4Rv020896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 9 May 2007 19:39:06 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l4A2d1BC010257;
	Wed, 9 May 2007 19:39:02 -0700
In-Reply-To: <4642831C.2090401@midwinter.com>
X-Spam-Status: No, hits=-3.48 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46827>



On Wed, 9 May 2007, Steven Grimm wrote:

> Junio C Hamano wrote:
> > I obviously agree with this.  As I said a few times I regret
> > introducing "add -i" --- it encourages a wrong workflow, in that
> > what you commit in steps never match what you had in the working
> > tree and could have tested until the very end.
> >   
> 
> On the other hand, not all changes require any testing at all. For example, if
> you're using git to manage documentation, it is totally reasonable to commit a
> fix for a simple spelling error in one part of a file while not committing an
> in-progress rewrite of another part.

Yeah, I don't think "git add -i" is a horrible flow - it just shouldn't be 
the only or the primary one (ie apparently it *is* the primary one for 
darcs, and that's a mistake!)

Of course, whether "git add -i" is a nice interface or not, I dunno. 
Personally, if I wanted to do hunk selection, I think I'd stick to 
something graphical where I can just click on the hunks. But that's just 
me.

		Linus
