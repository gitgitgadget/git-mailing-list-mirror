From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 0/3] git-svn: several house-keeping fixes
Date: Wed, 13 Jun 2007 02:37:02 -0700
Message-ID: <11817274254011-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 11:37:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyPHq-0001Rq-Ps
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 11:37:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756634AbXFMJhJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 05:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756728AbXFMJhI
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 05:37:08 -0400
Received: from hand.yhbt.net ([66.150.188.102]:49926 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755082AbXFMJhH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 05:37:07 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id A9C947DC09D;
	Wed, 13 Jun 2007 02:37:05 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Wed, 13 Jun 2007 02:37:05 -0700
X-Mailer: git-send-email 1.5.2.1.243.gbe00
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50037>

[PATCH 1/3] git-svn: cleanup: factor out longest_common_path() function
 - readability

[PATCH 2/3] git-svn: test for creating new directories over svn://
 - The bug is already long fixed, but I'd like to add it for
   documentation/regression testing purposes in case it breaks again.

[PATCH 3/3] git-svn: reduce stat() calls for a backwards compatibility check
 - There's actually a small bugfix in there, too.  This should go to maint.

-- 
Eric Wong
