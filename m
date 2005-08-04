From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] (preview) Renaming push.
Date: Wed, 3 Aug 2005 17:13:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508031710310.3258@g5.osdl.org>
References: <Pine.LNX.4.63.0508030109210.21304@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0508030944210.3258@g5.osdl.org>
 <Pine.LNX.4.63.0508031849270.24318@wgmdd8.biozentrum.uni-wuerzburg.de>
 <200508031908.22562.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.58.0508031102590.3258@g5.osdl.org>
 <7vek9a8uy9.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0508031641270.3258@g5.osdl.org>
 <7v3bpq8t2a.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 02:14:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0TMv-0006Jl-JF
	for gcvg-git@gmane.org; Thu, 04 Aug 2005 02:13:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261658AbVHDANX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Aug 2005 20:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbVHDANW
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Aug 2005 20:13:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18824 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261660AbVHDANP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2005 20:13:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j740D6jA002975
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 3 Aug 2005 17:13:06 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j740D5q9018213;
	Wed, 3 Aug 2005 17:13:06 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3bpq8t2a.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 3 Aug 2005, Junio C Hamano wrote:
>
> > 	git-send-pack parent $(git-rev-parse HEAD^):master
> 
> When I do something like your example, I create a temporary
> lightweight tag and push it.  Snapshots in JIT are just a bunch
> of lightweight tags so..

I like the scripting, and combining pipelines of commands kind of thing. 

I agree that you can just make a temporary tag, but it's a bit like in any
scripting stuff - you could use a temp-file, but it's just cleaner if you
can keep temporary values in local variables (or in a local cmd pipeline
like the above).

Whenever you script somethign that creates a new tag or ref, you suddenly 
have cleanup and uniqueness issues etc. 

		Linus
