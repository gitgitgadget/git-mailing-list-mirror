From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: on when to checksum
Date: Mon, 2 May 2005 12:57:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505021250450.3594@ppc970.osdl.org>
References: <200505021921.MAA26977@emf.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 02 21:50:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSgvF-0005zx-Gn
	for gcvg-git@gmane.org; Mon, 02 May 2005 21:49:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbVEBTzq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 15:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbVEBTzq
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 15:55:46 -0400
Received: from fire.osdl.org ([65.172.181.4]:63929 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261735AbVEBTzf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2005 15:55:35 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j42JtXs4000515
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 2 May 2005 12:55:33 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j42JtWZ3015909;
	Mon, 2 May 2005 12:55:33 -0700
To: Tom Lord <lord@emf.net>
In-Reply-To: <200505021921.MAA26977@emf.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 2 May 2005, Tom Lord wrote:
> 
> I'm curious about what is the value of the "batch" nature of that
> proces?

My time.

I don't know about other people, but I don't multitask. I do one thing, 
and that's it. I don't move my mouse around. I sit in my mail reader, and 
I read email. I don't read one email, switch to another window, apply it, 
swithc back, read the next email etc etc.

In fact, I claim that anybody who works that way is going to have an IQ of 
about 15 points lower than somebody who batches things up. Just because 
you end up losing your context, and that effectively makes you stupid. 

Concentration is a wonderful thing, but it _requires_ that you do things 
in a concentrated manner.

> So, if I understand, you review each change before stuffing it in a
> mailbox, then you apply all the patches in that mailbox in batch.
> In the majority of cases, the buffering of changes in the mailbox
> adds nothing.

I read email, and while reading email I save the interesting ones off to
another mbox (I call mine "doit"). They get saved off for "later perusal".

I do a first-order review at that stage, and in fact, 95% of the time, 
what goes into the "doit" folder _will_ get applied. Not 100%, though, 
exactly because at this stage I just read email and work in a mail-reader: 
I don't usually even look at the actual kernel sources that a patch 
involves. In particular, sometimes it turns out that the patch wasn't 
against my version at all, but against a -mm tree, and I just don't even 
worry about technical details at that stage.

Stage #2 is going through the "doit" folder at some later date (maybe a 
couple of times a day), and going through it one more time. Maybe not that 
much more "carefully", but with a different intent - now I actually check 
sign-offs, add my own, and check out the actual problems in the source 
tree if needed.

Stage #3 is actually applying it.

_Each_ stage culls out bad things.

And I _really_ don't bounce between stages.

> In other words, a more asynchronous process might save you time *and*
> pay off by reserving more of your attention for areas where it's 
> really needed.

It's not asynchronous. It's batched in different stages so that I can 
work better. And latency matters.

		Linus
