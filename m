From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Something wrong with pickaxe?
Date: Wed, 18 Jan 2006 18:59:39 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601181855570.3240@g5.osdl.org>
References: <Pine.LNX.4.63.0601190004130.15298@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0601181541150.3240@g5.osdl.org> <7vwtgxlysf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 19 04:00:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzQ1t-0004b6-MO
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 04:00:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160999AbWASDAB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 22:00:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161181AbWASDAA
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 22:00:00 -0500
Received: from smtp.osdl.org ([65.172.181.4]:26274 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1160999AbWASDAA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jan 2006 22:00:00 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0J2xiDZ018340
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 18 Jan 2006 18:59:44 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0J2xd56015708;
	Wed, 18 Jan 2006 18:59:41 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtgxlysf.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.66__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14879>



On Wed, 18 Jan 2006, Junio C Hamano wrote:
> 
> You are so polite to say "non-intuitive" when you mean
> "useless".

No, no. I could imagine that it's useful, but I end up always instead 
doing "git whatchanged | less" and searching for it. 

So I really mean that the semantics are so non-intuitive that I just can't 
use it, rather than totally useless.

> For example, after I start debugging or code change, if I
> suspect the first "if (!nr_match) return;" is bogus in
> filter_refs() of fetch-pack.c, before declaring that code is
> bogus and start butchering it, I run something like this:
> 
> $ git whatchanged -p -S'static void filter_refs(struct ref **refs, int nr_match, char **match)
> {
> 	struct ref *prev, *current, *next;
> 
> 	if (!nr_match)
> 		return;
> ' master -- fetch-pack.c

See, this is what I mean - it looks useful, but it's just so subtle that I 
don't ever use it.

For example, getting the tabs/spaces right is basically impossible with 
normal cut-and-paste. I assume you do the above inside GNU emacs or some 
similar special-purpose setup, rather than anything generic.

		Linus
