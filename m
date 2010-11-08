From: Maaartin <grajcar1@seznam.cz>
Subject: Rebase problems
Date: Mon, 8 Nov 2010 18:19:09 +0000 (UTC)
Message-ID: <loom.20101108T190513-206@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 08 19:19:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFWJT-0006jb-BB
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 19:19:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755414Ab0KHSTW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 13:19:22 -0500
Received: from lo.gmane.org ([80.91.229.12]:49497 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753708Ab0KHSTV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 13:19:21 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PFWJM-0006g3-61
	for git@vger.kernel.org; Mon, 08 Nov 2010 19:19:20 +0100
Received: from 188-120-198-113.luckynet.cz ([188-120-198-113.luckynet.cz])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 08 Nov 2010 19:19:20 +0100
Received: from grajcar1 by 188-120-198-113.luckynet.cz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 08 Nov 2010 19:19:20 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 188.120.198.113 (Opera/9.80 (Windows NT 5.2; U; en) Presto/2.6.30 Version/10.63)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160963>

I'm using git for a project I'm working on alone (and I really like it), so I 
could rebase a lot, if I hadn't the following problems.

There's a file containing the timestamp which gets compiled in, so the 
executable can show it's version. Sometimes, I need to set it couple of times a 
day, sometimes only once a week. For each such timestamp I create a tag, so I 
can track it to the source easily. The timestamp is an important piece of 
information, so I put the containing file under version control. The downside is 
that I often get a conflict in this file halting my rebase. Is there a way how 
to ignore or automatically resolve all conflicts in this file (any resolution 
strategy is fine, as it will be overwritten anyway).

The second problem is problem of cygwin. While most of the operations git run in 
fractions of seconds, the most trivial rebase may take one minute or alike. Any 
idea what different things rebase do?
