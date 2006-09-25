From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: The GPL: No shelter for the Linux kernel?
Date: Mon, 25 Sep 2006 08:14:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609250807090.3952@g5.osdl.org>
References: <MDEHLPKNGKAHNMBLJOLKIEJNOJAB.davids@webmaster.com>
 <Pine.LNX.4.61.0609231004330.9543@yvahk01.tjqt.qr> <Pine.LNX.4.64.0609231051570.4388@g5.osdl.org>
 <20060923181406.GC11916@pasky.or.cz> <Pine.LNX.4.61.0609240952240.28459@yvahk01.tjqt.qr>
 <Pine.LNX.4.64.0609240923331.4388@g5.osdl.org> <Pine.LNX.4.61.0609250757070.18552@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, David Schwartz <davids@webmaster.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 25 17:17:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRsA6-0004Xs-NF
	for gcvg-git@gmane.org; Mon, 25 Sep 2006 17:14:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbWIYPOW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Sep 2006 11:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbWIYPOW
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Sep 2006 11:14:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35039 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750913AbWIYPOV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Sep 2006 11:14:21 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8PFE6nW026906
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 25 Sep 2006 08:14:07 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8PFE5lb018937;
	Mon, 25 Sep 2006 08:14:05 -0700
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
In-Reply-To: <Pine.LNX.4.61.0609250757070.18552@yvahk01.tjqt.qr>
X-Spam-Status: No, hits=-0.481 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.152 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27738>



On Mon, 25 Sep 2006, Jan Engelhardt wrote:
> 
> Though I strongly agree with you, some GNU folks (such as 
> savannah.nongnu.org) seem to explicitly require it, even for files 
> that do not make up a single program (i.e. like coreutils/ls.c).

Each project obviously has its own rules. The kernel, in many ways, these 
days does something even stronger, in the sense that we now ask not that 
every file be marked, but each and every change be signed-off-on. It's 
more than a copyright issue, of course (it started out motivated by the 
worries of tracking codeflow, but I think one reason it has worked so well 
is that it's become useful for so many other things).

So lots of projects have their specific rules. I don't think the "add 
notice to every file" is wrong per se, I just think it's impractical: not 
only does it get unwieldly with all those messages at the top, usually an 
open source project ends up being a mix of lots of different people that 
own rights in it, and in many ways it's thus better to track at a change 
level rather than a file level if you do tracking.

But exactly because it doesn't have any real legal rules, the rules are 
from other sources, and boil down mainly to just per-project "coding 
style" issues.

		Linus
