From: Sergio <sergio.callegari@gmail.com>
Subject: git gc does not discard objects found in alternate unless the alternate storage is packed
Date: Sun, 10 Aug 2008 21:07:29 +0000 (UTC)
Message-ID: <loom.20080810T210546-549@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 10 23:09:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSIAF-0001ZZ-Rl
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 23:09:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658AbYHJVHp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 17:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753646AbYHJVHp
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 17:07:45 -0400
Received: from main.gmane.org ([80.91.229.2]:40488 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753634AbYHJVHo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 17:07:44 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KSI8W-00084M-72
	for git@vger.kernel.org; Sun, 10 Aug 2008 21:07:36 +0000
Received: from host224-59-dynamic.10-87-r.retail.telecomitalia.it ([87.10.59.224])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 10 Aug 2008 21:07:36 +0000
Received: from sergio.callegari by host224-59-dynamic.10-87-r.retail.telecomitalia.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 10 Aug 2008 21:07:36 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 87.10.59.224 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.1) Gecko/2008072820 Firefox/3.0.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91887>

Version 1.5.6.5

Looks weird
Is it the intended behaviour?

Sergio
