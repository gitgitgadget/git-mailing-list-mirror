From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Licensing and the library version of git
Date: Thu, 27 Jul 2006 14:15:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607271402230.4168@g5.osdl.org>
References: <20060727195614.7EDAE353B04@atlas.denx.de>
 <Pine.LNX.4.63.0607272239050.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Wolfgang Denk <wd@denx.de>, Jon Smirl <jonsmirl@gmail.com>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 27 23:15:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6DCm-0003kY-Nx
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 23:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbWG0VPh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 17:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbWG0VPh
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 17:15:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47573 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751286AbWG0VPg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 17:15:36 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6RLFMnW024883
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 27 Jul 2006 14:15:22 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6RLFInT016877;
	Thu, 27 Jul 2006 14:15:20 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607272239050.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-0.551 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.141 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24345>



On Thu, 27 Jul 2006, Johannes Schindelin wrote:
> 
> From a standpoint of copyright (which the GPL relies on), this is not 
> possible: you cannot include C code into Java. And if it is _translated_ 
> from C into Java, it is not copyrighted any more.

That is definitely not true. Translation does not take away anything from 
the copyright. If I write a book in English, and you translate it to 
German, _I_ remain the copyright holder, and you need my permission to 
distribute the result. The fact that you translated it means nothing, and 
you don't own it as a result.

Similarly, the fact that I and others hold the copyright on the source 
code very much means that we also hold the copyright on any binaries you 
"translate" that source code into, and the only thing that gives you a 
right to distribute those binaries is not the translation phase, but the 
fact that the GPLv2 allows you to distribute binaries (with certain 
requirements, of course).

Now, on the other hand it's certainly true that certain elements are 
potentially uncopyrightable. If there is effectively only one sane or 
common way to actually write a git object to disk, the fact that your code 
ends up looking very similar in Java to the way it is done in the original 
C does not imply any copyright problems at all.

But that doesn't mean that you can take the C code and just rewrite it as 
Java - it was still copyright protected. It just means that if your Java 
code ends up looking like the C code, you can explain why it happened.

Now, some things have _no_ copyright protection at all, at least in 
certain areas. Facts and things that did not involve any artistic 
expression at all are simply not copyrightable. So if you list the first 
million digits of PI, you can't complain if somebody copies them, for 
example.

(But in some places, you can apparently claim that you "spent effort" on 
gathering those digits of PI, and that others would have to spend that 
same effort rather than copy your end result. I suspect that's a very weak 
argument, but I suspect that there have been worse arguments made in front 
of a judge in, say, places like Utah, to pick a random one).

And as usual, tech people talking legal issues is not very sane. So talk 
to a lawyer if you really care.

			Linus
