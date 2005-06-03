From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] git-tar-tree: add a test case (resent)
Date: Fri, 3 Jun 2005 07:51:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506030749170.1876@ppc970.osdl.org>
References: <20050602185046.GA3717@lsrfire.ath.cx>
 <Pine.LNX.4.58.0506021830340.1876@ppc970.osdl.org> <42A03E1E.5060204@lsrfire.ath.cx>
 <Pine.LNX.4.58.0506030737050.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jun 03 16:48:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeDR5-00054c-8G
	for gcvg-git@gmane.org; Fri, 03 Jun 2005 16:46:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbVFCOtS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Jun 2005 10:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbVFCOtS
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jun 2005 10:49:18 -0400
Received: from fire.osdl.org ([65.172.181.4]:16312 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261304AbVFCOtP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2005 10:49:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j53En2jA029866
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 3 Jun 2005 07:49:02 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j53En1ZG026695;
	Fri, 3 Jun 2005 07:49:01 -0700
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <Pine.LNX.4.58.0506030737050.1876@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 3 Jun 2005, Linus Torvalds wrote:
> 
> and you already saw my output from "tar tvf b.tar", so you already know 
> that this is probably due to not understanding extended headers.

My other ppc64 box (running Fedora core 3.92) has no problems, so this is 
apparently something that has been changed between tar 1.13.25 and 1.15.1 
(YDL 4.0 vs Fedora Core tar versions).

		Linus
