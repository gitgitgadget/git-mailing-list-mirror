From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: deprecating more
Date: Fri, 16 Sep 2005 18:59:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509161856260.26803@g5.osdl.org>
References: <7vd5n8fqso.fsf@assigned-by-dhcp.cox.net> <7vzmqceayd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 17 04:00:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGRzL-00010E-EE
	for gcvg-git@gmane.org; Sat, 17 Sep 2005 03:59:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbVIQB7c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 21:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbVIQB7c
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 21:59:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57274 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750830AbVIQB7b (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Sep 2005 21:59:31 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8H1xQBo001372
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 16 Sep 2005 18:59:26 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8H1xOcr024526;
	Fri, 16 Sep 2005 18:59:25 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmqceayd.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8750>



On Fri, 16 Sep 2005, Junio C Hamano wrote:
> 
> Among them, I could be talked into keeping git-export on the
> condition that we will add a counterpart git-import that can
> read git-export output and recreate an identical repository

I don't think there is any point.

git-export was done as a concept example on how easy it is to export the
git data to something else. It's much less powerful than ny number of
trivial one-liner scripts now, and real exporters would not ever use
git-export.

It's obviously much less powerful than "git-whatchanged", or just about 
any combination of git-rev-list + git-diff-tree.

So drop it.

		Linus
