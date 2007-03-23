From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: "git revert" message changes...
Date: Fri, 23 Mar 2007 08:07:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703230805450.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 23 16:08:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUlNA-0007DB-NA
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 16:08:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422897AbXCWPIF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 11:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992456AbXCWPIF
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 11:08:05 -0400
Received: from smtp.osdl.org ([65.172.181.24]:52521 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934076AbXCWPID (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 11:08:03 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2NF7qeq020620
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 23 Mar 2007 08:07:53 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2NF7qCx017020;
	Fri, 23 Mar 2007 08:07:52 -0700
X-Spam-Status: No, hits=-0.467 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42937>


Can we please revert the "revert" changes to the default message?

Not only did it make the one-line description much less readable by 
putting the shortened SHA1 in there (and removing the quotes), it also 
missed the empty line between the header and the body.

IOW, the old scripted message was much better. The built-in is nice, but 
the new message format is inferior.

Dscho?

		Linus
