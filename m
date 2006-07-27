From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 0/4] Fetching mass of objects at once
Date: Thu, 27 Jul 2006 23:53:26 +0200
Message-ID: <20060727215326.24240.20118.stgit@machine>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: jonsmirl@gmail.com
X-From: git-owner@vger.kernel.org Thu Jul 27 23:56:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6Dq6-0006iV-1M
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 23:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWG0V4O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 17:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbWG0V4O
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 17:56:14 -0400
Received: from w241.dkm.cz ([62.24.88.241]:26574 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751065AbWG0V4O (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 17:56:14 -0400
Received: (qmail 24846 invoked from network); 27 Jul 2006 23:56:12 +0200
Received: from localhost (HELO ?62.24.88.241?) (xpasky@127.0.0.1)
  by localhost with SMTP; 27 Jul 2006 23:56:12 +0200
To: git@vger.kernel.org
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24353>

  Hi,

  this series implements support for fetching many objects at once with
git-local-fetch and git-http-fetch, greatly helping Cogito's performance.  It
would be of course nice to have this in Git 1.4.2, but it's probably too late
for that.

  I didn't bother to convert git-ssh-fetch since I think noone uses that
anymore anyway (why would they...), or only some legacy users do.

  I will followup with a patch for Cogito to take advantage of this. It's
now roughly on par with Git in cloning speed.
