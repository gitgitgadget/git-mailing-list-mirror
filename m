From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Use "-script" postfix for scripts
Date: Sat, 13 Aug 2005 09:35:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508130934000.19049@g5.osdl.org>
References: <Pine.LNX.4.63.0508121526050.25606@wgmdd8.biozentrum.uni-wuerzburg.de>
 <7vwtmrxjbb.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0508121451590.3295@g5.osdl.org>
 <20050812222716.GD22778@mythryan2.michonline.com> <7v64uaqknh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ryan Anderson <ryan@michonline.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 13 18:37:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3yzZ-000141-LM
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 18:36:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbVHMQgE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 12:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbVHMQgE
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 12:36:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42938 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932192AbVHMQgC (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Aug 2005 12:36:02 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7DGZqjA015421
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 13 Aug 2005 09:35:52 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7DGZoM6018691;
	Sat, 13 Aug 2005 09:35:51 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64uaqknh.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.44__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 13 Aug 2005, Junio C Hamano wrote:
> Ryan Anderson <ryan@michonline.com> writes:
> > See, for example, the history on git-rename-script for why this is good.
> 
> Why do you think it is a good example?  What happens when next
> time somebody rewrites it in C?

We'll call the C version "rename.c", and the program gets to be called 
"git-rename", and "git rename" continues to work perfectly fine, so users 
won't be affected in the least.

And "grep ... *.c" and "grep ... *-script" also still work right.

That sounds like a good outcome to me.

		Linus
