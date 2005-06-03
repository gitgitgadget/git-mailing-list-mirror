From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] git-daemon server
Date: Fri, 3 Jun 2005 13:25:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506031320190.1876@ppc970.osdl.org>
References: <20050603152212.GA4598@jmcmullan.timesys>
 <Pine.LNX.4.58.0506030856490.1876@ppc970.osdl.org> <1117814982.32257.64.camel@jmcmullan.timesys>
 <Pine.LNX.4.58.0506030929150.1876@ppc970.osdl.org> <1117819137.32257.75.camel@jmcmullan.timesys>
 <Pine.LNX.4.58.0506031035470.1876@ppc970.osdl.org> <1117827011.8970.2.camel@jmcmullan.timesys>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 03 22:21:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeIeL-0002Cm-HQ
	for gcvg-git@gmane.org; Fri, 03 Jun 2005 22:20:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbVFCUXX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Jun 2005 16:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbVFCUXX
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jun 2005 16:23:23 -0400
Received: from fire.osdl.org ([65.172.181.4]:7853 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261352AbVFCUXT (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2005 16:23:19 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j53KNGjA024927
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 3 Jun 2005 13:23:17 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j53KNFGq011472;
	Fri, 3 Jun 2005 13:23:15 -0700
To: "McMullan, Jason" <jason.mcmullan@timesys.com>
In-Reply-To: <1117827011.8970.2.camel@jmcmullan.timesys>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 3 Jun 2005, McMullan, Jason wrote:
> 
> No, but you could do:

That doth suck. Is there any reason for not allowing stdin/stdout as the
transfer protocol?

Making games like having ssh pipe things through is what I already have to 
do with mail, and it's ok for long-running servers, but I really think of 
a "git pull" as an _event_.

So why doesn't stdin/stdout work with ssh, even though the docs say that
it's even the default?

		Linus
