From: Linus Torvalds <torvalds@osdl.org>
Subject: Could we please make "cherry-pick" not add the message by default?
Date: Thu, 5 Oct 2006 17:14:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610051711310.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Oct 06 02:14:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVdMQ-0003As-CG
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 02:14:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbWJFAOi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Oct 2006 20:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbWJFAOi
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Oct 2006 20:14:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51925 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932482AbWJFAOh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Oct 2006 20:14:37 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k960EYaX026021
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 5 Oct 2006 17:14:34 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k960EULd010954;
	Thu, 5 Oct 2006 17:14:32 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=-0.461 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28378>


It appears that more and more people are finding "git cherry-pick", and we 
now have a number of totally inane

	cherry picked from 1b16e7ac850969f38b375e511e3fa2f474a33867 commit

messages in the kernel logs, because I don't want to just re-cherry-pick 
them and edit peoples logs.

Those messages not only make no grammatical sense (you'd say "commit X" 
rather than "X commit"), but they have no point. The original commit is 
not reachable and makes no sense any more, and that's actually likely to 
always be the common case.

So could we just (a) fix the message word order to make sense and (b) make 
it only happen if people explicitly ask for it, rather than by default?

		Linus
