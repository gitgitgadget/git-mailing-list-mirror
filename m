From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 3/6] git-gnu-progs-Makefile: git Makefile update
Date: Mon, 11 Jul 2005 12:10:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507111206240.17536@g5.osdl.org>
References: <20050711101417.10318.64006.sendpatchset@bryan-larsens-ibook-g4.local>
 <20050711101454.10318.70399.sendpatchset@bryan-larsens-ibook-g4.local>
 <7vk6jxupxs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bryan Larsen <bryanlarsen@yahoo.com>, bryan.larsen@gmail.com,
	pasky@suse.cz, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 11 21:12:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ds3gs-0001fI-TF
	for gcvg-git@gmane.org; Mon, 11 Jul 2005 21:11:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbVGKTL2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 15:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262475AbVGKTLZ
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 15:11:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23174 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262382AbVGKTLS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jul 2005 15:11:18 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6BJAujA012034
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 11 Jul 2005 12:10:56 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6BJAtAl025074;
	Mon, 11 Jul 2005 12:10:55 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6jxupxs.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 11 Jul 2005, Junio C Hamano wrote:
> 
> I am not yet convinced "one variable per GNU program" is the
> right way to do (I do agree it is a problem and I appreciate
> your trying to solving it; an obvious alternative cop-out would
> be to fix this in the user's environment, but there might be a
> saner solution)

Yes. As you say, if we do this (and I think it's so ugly that I'm not
convinced we want to), it should be done in git-sh-setup-script _once_
instead of editing every single script.

Most everything includes git-sh-setup-script anyway by now.

However, what are the features that break the default apple tools anyway? 
Maybe we should avoid using them? OSX clearly comes with "cp" and "xargs" 
regardless, what are the flags that don't work with their cruddy versions?

[ Rant mode on: ..and who the hell is the idiot at Apple who includes the
  old crappy BSD stuff? They already use gcc, so it's totally pointless to
  have a NIH thing, when the GNU utilities are just _better_. Maybe 
  somebody can ask Apple to get with the program and not live in the dark 
  ages any more. ]

			Linus
