From: Jim Babka <babka@bestmail.us>
Subject: git svn hangs
Date: Thu, 9 Apr 2009 20:03:02 +0000 (UTC)
Message-ID: <loom.20090409T195916-937@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 09 22:07:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ls0WO-00035Q-3N
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 22:06:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765947AbZDIUFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 16:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760413AbZDIUFH
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 16:05:07 -0400
Received: from main.gmane.org ([80.91.229.2]:43051 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762279AbZDIUFG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 16:05:06 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Ls0Ug-0001Rx-Bt
	for git@vger.kernel.org; Thu, 09 Apr 2009 20:05:02 +0000
Received: from 32.97.110.53 ([32.97.110.53])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Apr 2009 20:05:02 +0000
Received: from babka by 32.97.110.53 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Apr 2009 20:05:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 32.97.110.53 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.20) Gecko/20081217 (CK-IBM) Firefox/2.0.0.20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116204>

So I found that the problem is apparently the -s option. When I removed it, it
started copying everything. This shouldn't have been a problem, though, because
the SVN repository has a standard structure (trunk, branches and tags
directories). Anyone have any idea why this would fail?

Jim Babka
