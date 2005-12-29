From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Cogito: cg-push doesn't push tags?
Date: Thu, 29 Dec 2005 14:10:13 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512291409140.3298@g5.osdl.org>
References: <43B45C39.8040501@zytor.com> <Pine.LNX.4.64.0512291404240.3298@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 29 23:10:28 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Es5yW-0007Zg-EW
	for gcvg-git@gmane.org; Thu, 29 Dec 2005 23:10:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbVL2WKR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Dec 2005 17:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbVL2WKQ
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Dec 2005 17:10:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:38350 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751049AbVL2WKP (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Dec 2005 17:10:15 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jBTMAEDZ021217
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 29 Dec 2005 14:10:14 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jBTMADGv023268;
	Thu, 29 Dec 2005 14:10:14 -0800
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <Pine.LNX.4.64.0512291404240.3298@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14108>



On Thu, 29 Dec 2005, Linus Torvalds wrote:
>
> But in the meantime you can hack around it with something like
> 
> 	git send-pack <destination> $(cd .git/refs/ ; echo tags/*)
> 
> which is a silly way to list all tags ;)

Actually, I guess it should use "find tags/ -type f" or something like 
that instead of "echo tags/*". Otherwise you don't get tags with slashes 
right.

		Linus
