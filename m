From: Chris Wedgwood <cw@f00f.org>
Subject: fatal: git-unpack-objects died with error code 128
Date: Mon, 17 Jul 2006 11:25:32 -0700
Message-ID: <20060717182532.GA7223@tuatara.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jul 17 20:26:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G2Xmk-0007rQ-Iu
	for gcvg-git@gmane.org; Mon, 17 Jul 2006 20:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWGQSZf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Jul 2006 14:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWGQSZf
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Jul 2006 14:25:35 -0400
Received: from smtp105.sbc.mail.mud.yahoo.com ([68.142.198.204]:53848 "HELO
	smtp105.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751134AbWGQSZe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jul 2006 14:25:34 -0400
Received: (qmail 98990 invoked from network); 17 Jul 2006 18:25:33 -0000
Received: from unknown (HELO stupidest.org) (cwedgwood@sbcglobal.net@71.202.63.228 with login)
  by smtp105.sbc.mail.mud.yahoo.com with SMTP; 17 Jul 2006 18:25:33 -0000
Received: by tuatara.stupidest.org (Postfix, from userid 10000)
	id 6E77F1810227; Mon, 17 Jul 2006 11:25:32 -0700 (PDT)
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23980>

Can anyone suggest what I should be doing to make this work?

  $ git fetch git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git :history
  warning: no common commits
  Generating pack...
  Done counting 566638 objects.
  Deltifying 566638 objects.
   100% (566638/566638) done
  Unpacking 566638 objects
  fatal: unexpected EOF done
  fatal: early EOF
  fatal: git-unpack-objects died with error code 128
  Fetch failure: git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git

using:

  git version 1.4.1


Is there some other way to achieve this?
