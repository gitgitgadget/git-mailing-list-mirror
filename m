From: Zemacsh <ruini.xue@gmail.com>
Subject: "git apply --check" successes but git am says "does not match index"
Date: Sun, 14 Aug 2011 09:36:30 +0000 (UTC)
Message-ID: <loom.20110814T113311-277@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 14 11:40:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsXB9-00076X-WD
	for gcvg-git-2@lo.gmane.org; Sun, 14 Aug 2011 11:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752670Ab1HNJkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Aug 2011 05:40:07 -0400
Received: from lo.gmane.org ([80.91.229.12]:36983 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752585Ab1HNJkG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2011 05:40:06 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QsXAr-0006wt-2i
	for git@vger.kernel.org; Sun, 14 Aug 2011 11:40:05 +0200
Received: from 219.131.223.238 ([219.131.223.238])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 14 Aug 2011 11:40:05 +0200
Received: from ruini.xue by 219.131.223.238 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 14 Aug 2011 11:40:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 219.131.223.238 (Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/534.30 (KHTML, like Gecko) Ubuntu/11.04 Chromium/12.0.742.112 Chrome/12.0.742.112 Safari/534.30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179319>

Hi, all, 

I met a problem with git am.

Before applying a mbox patch, "git apply --check" reports OK. Then, I run 'git 
am', however, it complains "does not match index". Actually, both working tree 
and index are clean. what might be the problem?

If I run "git am --abort" now, and re-turn "git am". To my surprise, everything 
goes well.

Best

-- zemacsh
