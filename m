From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 0/5] git-svn: more cool features
Date: Tue, 27 Jun 2006 19:39:09 -0700
Message-ID: <11514623542848-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Jun 28 04:39:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvPxY-0007bM-VI
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 04:39:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422923AbWF1CjR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 22:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422924AbWF1CjR
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 22:39:17 -0400
Received: from hand.yhbt.net ([66.150.188.102]:24279 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1422923AbWF1CjQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jun 2006 22:39:16 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 140F67DC022;
	Tue, 27 Jun 2006 19:39:15 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 27 Jun 2006 19:39:14 -0700
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.1.rc1.g3cc8
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22767>

[PATCH 1/5] git-svn: SVN 1.1.x library compatibility
	Debian Sarge and Ubuntu Hoary users shall be pleased.

[PATCH 2/5] git-svn: several graft-branches improvements
	Still an experimental feature, but kinda fun.

[PATCH 3/5] git-svn: add the commit-diff command
	git-svnimport users may find this useful.

[PATCH 4/5] git-svn: add --follow-parent and --no-metadata options to fetch
	We should be closer to being able to do everything that git-svnimport
	does with this patch.  The only thing we can't do yet is automatically
	find dead-end branches that got deleted.

[PATCH 5/5] git-svn: be verbose by default on fetch/commit, add -q/--quiet option
	I actually thought I broke something and had an infinite loop
	in git-svn where one day :x

-- 
Eric Wong
