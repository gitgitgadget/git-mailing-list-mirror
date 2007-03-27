From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: .gitlink for Summer of Code
Date: Tue, 27 Mar 2007 14:11:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703271409070.6730@woody.linux-foundation.org>
References: <1174825838.12540.5.camel@localhost> <20070326220302.GH22773@admingilde.org>
 <7vfy7rvct2.fsf@assigned-by-dhcp.cox.net> <200703270117.59205.Josef.Weidendorfer@gmx.de>
 <Pine.LNX.4.64.0703270952020.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703271338210.6485@iabervon.org>
 <Pine.LNX.4.64.0703271115580.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703271602110.6485@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Junio C Hamano <junkio@cox.net>,
	Martin Waitz <tali@admingilde.org>,
	Eric Lesh <eclesh@ucla.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Mar 27 23:12:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWIxT-0001B5-7J
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 23:11:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965430AbXC0VLz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 17:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965427AbXC0VLz
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 17:11:55 -0400
Received: from smtp.osdl.org ([65.172.181.24]:43266 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965426AbXC0VLz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 17:11:55 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2RLBTU2013722
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 27 Mar 2007 14:11:29 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2RLBS4n027850;
	Tue, 27 Mar 2007 14:11:28 -0700
In-Reply-To: <Pine.LNX.4.64.0703271602110.6485@iabervon.org>
X-Spam-Status: No, hits=-0.468 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43306>



On Tue, 27 Mar 2007, Daniel Barkalow wrote:
> 
> Are you talking about submodule history, or submodule state? If they care 
> about any state but not the corresponding history, they need to do a 
> shallow clone of the subproject, right?

I don't see what the confusion is about.

Why would you want a shallow clone, and what does that have to do with 
submodules?

I'm saying that the *normal* case is that of the thousands of submodules, 
you generally care about one or two (the ones you work on).

Those modules you want full history for. The supermodule you want because 
it contains the build infrastructure. You'd generally want full history 
for that too.

There's absolutely zero reason to think shallow clones have *anything* to 
do with this. It's a totally separate dimension. Sure, you could use 
shallow clones *too*, but it has nothing to do with subprojects.

		Linus
