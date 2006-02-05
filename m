From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Add a "git show" command to show a commit
Date: Sun, 5 Feb 2006 14:55:26 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602051451360.3854@g5.osdl.org>
References: <Pine.LNX.4.64.0602012212200.21884@g5.osdl.org>
 <e5bfff550602012325s7d0a799ct5bfabbce2c579449@mail.gmail.com>
 <Pine.LNX.4.64.0602012356131.21884@g5.osdl.org>
 <cc723f590602020007s43f89d10i4529d118ade7c764@mail.gmail.com>
 <Pine.LNX.4.64.0602020027400.21884@g5.osdl.org> <7v7j8erqjr.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0602051141020.3854@g5.osdl.org> <Pine.LNX.4.64.0602051144580.3854@g5.osdl.org>
 <7vd5i1h1bx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 05 23:55:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5snA-0004vQ-HF
	for gcvg-git@gmane.org; Sun, 05 Feb 2006 23:55:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWBEWzc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Feb 2006 17:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbWBEWzc
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Feb 2006 17:55:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20624 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750772AbWBEWzb (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Feb 2006 17:55:31 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k15MtRDZ008908
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 5 Feb 2006 14:55:28 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k15MtQMj017336;
	Sun, 5 Feb 2006 14:55:27 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5i1h1bx.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15641>



On Sun, 5 Feb 2006, Junio C Hamano wrote:
> 
> Isn't this "git whatchanged -n1 --cc --always"?

Getting closer, yes.

Especially these days that you can write "-1" instead of "--max-count=1", 
and if we make "--cc" the default for "git-whatchanged", I guess we could 
just drop this.

> Except that --cc does not make much sense without being -p, so
> the logic to do --name-status and friends are pretty much
> wasted, no?

You're right. The "--cc" should be in the default flags (instead of -p), 
not unconditionally on the command line.

			Linus
