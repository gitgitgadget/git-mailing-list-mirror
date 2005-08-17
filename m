From: Wolfgang Denk <wd@denx.de>
Subject: Re: sending changesets from the middle of a git tree
Date: Wed, 17 Aug 2005 02:13:08 +0200
Message-ID: <20050817001308.ED487353CFD@atlas.denx.de>
References: <7vfytc9dzw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Aug 17 02:14:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5BZ0-0005th-7f
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 02:13:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbVHQANr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 20:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbVHQANr
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 20:13:47 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:53446 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1750764AbVHQANq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2005 20:13:46 -0400
Received: from fwd18.aul.t-online.de 
	by mailout06.sul.t-online.com with smtp 
	id 1E5BYZ-0001vH-00; Wed, 17 Aug 2005 02:13:23 +0200
Received: from denx.de (b7DiPsZQ8exTPHmZkoIQ6PsxBCQjwLOAFz4GV-zqSlsLlsQ0xN4Zch@[84.150.109.207]) by fwd18.sul.t-online.de
	with esmtp id 1E5BYM-0zpnrk0; Wed, 17 Aug 2005 02:13:10 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id 4F6FE42A89; Wed, 17 Aug 2005 02:13:09 +0200 (MEST)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id ED487353CFD;
	Wed, 17 Aug 2005 02:13:08 +0200 (MEST)
To: Junio C Hamano <junkio@cox.net>
In-reply-to: Your message of "Sun, 14 Aug 2005 18:37:39 PDT."
             <7vfytc9dzw.fsf@assigned-by-dhcp.cox.net> 
X-ID: b7DiPsZQ8exTPHmZkoIQ6PsxBCQjwLOAFz4GV-zqSlsLlsQ0xN4Zch@t-dialin.net
X-TOI-MSGID: dc3f446f-acd6-400d-b1e9-ba19522fff22
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

in message <7vfytc9dzw.fsf@assigned-by-dhcp.cox.net> you wrote:
> 
> This is the kind of situation I used to have all the time when
> Linus was the maintainer and I was a contributor, when you look
> at "master" branch being the "maintainer" branch, and "pu"
> branch being the "contributor" branch.  Your work started at the
...
> your changes) "pu" rather than merge.  So I ran "git rebase":
> 
>     $ git checkout pu
>     $ git rebase master pu

How do you handle conflicts in such a situation?

For example, I get:

	-> git rebase master testing-NAND
	67a002cbe2b2850d76d797e679bc290a76666df6
	patching file common/cmd_nand.c
	Hunk #2 FAILED at 18.
	Hunk #3 succeeded at 335 (offset 1 line).
	1 out of 4 hunks FAILED -- saving rejects to file common/cmd_nand.c.rej
	external diff died, stopping at common/cmd_nand.c.
	Some commits could not be rebased, check by hand:
	67a002cbe2b2850d76d797e679bc290a76666df6

OK, I can edit the file to resolve the conflicts. But what  do  I  do
then to continue?

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
...when fits of creativity run strong, more than  one  programmer  or
writer  has  been  known to abandon the desktop for the more spacious
floor.                                             - Fred Brooks, Jr.
