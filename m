From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: as promised, docs: git for the confused
Date: Mon, 12 Dec 2005 08:34:12 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512120827440.15597@g5.osdl.org>
References: <20051209215414.14072.qmail@science.horizon.com>
 <7vmzj9zwfu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux@horizon.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 12 17:36:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElqeT-0003Ek-7f
	for gcvg-git@gmane.org; Mon, 12 Dec 2005 17:35:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbVLLQfW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Dec 2005 11:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbVLLQfW
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Dec 2005 11:35:22 -0500
Received: from smtp.osdl.org ([65.172.181.4]:5305 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751255AbVLLQfV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Dec 2005 11:35:21 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jBCGYGDZ018888
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 12 Dec 2005 08:34:16 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jBCGYCKZ003067;
	Mon, 12 Dec 2005 08:34:13 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzj9zwfu.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.128 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13523>



On Fri, 9 Dec 2005, Junio C Hamano wrote:
>
> Exactly.  That's why task oriented list would be most useful.
> Here is a starter.
> 
> 
> Everyday GIT Cheat Sheet Or Git With 20 Commands
> ================================================

Would this file perhaps also have examples?

I really think a lot of people learn better from examples than from having 
pointers to git programs that can be useful.

For example, earlier today I got the bash tar-ball because I had forgotten 
what the magic config option was to make bash do the right thing wrt pipe 
write errors. And because I'm totally dependent on "git grep" these days, 
I turned that tar-ball into a git archive. It's really a sinfully simple 
thing to do, but I don't think we mention that anywhere in the docs.

Here's what I did:

	# Extract the thing as normal
	zcat < bash-3.0.tar.gz | tar xvf -
	cd bash-3.0/

	# make a git archive out of it
	git init-db
	git add .
	git commit

and that's it. That creates a git archive from a tar-ball. Very simple, 
and short sequences like these would make tons of sense for a "cheat 
sheet" like yours, and I really think most people can look at those three 
git commands and suddenly they understand what they do a lot better than 
by reading the man-pages.

Or maybe it's just me. But I know _I_ understand things better by seeing 
the "context" that they are used in. Then I go to man-pages later on, if I 
want to know the details.

No?

		Linus
