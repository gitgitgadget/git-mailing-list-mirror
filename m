From: James Widman <widman@gimpel.com>
Subject: Stashes and expiring reflogs
Date: Tue, 6 Apr 2010 21:07:40 +0000 (UTC)
Message-ID: <loom.20100406T225419-205@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 06 23:10:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzG2H-0001Zt-6F
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 23:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756721Ab0DFVKI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Apr 2010 17:10:08 -0400
Received: from lo.gmane.org ([80.91.229.12]:47892 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756698Ab0DFVKG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 17:10:06 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NzG26-0001XL-RI
	for git@vger.kernel.org; Tue, 06 Apr 2010 23:10:03 +0200
Received: from c-98-225-192-13.hsd1.pa.comcast.net ([98.225.192.13])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Apr 2010 23:10:02 +0200
Received: from widman by c-98-225-192-13.hsd1.pa.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Apr 2010 23:10:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 98.225.192.13 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_3; en-us) AppleWebKit/531.22.7 (KHTML, like Gecko) Version/4.0.5 Safari/531.22.7)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144171>

Hi all,

When I read this:

       "The latest stash you created is stored in refs/stash; older
       stashes are found in the reflog [...]"

... in the man page for git-stash, I started to feel a bit concerned,
because this seems to imply that old stashes could be pruned.  But I
couldn't find any discussion on this issue in the documentation.  I
eventually found this thread:

http://thread.gmane.org/gmane.comp.version-control.git/84665

... which was enlightening, but didn't really give me a clue as to
what the intended behavior is for the current version (1.7.0.4).
Nanako presented a possible solution here:

http://article.gmane.org/gmane.comp.version-control.git/85055

... but it does not seem to have been merged into the current version.

Even if that isn't adopted, it would be good for the documentation to
be clear about whether old stashes can be silently pruned.  I would
offer to write the documentation patch myself, but I would need
direction from someone, and it would probably take them less time to
just write it themselves.  (:
