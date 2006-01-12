From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git binary size...
Date: Thu, 12 Jan 2006 10:13:46 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601121013030.3535@g5.osdl.org>
References: <Pine.LNX.4.64.0601111021450.5073@g5.osdl.org>  <43C558FB.3030102@op5.se>
  <Pine.LNX.4.64.0601111134560.5073@g5.osdl.org> <2cd57c900601120215pdb5da27l@mail.gmail.com>
 <43C65E70.7090702@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 12 19:14:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ex6xM-0002by-Dz
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 19:13:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWALSNu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 13:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWALSNu
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 13:13:50 -0500
Received: from smtp.osdl.org ([65.172.181.4]:30923 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750767AbWALSNt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jan 2006 13:13:49 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0CIDlDZ001489
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 12 Jan 2006 10:13:47 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0CIDkko030016;
	Thu, 12 Jan 2006 10:13:46 -0800
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43C65E70.7090702@op5.se>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.64__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14573>



On Thu, 12 Jan 2006, Andreas Ericsson wrote:
> 
> git is already fairly portable without the autoconf hackery. It's easy enough
> to move some of the conditional stuff out of the Makefile without autoconf,
> but it would still require GNU Make, so there's no real point in doing so.

More importantly, autoconf is a worse hack than _any_ of the config hacks 
we do currently.

Repeat after me: "autoconf is crap".

		Linus
