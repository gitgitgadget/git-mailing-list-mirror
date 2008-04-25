From: Bill Lear <rael@zopyra.com>
Subject: Branch "ahead of tracked remote branch"
Date: Thu, 24 Apr 2008 21:03:18 -0500
Message-ID: <18449.15334.88706.45152@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 25 04:04:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpDIF-0003jf-IB
	for gcvg-git-2@gmane.org; Fri, 25 Apr 2008 04:04:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755408AbYDYCDT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2008 22:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755290AbYDYCDT
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Apr 2008 22:03:19 -0400
Received: from mail.zopyra.com ([65.68.225.25]:61194 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755251AbYDYCDT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2008 22:03:19 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id m3P23IP05227;
	Thu, 24 Apr 2008 20:03:18 -0600
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80320>

I had some work in master, I decided to move to a branch to complete,
so:

% git checkout -b branch
% git commit -a -m "Insightful message"

Then, I decided this was not such a good idea, so I did a git reset
--soft HEAD^, then git reset HEAD for each file I committed, thinking
that this was a complete "undo".  I then switched to branch master
and got this:

Switched to branch "master"
Your branch is ahead of the tracked remote branch 'origin/master' by 1 commit.

I'm not sure this is accurate.  Does this seem correct?


Bill
