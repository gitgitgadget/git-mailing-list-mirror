From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Unexpected behavior in git-rev-list
Date: Thu, 22 Sep 2005 14:26:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509221424390.2553@g5.osdl.org>
References: <20050918144931.GA9561@ebar091.ebar.dtu.dk>
 <Pine.LNX.4.58.0509181013250.26803@g5.osdl.org> <20050918175847.GA10427@ebar091.ebar.dtu.dk>
 <20050921164948.GB23525@ebar091.ebar.dtu.dk> <Pine.LNX.4.58.0509211022180.2553@g5.osdl.org>
 <Pine.LNX.4.63.0509221617300.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Eriksen <s022018@student.dtu.dk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 22 23:27:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIYal-0003Wu-Lp
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 23:26:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030412AbVIVV0w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 17:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030418AbVIVV0v
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 17:26:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38087 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030412AbVIVV0v (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Sep 2005 17:26:51 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8MLQKBo016301
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 22 Sep 2005 14:26:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8MLQH1D021242;
	Thu, 22 Sep 2005 14:26:19 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0509221617300.23242@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.117 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9144>



On Thu, 22 Sep 2005, Daniel Barkalow wrote:
> >
> > It's not entirely trivial. The biggest bummer is that we'd have to fake
> > out the parent info (ie the "parent" would have to be the previous entry
> > that changes it, not the real one).
> 
> How about a program that made the fake thing real? That is, actually wrote 
> to the database the entire history with only those paths included, and 
> only commits that change those paths.

I think it would be a fine thing to do. If/once git-rev-list can do the 
"limit by filename" part, generating a new git history that uses that 
shouldn't be that hard.

And yes, it would be a way to generate a "subproject" automatically.

		Linus
