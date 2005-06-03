From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] git-tar-tree: add a test case (resent)
Date: Thu, 2 Jun 2005 18:34:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506021830340.1876@ppc970.osdl.org>
References: <20050602185046.GA3717@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 03:29:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1De106-00017H-PC
	for gcvg-git@gmane.org; Fri, 03 Jun 2005 03:29:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbVFCBcZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 21:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbVFCBcZ
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 21:32:25 -0400
Received: from fire.osdl.org ([65.172.181.4]:17281 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261473AbVFCBcW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2005 21:32:22 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j531WDjA005693
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 2 Jun 2005 18:32:14 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j531WCuP031136;
	Thu, 2 Jun 2005 18:32:13 -0700
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <20050602185046.GA3717@lsrfire.ath.cx>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 2 Jun 2005, Rene Scharfe wrote:
>
> git-tar-tree: add a simple test case.

I get:

	* FAIL 6: extract tar archive (cd b && tar xf -) <b.tar
	* FAIL 7: validate filenames (cd b/a && find .) | sort >b.lst &&
	* FAIL 8: validate file contents diff -r a b/a
	* FAIL 11: validate filenames with prefix (cd c/prefix/a && find .) | sort >c.lst &&
	* FAIL 12: validate file contents with prefix diff -r a c/prefix/a

Hmm?

		Linus
