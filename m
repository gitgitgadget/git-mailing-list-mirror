From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: as promised, docs: git for the confused
Date: Mon, 12 Dec 2005 10:18:37 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512121010550.15597@g5.osdl.org>
References: <20051209215414.14072.qmail@science.horizon.com>
 <7vmzj9zwfu.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0512120827440.15597@g5.osdl.org>
 <20051212195319.11d41269.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: junkio@cox.net, linux@horizon.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 12 19:21:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElsGz-0004nB-1V
	for gcvg-git@gmane.org; Mon, 12 Dec 2005 19:19:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbVLLSTi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Dec 2005 13:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbVLLSTi
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Dec 2005 13:19:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19169 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932109AbVLLSTh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Dec 2005 13:19:37 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jBCIIgDZ024377
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 12 Dec 2005 10:18:43 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jBCIIcMD007917;
	Mon, 12 Dec 2005 10:18:39 -0800
To: Timo Hirvonen <tihirvon@gmail.com>
In-Reply-To: <20051212195319.11d41269.tihirvon@gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.128 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13532>



On Mon, 12 Dec 2005, Timo Hirvonen wrote:
> 
> Me too.  BTW, new users very likely read tutorial.txt first.  But it is
> way too low level (git-cat-file, git-write-tree...).  Maybe those low
> level commands should be described in technical/ instead?  The tutorial
> would be logical place for examples.

I'd almost suggest skipping the technical notes in the current tutorial, 
and just gearing it directly more towards a regular user. 

When I started writing it, I cared more about people understanding how git 
works internally. I think that was useful too, but I suspect that it's 
less useful than just knowing how to use git, and there _are_ enough 
people out there that understand how git works under the hood that it 
probably would be much better to concentrate on getting people _first_ 
used to using git, and then having a separate tutorial for "what goes 
under the hood".

So instead of teaching people about "git-read-tree --reset HEAD" etc that 
you'd never know on your own, just teach about "git reset". And not 
bothering with the "git-write-tree + git-commit-tree + git-update-ref" 
approach, just make people use "git commit" from the very beginning.

Anybody willing to just strip out the raw internals talk?

Then we could add a small section about importing from a tar-file. 

			Linus
