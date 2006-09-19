From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Subversion-style incrementing revision numbers
Date: Tue, 19 Sep 2006 15:20:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609191519090.4388@g5.osdl.org>
References: <Pine.LNX.4.62.0609191309140.9752@joeldicepc.ecovate.com>
 <Pine.LNX.4.64.0609191416500.4388@g5.osdl.org> <20060919220604.GE8259@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Joel Dice <dicej@mailsnare.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 00:20:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPnx9-00055V-Cj
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 00:20:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbWISWU2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 18:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbWISWU2
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 18:20:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43459 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751233AbWISWU1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Sep 2006 18:20:27 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8JMKKnW029203
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 19 Sep 2006 15:20:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8JMKJCj005910;
	Tue, 19 Sep 2006 15:20:19 -0700
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060919220604.GE8259@pasky.or.cz>
X-Spam-Status: No, hits=-0.512 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.148 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27301>



On Wed, 20 Sep 2006, Petr Baudis wrote:
>
> > It might be that "r1.56" was done on another branch, and is totally 
> > unrelated to "r1.57" (other than they sharing some common ancestor far 
> > back).
> 
> This is actually exactly how SVN revision numbering works. There's just
> a single number (no '1.') and it indeed jumps randomly if you have
> several concurrent branches in your (ok, Linus does not have any, just
> someone's) repository.

Oh, ok, if it's just a single numbering, then that's easy to do. It won't 
_mean_ anything, and you're seriously screwed if you ever merge anything 
else (or use a git that doesn't update the refcache or whatever), but it 
is simple and stable within a single repo.

		Linus
