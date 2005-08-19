From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Teach parse_commit_buffer about grafting.
Date: Fri, 19 Aug 2005 10:29:39 +1000
Message-ID: <17157.10227.296309.809074@cargo.ozlabs.ibm.com>
References: <7vslxw4tb1.fsf_-_@assigned-by-dhcp.cox.net>
	<20050818003036.C53FD353BF9@atlas.denx.de>
	<7vd5ocouus.fsf@assigned-by-dhcp.cox.net>
	<17155.64070.264664.926461@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0508172209220.3412@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, Wolfgang Denk <wd@denx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 02:30:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5ulV-0000r2-1L
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 02:29:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932536AbVHSA3m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Aug 2005 20:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932538AbVHSA3m
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Aug 2005 20:29:42 -0400
Received: from ozlabs.org ([203.10.76.45]:16099 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932536AbVHSA3l (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Aug 2005 20:29:41 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 7C8D9680A5; Fri, 19 Aug 2005 10:29:40 +1000 (EST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508172209220.3412@g5.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds writes:

> Paul, I hate to tell you about yet another flag to git-rev-list, but did 
> you realize that in addition to all the other magic flags, there's a flag 
> called "--parents"?

Cool.  I didn't realize that.  The current version uses it now.

> Umm. git-rev-list really does everything. Rule of thumb: if you _ever_
> need to look at any other internal git information, you're probably doing
> something wrong, or you've missed yet another flag ;)

I still look in [gitdir]/refs/tags/* and [gitdir]/refs/heads/*, what
flag have I missed? :)  Junio wants me to look at everything under
[gitdir]/refs, in fact.  Or are the refs not considered internal git
information?

Paul.
