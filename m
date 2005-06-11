From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [OT] mutually supervised developers
Date: Sat, 11 Jun 2005 16:14:38 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506111612140.2286@ppc970.osdl.org>
References: <7vy89gsiak.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Sun Jun 12 01:08:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DhF5P-0002uD-V7
	for gcvg-git@gmane.org; Sun, 12 Jun 2005 01:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbVFKXMn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Jun 2005 19:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261846AbVFKXMn
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jun 2005 19:12:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15503 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261845AbVFKXMk (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Jun 2005 19:12:40 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5BNCXjA001086
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 11 Jun 2005 16:12:34 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5BNCW0u004310;
	Sat, 11 Jun 2005 16:12:33 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy89gsiak.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 11 Jun 2005, Junio C Hamano wrote:
> 
> I am wondering if the world would be a better place if this
> fictitious project sets up public repositories in the following
> way:
> 
>  (1) each developer's own repository is public;
> 
>  (2) these developers pull from each other "only good stuff",
>      rejecting things he or she feels questionable.  Let's
>      forget that current GIT does not give a direct support for
>      cherrypicking for now.
> 
>  (3) the public canonical repository is updated to contain the
>      intersection (_not_ union) of these developer repositories.
>      Let's also forget that current GIT does not have automated
>      way to do such a thing.

I've thought about it, but one problem ends up being the history.

Even if both developers have the same patches, they may not have gotten 
them in the same order, which means that it's basically impossible to 
retain history when doign an intersection. Unions are different - we can 
just add the new history when we create a union.

> Would people find something like this arrangement workable and
> worthwhile?

If you can explain how it would actually work.. 

		Linus
