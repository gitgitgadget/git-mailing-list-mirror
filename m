From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git "tag" objects implemented - and a re-done commit
Date: Mon, 25 Apr 2005 15:07:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504251505260.18901@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504251213530.18901@ppc970.osdl.org>
 <Pine.LNX.4.58.0504251318290.11481@sam.ics.uci.edu>
 <Pine.LNX.4.58.0504251339020.18901@ppc970.osdl.org>
 <Pine.LNX.4.58.0504251442480.12019@sam.ics.uci.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 26 00:02:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQBeM-0006iZ-M8
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 00:01:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbVDYWG1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 18:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbVDYWGR
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 18:06:17 -0400
Received: from fire.osdl.org ([65.172.181.4]:51132 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261255AbVDYWFq (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2005 18:05:46 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3PM5Rs4004757
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 25 Apr 2005 15:05:27 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3PM5Ihg009572;
	Mon, 25 Apr 2005 15:05:23 -0700
To: Andreas Gal <gal@uci.edu>
In-Reply-To: <Pine.LNX.4.58.0504251442480.12019@sam.ics.uci.edu>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 25 Apr 2005, Andreas Gal wrote:
> 
> Ok, if tags are standalone objects then I don't see how they get 
> propagated.

You propagate them "by hand" (which eventually obviously means "with tools
to do so").

The thing is, you _shouldn't_ be interested in my tags unless I -tell- you 
to be interested in them. 

So I'll probably just push out my tags with my archives, and then people
can verify them if they want to.

		Linus
