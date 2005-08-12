From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] fetch-pack: start multi-head pulling.
Date: Fri, 12 Aug 2005 10:12:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508121000320.3295@g5.osdl.org>
References: <7vwtmr4hm5.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0508120858420.3295@g5.osdl.org>
 <Pine.LNX.4.63.0508121818230.26488@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 12 19:13:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3d54-0004FN-Mt
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 19:12:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbVHLRMW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 13:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbVHLRMW
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 13:12:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2016 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750727AbVHLRMV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Aug 2005 13:12:21 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7CHCDjA024785
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 12 Aug 2005 10:12:14 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7CHCCKB030263;
	Fri, 12 Aug 2005 10:12:13 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0508121818230.26488@wgmdd8.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.44__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 12 Aug 2005, Johannes Schindelin wrote:
> 
> I seem to remember Junio does not like bash arrays... 

Well, fair enough, although they aren't really "bash" arrays, they
appeared in other shells before "bash". 

At least ksh and zsh have them, although the zsh implementation seems to
be pretty broken (indices start at 1, and $var acts like $var[*] etc).

Afaik, ksh is actually the origin of the thing.

		Linus
