From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] [BUG] Add a test to check git-prune does not throw away
 revs hidden by a graft.
Date: Fri, 19 May 2006 13:45:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605191344200.10823@g5.osdl.org>
References: <20060518213519.14577.67309.stgit@gandelf.nowhere.earth>
 <Pine.LNX.4.64.0605181435230.10823@g5.osdl.org> <7viro3nh07.fsf@assigned-by-dhcp.cox.net>
 <20060518222045.GB6535@nowhere.earth> <20060518225216.GC6535@nowhere.earth>
 <7vsln7lzbj.fsf@assigned-by-dhcp.cox.net> <20060519185558.GE6535@nowhere.earth>
 <Pine.LNX.4.64.0605191159520.10823@g5.osdl.org> <20060519202540.GF6535@nowhere.earth>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 19 22:46:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhBrO-000537-31
	for gcvg-git@gmane.org; Fri, 19 May 2006 22:46:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbWESUqE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 May 2006 16:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964833AbWESUqE
	(ORCPT <rfc822;git-outgoing>); Fri, 19 May 2006 16:46:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49583 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964832AbWESUqD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 May 2006 16:46:03 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4JKjwtH019161
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 19 May 2006 13:45:58 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4JKjvEO004350;
	Fri, 19 May 2006 13:45:57 -0700
To: Yann Dirson <ydirson@altern.org>
In-Reply-To: <20060519202540.GF6535@nowhere.earth>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20355>



On Fri, 19 May 2006, Yann Dirson wrote:
> 
> > We _could_ decide that fsck should just follow the "real parents" and the 
> > grafts _both_. That's the safe thing to do by default. Possibly with a 
> > flag to say "prefer one over the other", or even a "prefer which-ever 
> > exists".
> 
> I'm not sure I see how "prefer which-ever exists" would be useful - do
> you have anything precise in mind ?

It would be a "once you've pruned one or the other, don't complain any 
more about the fact that it doesn't exist" flag.

		Linus
