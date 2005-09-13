From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Improve "git grep" flags handling
Date: Tue, 13 Sep 2005 10:51:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509131044340.3351@g5.osdl.org>
References: <200509131739.j8DHdQL1010615@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 13 19:54:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFEwY-0001JS-1O
	for gcvg-git@gmane.org; Tue, 13 Sep 2005 19:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964939AbVIMRvj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Sep 2005 13:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964941AbVIMRvj
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Sep 2005 13:51:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25534 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964939AbVIMRvi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Sep 2005 13:51:38 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8DHpOBo004983
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 13 Sep 2005 10:51:25 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8DHpNrP014153;
	Tue, 13 Sep 2005 10:51:23 -0700
To: Horst von Brand <vonbrand@inf.utfsm.cl>
In-Reply-To: <200509131739.j8DHdQL1010615@laptop11.inf.utfsm.cl>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8476>



On Tue, 13 Sep 2005, Horst von Brand wrote:
> 
> Shouldn't shebang go /bin/bash, as the script uses bash-isms now?
> (For portability to non-enlightened systems the installation would have to
> locate bash too... and/or mention this in the INSTALL file)

Some bash installs only install in /bin/sh, so..

> Or perhaps redo the mess in Perl or some such?

Hey, the code isn't a mess. The fact that there are tons of different 
shells and they don't support it is the mess.

So we should strive for bash syntax to be so common that other shells 
follow suit ;)

I personally find perl to be a really bad language. It has more of a 
unified base (different versions, but at least not totally different and 
unrelated implementations), and it's clearly more powerful, but as a 
_language_ I don't understand how anybody can accept that crap.

The "there's more than one way to do something" slogan may be cute and
sound good to people who are drawn to that thing, but it's actually bad.  
The language is designed to be write-only, and the "you can do it fifty
different ways" is part of it (and line noise characters is another part
of it).

So sh is actually often a much better language. Too bad some of the 
features end up being outside the standard language.

I know, I know, people will consider me crazy for saying that. 

Oh, well. As long as all the _important_ stuff is in C, we're ok.

			Linus
