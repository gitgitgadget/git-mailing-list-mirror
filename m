From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] show_date(): rename the "relative" parameter to "mode"
Date: Tue, 27 Feb 2007 15:53:06 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702271548030.12485@woody.linux-foundation.org>
References: <Pine.LNX.4.63.0702271620390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702271339550.12485@woody.linux-foundation.org>
 <Pine.LNX.4.63.0702272313020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702271453030.12485@woody.linux-foundation.org>
 <Pine.LNX.4.63.0702280010020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Simon Josefsson <simon@josefsson.org>,
	junkio@cox.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 28 00:53:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMC84-0002Il-HN
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 00:53:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752655AbXB0XxF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 18:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752654AbXB0XxF
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 18:53:05 -0500
Received: from smtp.osdl.org ([65.172.181.24]:57807 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752655AbXB0XxD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 18:53:03 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1RNqkhB023128
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 27 Feb 2007 15:52:47 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1RNqkTg000563;
	Tue, 27 Feb 2007 15:52:46 -0800
In-Reply-To: <Pine.LNX.4.63.0702280010020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-2.442 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40853>



On Wed, 28 Feb 2007, Johannes Schindelin wrote:
> 
> If you use "next" Git:
> 
> 	$ git log --pretty=format:"%h %ad %an"

Well, that has the long-format date, which really isn't appropriate for a 
one-liner format. 

It's one of the reasons I agreed with your show_date() changes: I think 
our date output formats are fairly limited. I love the long date format, 
but if I want to show a commit name and author name and email on the same 
line, no way can we use 30+ characters for just the date.

So the part about the GNU ChangeLog format I like is the single-line 
header thing.. Right now, the choice between "--pretty=xxx" choices is 
"oneline", "short", "medium", and there's something lacking there in 
between ("terse").

The "format:" thing certainly gives us more options to play with, though.

			Linus
