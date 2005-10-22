From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Handling renames.
Date: Fri, 21 Oct 2005 18:28:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510211826350.10477@g5.osdl.org>
References: <Pine.LNX.4.64.0510211631400.10477@g5.osdl.org>
 <20051022003733.GA8351@pasky.or.cz> <20051022004743.GN30889@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 22 03:30:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ET8C4-0004DK-OG
	for gcvg-git@gmane.org; Sat, 22 Oct 2005 03:29:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965200AbVJVB3F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Oct 2005 21:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965201AbVJVB3F
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Oct 2005 21:29:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53444 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965200AbVJVB3E (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Oct 2005 21:29:04 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9M1SuFC026690
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 21 Oct 2005 18:28:56 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9M1SsbL031109;
	Fri, 21 Oct 2005 18:28:55 -0700
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051022004743.GN30889@pasky.or.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10460>



On Sat, 22 Oct 2005, Petr Baudis wrote:
> 
>   How to track renames? I believe the situation has changed in the last
> half a year.

I disagree.

Every single thing that said that renames were a bad idea to track when 
git started is still equally true.

>   If I convince you that it is worth tracking the renames explicitly,
> "how" is already a minor question.

Never. I'm 100% convinced that tracking renames is WRONG WRONG WRONG.

You can follow renames _afterwards_. 

Git tracks contents. And I think we've proven that figuring out renames 
after-the-fact from those contents is not only doable, but very well 
supported already.

I'm convinced that git handles renames better than any other SCM ever. 
Exactly because we figure it out when it matters.

		Linus
