From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [Cogito] Various bugs
Date: Tue, 7 Feb 2006 08:56:38 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602070854380.3854@g5.osdl.org>
References: <20060131041318.GC30744@diku.dk> <20060207003643.GJ31278@pasky.or.cz>
 <7vfymw3oym.fsf@assigned-by-dhcp.cox.net> <20060207021006.GM31278@pasky.or.cz>
 <7v8xsn50rf.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0602070751410.3854@g5.osdl.org>
 <20060207164946.GN31278@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 07 17:57:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6W9B-0002ei-M7
	for gcvg-git@gmane.org; Tue, 07 Feb 2006 17:56:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbWBGQ4x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Feb 2006 11:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbWBGQ4x
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Feb 2006 11:56:53 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2976 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932473AbWBGQ4x (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Feb 2006 11:56:53 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k17GudDZ026748
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 7 Feb 2006 08:56:40 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k17GudE2005071;
	Tue, 7 Feb 2006 08:56:39 -0800
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060207164946.GN31278@pasky.or.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15698>



On Tue, 7 Feb 2006, Petr Baudis wrote:
> 
> > Yes. That said, we should probably disallow that in git-commit-tree (and 
> > let the user fix it up some way).
> 
> What way? Sometimes you just receive mails from people who have only
> email addy in the from line, or you can be importing from some other VCS
> where the mapping does not exist and the importers may not deem it
> necessary to have it in GIT. Sure, it may be kernel policy to disallow
> this, but I wouldn't enforce this for all projects in GIT.

Umm. Having an empty name is _wrong_. It makes things like the shortlogs 
break.

Yes, it has happened in the kernel a few times, but those were bugs, and 
I'd have been very happy if git-write-tree had just aborted on me.

If you don't have any better name than the email/user-name, just use that 
(but at least for the kernel, I'd much prefer a round of "google" first to 
see if something better is available). An _empty_ name is never 
acceptable.

		Linus
