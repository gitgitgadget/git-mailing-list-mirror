From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Questions about git-rev-parse
Date: Tue, 27 Feb 2007 19:33:03 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702271921110.12485@woody.linux-foundation.org>
References: <E1HMETh-0004BO-Lw@candygram.thunk.org> <7vvehn2eds.fsf@assigned-by-dhcp.cox.net>
 <20070228025258.GD2178@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Wed Feb 28 04:33:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMFZ3-0002mh-Ge
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 04:33:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbXB1DdK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 22:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbXB1DdK
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 22:33:10 -0500
Received: from smtp.osdl.org ([65.172.181.24]:37177 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751360AbXB1DdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 22:33:09 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1S3WjhB029599
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 27 Feb 2007 19:32:45 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1S3WheM005433;
	Tue, 27 Feb 2007 19:32:44 -0800
In-Reply-To: <20070228025258.GD2178@thunk.org>
X-Spam-Status: No, hits=-0.444 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40883>



On Tue, 27 Feb 2007, Theodore Tso wrote:
> 
> So while I'm asking questions, where did the "*-ish" terminology come 
> from, anyway?

It's means "approximate" or "having the character of". Quite like the 
normal English meaning of "thirtyish" or "fortyish" when you talk about 
approximate ages of people, or "tallish" when you talk about height. 
Google for "ish suffix", and you'll get as your first hit:

	http://www.randomhouse.com/wotd/index.pperl?date=19990617

and the git usage is actually just a variation of that.

So a "tree-ish" is not necessarily exactly a tree, but it has all the 
characteristics of a tree (by virtue of there being a well-defined 1:1 
relationship with a tree).

> I had the mental model (which I had intuited, since no git documentation 
> I could find had bothered to explain it) that -ish meant something like 
> specifier, so "tree-ish" meant tree specifier, so a commit id could get 
> dereferenced into a tree id, so it could be used to specify a tree.

No, it really is English. At least grammatically.

A "tree-ish" is "like a tree", exactly like "sheepish" is "like a sheep". 
Nothing really git-specific about it, except for it certainly having 
become common usage in a way that it may not be normally ;)

		Linus
