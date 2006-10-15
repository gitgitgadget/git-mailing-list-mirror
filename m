From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Recent and near future backward incompatibilities
Date: Sun, 15 Oct 2006 16:52:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610151650570.3962@g5.osdl.org>
References: <7v4pu62ite.fsf@assigned-by-dhcp.cox.net> <20061015224012.GC5092@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Stephen Hemminger <shemminger@osdl.org>
X-From: git-owner@vger.kernel.org Mon Oct 16 01:52:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZFmk-0003Dx-FX
	for gcvg-git@gmane.org; Mon, 16 Oct 2006 01:52:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422948AbWJOXwr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Oct 2006 19:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422950AbWJOXwr
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Oct 2006 19:52:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9659 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422948AbWJOXwq (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Oct 2006 19:52:46 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9FNq6aX022449
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 15 Oct 2006 16:52:06 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9FNq5iG008902;
	Sun, 15 Oct 2006 16:52:05 -0700
To: Theodore Tso <tytso@mit.edu>
In-Reply-To: <20061015224012.GC5092@thunk.org>
X-Spam-Status: No, hits=-0.473 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28937>



On Sun, 15 Oct 2006, Theodore Tso wrote:
> 
> By the way, note that Ubuntu Dapper (the current stable version of
> Ubuntu) is shipped with git version 1.1.3, and that incompatibility
> extends not to the git repository, but also the Linux-2.6 repostiory
> at
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

That should have been fixed earlier today, since I forced a repack when 
this was discovered.

So if somebody still can't pull it with old git tools, please holler.

That said, Ubuntu should definitely upgrade.

		Linus
