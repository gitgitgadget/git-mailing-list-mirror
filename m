From: Stephen Kelly <steveire@gmail.com>
Subject: Wish: make commiter email address configurable per-repo
Date: Fri, 07 Jan 2011 14:16:49 +0100
Message-ID: <ig73o1$lbg$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 07 14:17:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbCBp-0004Lo-1k
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 14:17:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752816Ab1AGNRD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 08:17:03 -0500
Received: from lo.gmane.org ([80.91.229.12]:44315 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752096Ab1AGNRC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 08:17:02 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PbCBg-0004Gc-OY
	for git@vger.kernel.org; Fri, 07 Jan 2011 14:17:00 +0100
Received: from 188.111.54.34 ([188.111.54.34])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Jan 2011 14:17:00 +0100
Received: from steveire by 188.111.54.34 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Jan 2011 14:17:00 +0100
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 188.111.54.34
User-Agent: KNode/4.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164708>

Hi,

In KDE the committer email address is used to be able to use keywords in 
commit messages to automatically close bugs.

If my email address that I use for committing is not the same as that 
configured in the bugzilla, the automated bug closing does not work.

So for some git repos in KDE which I work on on work time, I'd like to set a 
different committer address. I can't just set GIT_COMMITTER_EMAIL or 
whatever in my bashrc, because in other repos I want to use a different 
committer email, and don't want it set globally for all git repos I work on.

This doesn't seem to be configurable in git config. Can that be changed?

All the best,

Steve.
