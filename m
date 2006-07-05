From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-fetch per-repository speed issues
Date: Wed, 5 Jul 2006 09:40:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607050940210.12404@g5.osdl.org>
References: <1151949764.4723.51.camel@neko.keithp.com>
 <Pine.LNX.4.64.0607031603290.12404@g5.osdl.org> <20060704002138.GB5716@coredump.intra.peff.net>
 <Pine.LNX.4.64.0607032007290.12404@g5.osdl.org> <20060705064749.GA3617@segfault.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 05 18:41:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyAR6-0001JF-H3
	for gcvg-git@gmane.org; Wed, 05 Jul 2006 18:41:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbWGEQlI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Jul 2006 12:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbWGEQlI
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Jul 2006 12:41:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26040 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964848AbWGEQlH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Jul 2006 12:41:07 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k65Gf3nW031341
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 5 Jul 2006 09:41:04 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k65Gf06E019228;
	Wed, 5 Jul 2006 09:41:02 -0700
To: Jeff King <peff@peff.net>
In-Reply-To: <20060705064749.GA3617@segfault.peff.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23353>



On Wed, 5 Jul 2006, Jeff King wrote:
> 
> Either you're wrong or there's a bug in git-fetch. 

I was wrong - I forgot the git-ls-remote (which really should be 
unnecessary, but the way the git-fetch-pack works, we end up 
re-connecting).

		Linus
