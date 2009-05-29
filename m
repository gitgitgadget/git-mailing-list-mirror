From: Doki Pen <doki_pen@doki-pen.org>
Subject: git-svn fetch
Date: Fri, 29 May 2009 15:09:58 +0000 (UTC)
Message-ID: <gvots5$uob$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 29 17:15:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MA3ng-0006AL-CK
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 17:15:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760252AbZE2PPD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 11:15:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759845AbZE2PPD
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 11:15:03 -0400
Received: from main.gmane.org ([80.91.229.2]:55768 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758210AbZE2PPC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 11:15:02 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1MA3nS-00054v-Mw
	for git@vger.kernel.org; Fri, 29 May 2009 15:15:02 +0000
Received: from 209.190.172.178 ([209.190.172.178])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 May 2009 15:15:02 +0000
Received: from doki_pen by 209.190.172.178 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 May 2009 15:15:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 209.190.172.178
User-Agent: Pan/0.133 (House of Butterflies)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120285>

I'm sorry if this has been brought up before, I did look through the 
archive and didn't see it.  

I am working with a repo that has about 7000 commits and about 100 
branches/tags.  I've been using git-svn for about 4 months now and love 
it.  The problem I'm experiencing is that everytime a new branch is added, 
git svn fetch seems to download the entire history all the way from r1.  
Is this the expected behavior?  If so, why is that?  Don't we already have 
the old revisions from trunk and other branches?  
