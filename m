From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git and time
Date: Wed, 27 Sep 2006 14:48:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609271446160.3952@g5.osdl.org>
References: <20060927214417.36420.qmail@web51002.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 27 23:48:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GShGL-0001V4-2K
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 23:48:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030905AbWI0VsO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 17:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030908AbWI0VsO
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 17:48:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51346 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030905AbWI0VsN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Sep 2006 17:48:13 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8RLm4nW029112
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 27 Sep 2006 14:48:05 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8RLm3Je017837;
	Wed, 27 Sep 2006 14:48:03 -0700
To: Matthew L Foster <mfoster167@yahoo.com>
In-Reply-To: <20060927214417.36420.qmail@web51002.mail.yahoo.com>
X-Spam-Status: No, hits=-0.468 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.154 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27937>



On Wed, 27 Sep 2006, Matthew L Foster wrote:
> > When did the merge happen? It happened at 8:30 on my machine, and that's 
> > what is recorded. End of story. No ifs, buts, maybes about it. That's the 
> > only time you can _ever_ see for that merge.
> 
> Ok, so it's more complex because of the workflow issue of delayed/pseudo mirroring/replication
> between private and public repos? This cloning/replication is not done through git?

No, it very much happened with git.

But git will _refuse_ to rewrite history. That means that if a commit says 
it happened at 8:30AM on machine X, git will _not_ rewrite history to say 
that it happened at 9:30AM on machine Y just because that's when it made 
it to that machine.

> Are you saying it's impossible for master.kernel.org's git to track the 
> local time of each commit/merge/replication?

No, I'm saying that that would be _lying_.

The actual action happened at 8:30. And git tracks only truth. It doesn't 
rewrite the truth afterwards.

		Linus
