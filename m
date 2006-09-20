From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git pull for update of netdev fails.
Date: Wed, 20 Sep 2006 10:34:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609201032000.4388@g5.osdl.org>
References: <20060920080308.673a1e93@localhost.localdomain>
 <Pine.LNX.4.64.0609200816400.4388@g5.osdl.org> <20060920155431.GO8259@pasky.or.cz>
 <Pine.LNX.4.64.0609200902190.4388@g5.osdl.org> <20060920165931.GE23260@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>,
	Stephen Hemminger <shemminger@osdl.org>,
	Jeff Garzik <jgarzik@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 19:41:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ63u-0008Mg-MR
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 19:40:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWITRkj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 13:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbWITRkj
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 13:40:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13722 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932138AbWITRki (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Sep 2006 13:40:38 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8KHYYnW025948
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 20 Sep 2006 10:34:35 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8KHYXmv006123;
	Wed, 20 Sep 2006 10:34:34 -0700
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060920165931.GE23260@spearce.org>
X-Spam-Status: No, hits=-0.504 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.150 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27386>



On Wed, 20 Sep 2006, Shawn Pearce wrote:
> 
> Yet people (typically those new to Git) will still pull or merge
> the wrong branch in, work on top of that merge, publish it, others
> will build on that... and wham; that topic branch head which you
> wanted to rebase prior to merging is now wedged 50 commits deep in
> your history.

Yes. It might well be a good idea to mark temporary branches some way on 
the sending side, and have "git pull" honor that marking by default.

The only really good marking we'd have (unless we extended the protocol a 
lot) is name-based, ie we could have a separate directory for "temporary 
branches". 

Of course, nothing will ever really avoid outright mistakes, which is 
probably the bulk of things. I think a lot of those go away when you get 
used to the flow, but especially in the beginning, people _will_ make 
mistakes.

So maybe trying to avoid them too much is just futile.

		Linus
