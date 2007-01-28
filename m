From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] user-manual: set user.name and user.email with repo-config
Date: Sat, 27 Jan 2007 17:47:49 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701271745000.25027@woody.linux-foundation.org>
References: <20070127062826.GE14205@fieldses.org> <20070128002246.GA10179@moooo.ath.cx>
 <Pine.LNX.4.64.0701271625120.25027@woody.linux-foundation.org>
 <20070128013452.GA11244@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
To: Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Sun Jan 28 02:48:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAz9O-0003dD-Kw
	for gcvg-git@gmane.org; Sun, 28 Jan 2007 02:48:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850AbXA1Br7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 20:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751873AbXA1Br7
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 20:47:59 -0500
Received: from smtp.osdl.org ([65.172.181.24]:42567 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751850AbXA1Br7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 20:47:59 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0S1lo1m025987
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 27 Jan 2007 17:47:50 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0S1lnFo020406;
	Sat, 27 Jan 2007 17:47:49 -0800
In-Reply-To: <20070128013452.GA11244@moooo.ath.cx>
X-Spam-Status: No, hits=-2.477 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.172 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38010>



On Sun, 28 Jan 2007, Matthias Lederhofer wrote:
> 
> Good point, otoh the git-repo-config manual page is actually the one
> documenting .git/config :).

Btw, one thing I don't like about "git-repo-config" is the name.

Many people thought "git init-db" was confusing, and now we call it just 
"git init".

Can I vote for doing that for "git repo-config" too? Is there something 
wrong with just calling it "git config"?

Especially as it's not even repo-specific. Use "--global", and it has 
almost nothing at all to do with the particular "repo" you're working 
with.

What would also mean that we'd have the man-page with a simple

	man git-config

which makes tons of sense if it documents both the config file *and* the 
"git config" program.

Or is that too sneaky?

		Linus
