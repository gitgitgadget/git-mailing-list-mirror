From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: More merge questions (why doesn't this work?)
Date: Fri, 2 Dec 2005 14:12:57 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512021409320.3099@g5.osdl.org>
References: <20051202213214.27282.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 02 23:15:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EiJ9f-0006nf-0W
	for gcvg-git@gmane.org; Fri, 02 Dec 2005 23:13:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbVLBWNT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Dec 2005 17:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbVLBWNT
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Dec 2005 17:13:19 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48018 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750834AbVLBWNT (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Dec 2005 17:13:19 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jB2MD1e0007181
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 2 Dec 2005 14:13:02 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jB2MCwIl003732;
	Fri, 2 Dec 2005 14:12:59 -0800
To: linux@horizon.com
In-Reply-To: <20051202213214.27282.qmail@science.horizon.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.128 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13132>



On Fri, 2 Dec 2005, linux@horizon.com wrote:
>
> produces...
> 
> + git merge 'Merge a, b, c' master a b c
> Trying simple merge with a
> Trying simple merge with b
> Trying simple merge with c
> Simple merge did not work, trying automatic merge.
> Removing c
> fatal: merge program failed
> No merge strategy handled the merge.

I'm getting

	...
	+ git merge 'Merge a, b, c' master a b c
	Trying simple merge with a
	Trying simple merge with b
	Trying simple merge with c
	Simple merge did not work, trying automatic merge.
	Removing c
	Merge 9ca217790c7e6581fe0b8b3b4baf026d03584c66, made by octopus.
	 a |    1 +
	 b |    1 +
	 c |    1 -
	 3 files changed, 2 insertions(+), 1 deletions(-)
	 delete mode 100644 c

and I don't see why you wouldn't get that too.

Do you have that broken version of git that had problems with "rmdir" and 
thought the unlink failed? 

		Linus
