From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Add git-mergetool to run an appropriate merge conflict
 resolution program
Date: Tue, 6 Mar 2007 14:55:58 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0703061454350.5963@woody.linux-foundation.org>
References: <E1HORtY-0000zK-8B@candygram.thunk.org> <7vr6s3sz8r.fsf@assigned-by-dhcp.cox.net>
 <20070306124002.GA18370@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Mar 06 23:56:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOiZq-0008FF-Ni
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 23:56:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932627AbXCFW4L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 17:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932610AbXCFW4L
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 17:56:11 -0500
Received: from smtp.osdl.org ([65.172.181.24]:34856 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030428AbXCFW4J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 17:56:09 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l26Mu1q8024917
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 6 Mar 2007 14:56:02 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l26MtwbP011904;
	Tue, 6 Mar 2007 14:56:00 -0800
In-Reply-To: <20070306124002.GA18370@thunk.org>
X-Spam-Status: No, hits=-2.46 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41606>



On Tue, 6 Mar 2007, Theodore Tso wrote:
> 
> I assume you would prefer that it read Junio instead?  Should we
> change the COPYING while we're at it, perhaps after consulting with
> Linus since he still owns so a fair amount of the copyright on git?
> It seems that if we're going to pre-collect permissions to move to
> GPLv3, it ought to be either you or him....

I'm ok with Junio controlling it as far as I'm concerned. After all, he's 
been the maintainer for the last two years, so he gets the blame, and he'd 
better get the credit too.

			Linus
