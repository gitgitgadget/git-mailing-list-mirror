From: Eric Wong <normalperson@yhbt.net>
Subject: quieting down git-commit (and init-db) in tests
Date: Thu, 28 Dec 2006 01:10:49 -0800
Message-ID: <11672970521665-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Dec 28 10:11:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzrHw-0002Eq-1G
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 10:11:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932754AbWL1JK4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 04:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932763AbWL1JK4
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 04:10:56 -0500
Received: from hand.yhbt.net ([66.150.188.102]:42998 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932754AbWL1JKz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 04:10:55 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id B071F7DC08E;
	Thu, 28 Dec 2006 01:10:53 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Thu, 28 Dec 2006 01:10:52 -0800
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.4.3.gd4ada
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35543>

There are more places where the tests have gotten, but I noticed these
the most.  Some non-portable uses of 'export' have been replaced.
I'll try to get to the rest in a day or two, but I'm sleepy and have
more things for git-svn to do.

--
 t/t6024-recursive-merge.sh     |   90 +++++++++++++++++++++-------------------
 t/t9200-git-cvsexportcommit.sh |   10 +++--
 t/test-lib.sh                  |    2 +-
 3 files changed, 54 insertions(+), 48 deletions(-)

-- 
Eric Wong
