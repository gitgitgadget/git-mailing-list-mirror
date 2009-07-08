From: jshalvi <jshalvi@gmail.com>
Subject: branch vs. cherry-pick workflow
Date: Wed, 8 Jul 2009 13:51:38 -0700 (PDT)
Message-ID: <24399128.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 08 22:51:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOe7J-0001i5-7C
	for gcvg-git-2@gmane.org; Wed, 08 Jul 2009 22:51:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754438AbZGHUvm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2009 16:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754109AbZGHUvl
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jul 2009 16:51:41 -0400
Received: from kuber.nabble.com ([216.139.236.158]:57191 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753869AbZGHUvl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2009 16:51:41 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1MOe78-0006Ti-UW
	for git@vger.kernel.org; Wed, 08 Jul 2009 13:51:38 -0700
X-Nabble-From: jshalvi@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122919>


our team recently switched over to git, and for months I've been happily
developing on branches (as in one branch per work product/bug) and
submitting those branches to our project lead to merge.

Now I'm the one that has to do the merges, and I've learned that all the
other developers simply develop on their own main branch, and the project
lead cherry picks commits off each developer's main branch.  Except for
mine, of course, which he just has to merge.  They've even gone so far as to
put the bug number in the commit message so the project lead knows which
commit to cherry pick.

Am I crazy to think this is ass-backwards?

It seems dangerous to rely on cherry-picking like this.  Are there any good
technical reasons to insist on a branch/merge workflow as opposed to this
commit/cherry-pick workflow?  It may sound like a simple question, but
everyone seems happy doing it this way... I really don't feel like trying to
convince developers to wear their shirts right-side-out when wearing them
inside-out gets the job done just as well for them ;)

Thanks for any insight
-- 
View this message in context: http://www.nabble.com/branch-vs.-cherry-pick-workflow-tp24399128p24399128.html
Sent from the git mailing list archive at Nabble.com.
