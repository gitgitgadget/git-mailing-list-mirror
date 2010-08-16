From: Guillermo <guillermog@tricuspide.com>
Subject: Commit ID of a branch
Date: Mon, 16 Aug 2010 21:19:11 +0000 (UTC)
Message-ID: <loom.20100816T231539-211@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 16 23:35:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ol7Kv-00028b-4F
	for gcvg-git-2@lo.gmane.org; Mon, 16 Aug 2010 23:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754690Ab0HPVfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Aug 2010 17:35:08 -0400
Received: from lo.gmane.org ([80.91.229.12]:49576 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753567Ab0HPVfH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Aug 2010 17:35:07 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Ol7Kk-00021M-C8
	for git@vger.kernel.org; Mon, 16 Aug 2010 23:35:06 +0200
Received: from i59F4E798.versanet.de ([89.244.231.152])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Aug 2010 23:35:04 +0200
Received: from guillermog by i59F4E798.versanet.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Aug 2010 23:35:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 89.244.231.152 (Mozilla/5.0 (Windows; U; Windows NT 6.1; en-GB; rv:1.9.2.8) Gecko/20100722 Firefox/3.6.8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153677>

Hello,

I want to write a script what checks in all my projects which is the submodule
commit that is registered in every git repo.

Lets say we have the following structure:

project1
- submodule1
project2
- submodule1

I want to find out what file within the .git dir of every project contains the
proper submodule Commit ID that should be checkout with git submodule update.

Regards,
Guillermo
