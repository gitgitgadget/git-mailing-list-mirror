From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH 0/4] Pulling refs files
Date: Sat, 14 May 2005 00:19:35 +0200
Message-ID: <20050513221935.GC32232@pasky.ji.cz>
References: <Pine.LNX.4.21.0505130245260.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat May 14 00:15:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWiQz-0001oT-IZ
	for gcvg-git@gmane.org; Sat, 14 May 2005 00:15:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262573AbVEMWWW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 May 2005 18:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262593AbVEMWWT
	(ORCPT <rfc822;git-outgoing>); Fri, 13 May 2005 18:22:19 -0400
Received: from w241.dkm.cz ([62.24.88.241]:56968 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262573AbVEMWTh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2005 18:19:37 -0400
Received: (qmail 4981 invoked by uid 2001); 13 May 2005 22:19:35 -0000
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0505130245260.30848-100000@iabervon.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, May 13, 2005 at 08:49:25AM CEST, I got a letter
where Daniel Barkalow <barkalow@iabervon.org> told me that...
> This series makes the following changes:
> 
>  1: Adds support for having the C code know about the general existance of
>     .git/refs, and functions for writing these files.
>  2: Adds support in the generic pull code for fetching refs (and dummy
>     implementations).
>  3: Adds support in the HTTP pull code for fetching refs
>  4: Adds support in the rsh pull code for fetching refs; this requires
>     changes to the protocol. These changes should be sufficient to support
>     any future extension, however.

Hmm, I've honestly expected something different - a generic way to
specify any file in the repository to be pulled along, instead of a
introducing refs awareness at this level of git. What would be the
advantages of that approach against just specifying list of other files
to pull along?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
