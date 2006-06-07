From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH/RFC] "git --less cmd" to page anywhere
Date: Tue, 6 Jun 2006 17:05:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606061703380.5498@g5.osdl.org>
References: <20060604211931.10117.82695.stgit@machine.or.cz>
 <20060604212050.GV10488@pasky.or.cz> <Pine.LNX.4.64.0606041621010.5498@g5.osdl.org>
 <7vodx5n8en.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 07 02:06:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnlYm-00033i-Oo
	for gcvg-git@gmane.org; Wed, 07 Jun 2006 02:06:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbWFGAGF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 20:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWFGAGF
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 20:06:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15807 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751387AbWFGAGE (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jun 2006 20:06:04 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k570602g026592
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 6 Jun 2006 17:06:00 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5705xNb007506;
	Tue, 6 Jun 2006 17:05:59 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vodx5n8en.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21416>



On Tue, 6 Jun 2006, Junio C Hamano wrote:
>
> This allows you to say:
> 
> 	git --less diff v2.6.16-rc5..

I've seriously considered something like that, although you chose a pretty 
strange - and long - flag.

I was thinking something like "git -p log -p" (the first "-p" is for 
"paginate" - think "dir/p" in old DOS times, but we could claim it is for 
"pager" so that people don't laugh at us)

		Linus
