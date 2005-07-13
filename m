From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: How to get a directory filled with v2.6.11?
Date: Wed, 13 Jul 2005 13:46:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507131342190.17536@g5.osdl.org>
References: <20050712050347.GA10751@buici.com> <Pine.LNX.4.58.0507122116280.17536@g5.osdl.org>
 <7vvf3ewig0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 22:55:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsoFj-0000eN-Ss
	for gcvg-git@gmane.org; Wed, 13 Jul 2005 22:54:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262855AbVGMUsd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jul 2005 16:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262820AbVGMUra
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jul 2005 16:47:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30427 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262783AbVGMUqm (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2005 16:46:42 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6DKkXjA019053
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 13 Jul 2005 13:46:33 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6DKkW22003286;
	Wed, 13 Jul 2005 13:46:32 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvf3ewig0.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 13 Jul 2005, Junio C Hamano wrote:
> 
> I do not think git-cherry would be that useful in this context.
> Nobody upstream is merging things into your development trail,
> started at the private commit you made based on the 2.6.11 tree.

No, the point being that he (or anybody else) could move the commits as
patches, one by one, from his 2.6.11 base to whatever later base that _is_
in the commit history.

It's really the same issue as with cherry-picking: you do commits one at a
time as diffs, see if that diff already exists in the destination stream,
and if not, you try to apply it as a patch and re-commit it with the old
commit message in a new place in history.

			Linus
