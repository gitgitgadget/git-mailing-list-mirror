From: Linus Torvalds <torvalds@osdl.org>
Subject: Bisection visualization hint..
Date: Tue, 30 Aug 2005 10:29:39 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508301026450.4293@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 30 19:32:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EA9wC-0006vi-GL
	for gcvg-git@gmane.org; Tue, 30 Aug 2005 19:30:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbVH3R3s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Aug 2005 13:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbVH3R3s
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Aug 2005 13:29:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63921 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751293AbVH3R3q (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Aug 2005 13:29:46 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7UHTejA016582
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 30 Aug 2005 10:29:41 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7UHTddB014592;
	Tue, 30 Aug 2005 10:29:40 -0700
To: Junio C Hamano <junkio@cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7956>


I'm testing bisection to find a bug that causes my G5 to no longer boot, 
and during the process have found this command line very nice:

	gitk bisect/bad --not $(cd .git/refs ; ls bisect/good-*)

it basically shows the state of bisection with the known bad commit as the 
top, and cutting off all the good commits - so what you see are the 
potential buggy commits.

But it's not the nicest of command lines and depends on knowing how
bisection works, so maybe we could make

	git bisect visualize

do this for us?

		Linus
