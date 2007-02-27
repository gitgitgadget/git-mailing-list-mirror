From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] show_date(): rename the "relative" parameter to "mode"
Date: Tue, 27 Feb 2007 15:02:44 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702271453030.12485@woody.linux-foundation.org>
References: <Pine.LNX.4.63.0702271620390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702271339550.12485@woody.linux-foundation.org>
 <Pine.LNX.4.63.0702272313020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Simon Josefsson <simon@josefsson.org>,
	junkio@cox.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 28 00:02:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMBLO-0004n5-NQ
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 00:02:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751996AbXB0XCo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 18:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751997AbXB0XCo
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 18:02:44 -0500
Received: from smtp.osdl.org ([65.172.181.24]:56260 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751996AbXB0XCo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 18:02:44 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1RN2PhB021622
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 27 Feb 2007 15:02:25 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1RN2OBa031531;
	Tue, 27 Feb 2007 15:02:24 -0800
In-Reply-To: <Pine.LNX.4.63.0702272313020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-2.438 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40834>



On Tue, 27 Feb 2007, Johannes Schindelin wrote:
> 
> And you are no supporter of a GNU ChangeLog? Imagine being able to produce 
> a GNU style ChangeLog of the Linux kernel in no time at all...

I don't think the GNU style ChangeLog is particularly good. In fact, I 
think it has an unfortunate tendency (thanks to being per-file-log) to 
encourage people to commit unrelated changes and then explain them per 
file.

Of course, you can't do that under git anyway, but I sure hope people 
don't start thinking that they should explain their changes in the git 
commit messages that way - my point being that certain log formats tend to 
encourage certain behaviour, and the GNU log format I think tends to do 
that exactly the wrong way around.

That said, listing the functions that got changed (which I don't know if 
you did, but some GNU changelogs do) may be a nice thing.

And hey, if some project wants GNU changelogs, I'm not against them. I 
just don't think they are in any way "superior", and the per-file comments 
really turn me off.

But the "short date + author name" on one line part I certainly don't 
disagree with. I often use "git log --stat", and the three-line 
default header that git uses is a bit verbose (but at least a shortened 
commit name would be good - one of the things I then do is that I may want 
to look in more detail at a commit).

			Linus
