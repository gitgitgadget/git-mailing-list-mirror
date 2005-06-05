From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] git-daemon server
Date: Sun, 5 Jun 2005 09:17:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506050914030.1876@ppc970.osdl.org>
References: <7vk6l9flzr.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.21.0506050132590.30848-100000@iabervon.org>
 <7vzmu5b8o6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 18:12:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DexjD-0001ve-FD
	for gcvg-git@gmane.org; Sun, 05 Jun 2005 18:11:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbVFEQPW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 12:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261591AbVFEQPW
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 12:15:22 -0400
Received: from fire.osdl.org ([65.172.181.4]:32193 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261592AbVFEQPQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jun 2005 12:15:16 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j55GF9jA001175
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 5 Jun 2005 09:15:09 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j55GF8Ro012630;
	Sun, 5 Jun 2005 09:15:08 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmu5b8o6.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 4 Jun 2005, Junio C Hamano wrote:
> 
> Linus, can your workflow grok things like this, or do you prefer
> patch submission to use traditional diff format without renames?

I haven't made "git-apply" do the final part yet: it doesn't actually 
apply anything. So I'm still using standard patch in my workflow.

But that's largely been because I haven't been hugely motivated to fixing 
it yet. I will now correct that.

Let's see if I can do the last mile now.

		Linus
