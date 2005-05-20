From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: checkout-cache -f: a better way?
Date: Fri, 20 May 2005 16:51:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505201641160.2206@ppc970.osdl.org>
References: <428E5102.60003@pobox.com> <Pine.LNX.4.58.0505201626560.2206@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 21 01:48:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZHDp-0005jX-3Q
	for gcvg-git@gmane.org; Sat, 21 May 2005 01:48:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbVETXtE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 19:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbVETXtE
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 19:49:04 -0400
Received: from fire.osdl.org ([65.172.181.4]:50133 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261607AbVETXs7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2005 19:48:59 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4KNmsjA004475
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 20 May 2005 16:48:55 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4KNmr1x009289;
	Fri, 20 May 2005 16:48:54 -0700
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <Pine.LNX.4.58.0505201626560.2206@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 20 May 2005, Linus Torvalds wrote:
> 
> In other words, those lines in your script should look like this:
> 
> 	git-read-tree -m HEAD && git-checkout-cache -q -f -u -a
> 
> and you'll be a lot happier.

Btw, I do realize that I'm a total wiener, and that my inability to use 
"getopt_long()" is shameful and stupid. 

What can I say? I'm easily confused, and besides, I really seldom program 
in user mode.

So if somebody were to getopt'ify git, _without_ adding crapola like
autoconf (which probably implies that git would just require GNU getopt),
and others agree that it's ok to just say that we expect getopt_long() to
exist, then I'd not have any objections to making the above just be

	git-read-tree -m HEAD | git-checkout-cache -fqua

(to which the beavis-and-butthead in me says "hehhehhehh.. He said fqua.  
Hehhehh. fire fire fire.")

		Linus
