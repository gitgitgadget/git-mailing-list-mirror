From: Bill Lear <rael@zopyra.com>
Subject: How can git pull be up-to-date and git push fail?
Date: Thu, 5 Apr 2007 07:15:54 -0500
Message-ID: <17940.59514.150325.738141@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 05 14:16:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZQsm-0006hP-Gi
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 14:16:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1766956AbXDEMP7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 08:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992698AbXDEMP7
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 08:15:59 -0400
Received: from mail.zopyra.com ([65.68.225.25]:60701 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992693AbXDEMP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 08:15:58 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l35CFvC30771;
	Thu, 5 Apr 2007 06:15:57 -0600
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43819>

I'm trying to explain this behavior to a co-worker, and how to solve
it:

% git pull
Already up-to-date.

% git push
error: remote 'refs/remotes/origin/flexify' is not a strict subset of
localref 'refs/remotes/origin/flexify'. maybe you are not up-to-date
and need to pull first?

I believe he is using git 1.5.0 and that the above was tried from the
master branch.

So, I'm confused: I would have thought the way you solve the problem
in step 2 is by executing step 1.  Would he need to do this:

% git checkout flexify
% git pull flexify:flexify
% git checkout master
% git push


Bill
