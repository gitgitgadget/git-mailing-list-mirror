From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Alternate object pool mechanism updates.
Date: Tue, 16 Aug 2005 14:52:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508161451510.3553@g5.osdl.org>
References: <7vmznmp5ja.fsf@assigned-by-dhcp.cox.net> <20050813120815.GC5608@pasky.ji.cz>
 <7v1x4wcca0.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0508141726390.3553@g5.osdl.org>
 <7vek8t8sgi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 23:53:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E59Md-0002tU-3a
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 23:52:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbVHPVww (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 17:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbVHPVww
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 17:52:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44767 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750904AbVHPVwv (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Aug 2005 17:52:51 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7GLqljA000301
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 16 Aug 2005 14:52:47 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7GLqk5E015336;
	Tue, 16 Aug 2005 14:52:46 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vek8t8sgi.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 16 Aug 2005, Junio C Hamano wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > We've got a "git prune-packed", it would be good to have a "git
> > prune-alternate" or something equivalent.
> 
> If you have GIT_ALTERNATE_DIRECTORIES environment variable, git
> prune-packed will remove objects from your repository if it is
> found in somebody else's pack.  I am not sure if this is the
> behaviour we would want.

Well, it may be good enough if the "master" repository is regularly 
packed..

		Linus
