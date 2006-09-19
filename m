From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Enable the packed refs file format
Date: Tue, 19 Sep 2006 14:09:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609191407340.4388@g5.osdl.org>
References: <Pine.LNX.4.64.0609141005440.4388@g5.osdl.org>
 <20060919205554.GA8259@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 19 23:10:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPmrH-0006x6-HQ
	for gcvg-git@gmane.org; Tue, 19 Sep 2006 23:10:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbWISVKJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 17:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWISVKJ
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 17:10:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18343 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751010AbWISVKH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Sep 2006 17:10:07 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8JL9wnW025228
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 19 Sep 2006 14:09:59 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8JL9uwJ003110;
	Tue, 19 Sep 2006 14:09:57 -0700
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060919205554.GA8259@pasky.or.cz>
X-Spam-Status: No, hits=-0.506 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.148 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27285>



On Tue, 19 Sep 2006, Petr Baudis wrote:

> Dear diary, on Thu, Sep 14, 2006 at 07:14:47PM CEST, I got a letter
> where Linus Torvalds <torvalds@osdl.org> said that...
> > +	ref_file = git_path(ref);
> 
> You slip...
> You fall...
> *BLAMMMM!!!*

Gaah. Yes. I fixed one such mistake already.

Too bad that we can't get gcc to warn on these things. We do mark it as 
"format(printf)", but I don't know of any way to tell gcc that it _has_ to 
have that initial constant string.

		Linus
