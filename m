From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] git-daemon server
Date: Fri, 3 Jun 2005 09:02:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506030856490.1876@ppc970.osdl.org>
References: <20050603152212.GA4598@jmcmullan.timesys>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 03 17:58:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeEXm-0001qa-Tt
	for gcvg-git@gmane.org; Fri, 03 Jun 2005 17:57:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbVFCQAR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Jun 2005 12:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbVFCQAR
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jun 2005 12:00:17 -0400
Received: from fire.osdl.org ([65.172.181.4]:26316 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261343AbVFCQAM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2005 12:00:12 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j53G06jA003211
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 3 Jun 2005 09:00:07 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j53G05jG030186;
	Fri, 3 Jun 2005 09:00:06 -0700
To: Jason McMullan <jason.mcmullan@timesys.com>
In-Reply-To: <20050603152212.GA4598@jmcmullan.timesys>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 3 Jun 2005, Jason McMullan wrote:
>
> git-daemon - Client/server for exchanging GIT objects

Hmm.. I'd prefer not calling it a deamon, since if I understand correctly,
the _normal_ usage would likely be to use it as

	.. | ssh .... -e git-deamon

ie it wouldn't be a deamon at all, it would be a foreground server. So I'd 
call it just "git-server" or something.

Anyway, technically this looks ok, but I'd hate to apply it until there is 
something that actually uses it and an example of that usage.

		Linus
