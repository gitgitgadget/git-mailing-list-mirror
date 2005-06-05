From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH-CAREFUL/RENAME] rename git-rpush and git-rpull to
 git-ssh-push and git-ssh-pull
Date: Sun, 5 Jun 2005 14:31:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506051427280.1876@ppc970.osdl.org>
References: <7vk6l9flzr.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.21.0506050132590.30848-100000@iabervon.org>
 <7vfyvxb89m.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 23:26:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Df2d8-0003oG-AO
	for gcvg-git@gmane.org; Sun, 05 Jun 2005 23:26:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbVFEV3T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 17:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbVFEV3T
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 17:29:19 -0400
Received: from fire.osdl.org ([65.172.181.4]:22666 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261621AbVFEV3P (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jun 2005 17:29:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j55LT4jA022602
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 5 Jun 2005 14:29:05 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j55LT3CC024871;
	Sun, 5 Jun 2005 14:29:03 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfyvxb89m.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 4 Jun 2005, Junio C Hamano wrote:
>
> *** Linus, please be careful with this patch.  This uses
> *** extended git "rename" diff format, and I doubt that
> *** traditional patch -p1 would do the right thing. 

Indeed.

However, I've now made "git-apply" fully functional, and as far as I can 
tell, it would happily eat this patch. However, it so happens that your 
patch conflicts with the other patches sent yesterday, so it won't.

Or maybe I screwed up. I applied your previous four patches with the new 
magic git-apply thing, and it all _seems_ to work fine, but it might make 
sense if you double-checked it, and then we'll try this again and use it 
as the test-case for the new git-apply program.

Btw, while talking about "sensible", I really think somebody should look
my "apply.c" file over. It seems simple enough, and it does seem to work,
but considering that I just totally replaced "patch" in my applicator
script with this new thing, if it gets something wrong...

		Linus
