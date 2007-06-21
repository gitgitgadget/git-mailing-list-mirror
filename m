From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Finally implement "git log --follow"
Date: Wed, 20 Jun 2007 18:15:11 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706201811440.3593@woody.linux-foundation.org>
References: <alpine.LFD.0.98.0706191358180.3593@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 21 03:15:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1BGf-0008Ql-I7
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 03:15:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753890AbXFUBPW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 21:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753699AbXFUBPW
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 21:15:22 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:56900 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753512AbXFUBPV (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jun 2007 21:15:21 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5L1FH3V011561
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 20 Jun 2007 18:15:18 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5L1FB4t019090;
	Wed, 20 Jun 2007 18:15:11 -0700
In-Reply-To: <alpine.LFD.0.98.0706191358180.3593@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.522 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50580>


Junio, I note that you merged this into 'next', and also:

On Tue, 19 Jun 2007, Linus Torvalds wrote:
>
> [ long and boring explanation ]
> 
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ----

Note the *four* dashes instead of three, so:

> NOTE! For obvious enough reasons, I limited the rename following to just 
> *one* pathname. If somebody wants to extend it to any more, be my guest.
> 
> Also, I really might have some silly bug somewhere.
> 
> "It Works For Me(tm)", and I tested it with both the git archive and the 
> kernel (block/ll_rw_block.c) and it worked beautifully, but I'll also 
> admit that the patch is a bit _too_ clever for my taste normally. The 
> patch actually looks more straightforward than it really is: that "hook 
> directly into diff_tree_sha1()" thing is just too damn clever for words.
> 
> People who want to improve on it should get rid of the memory leak I 
> introduced - I decided to not bother cleaning up the whole rename diff 
> queue, I just reset it. I'm lazy, and I'm a *man*. I do the rough manly 
> stuff, others can clean up after me.
> 
> *Burp*. That hit the spot. *Scratch*

This also hit the git archives. 

My burping and scratching wasn't really *meant* to be part of the official 
record, but hey, there you have it.

No problem, and maybe you noticed and thought it amusing, but in case it 
went unnoticed, you may want to clean that up when/if moving it to 
"master".

Or not. Your choice.

		Linus
