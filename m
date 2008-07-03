From: David Brown <git@davidb.org>
Subject: Cherry picking instead of merges.
Date: Thu, 3 Jul 2008 11:26:50 -0700
Message-ID: <20080703182650.GA11166@old.davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 03 20:28:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KETXM-0007NL-6t
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 20:28:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753135AbYGCS0v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 14:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753361AbYGCS0v
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 14:26:51 -0400
Received: from mail.davidb.org ([66.93.32.219]:39018 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753041AbYGCS0u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 14:26:50 -0400
Received: from davidb by mail.davidb.org with local (Exim 4.69 #1 (Debian))
	id 1KETW6-0002yD-2L
	for <git@vger.kernel.org>; Thu, 03 Jul 2008 11:26:50 -0700
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87301>

We have a branch coming from "company B" who is also doing development on
the same tree as us.  We would like to do regular merges with them, but
unfortunately, there are quite a few changes in between.

First we tried a git-merge and resolved the conflicts.  The problem here is
that the resultant code didn't work.  git-bisect wasn't very useful because
the intermediate versions don't have resolved conflicts.

Yesterday, one developer cherry picked company B's changes into a branch.
It appears he resolved the conflicts for each commit, which should make
bisecting easier.

The problem is that we now have very divergent history.

Any advice on how to make use of how he resolved conflicts in order to
merge company B's changes in using git-merge.  I could always use the
"ours" strategy to just kind of force the merge, so at least future merges
would work, but it'd kind of be nice to have the proper history.

There are about 110 commits in question.

Thanks,
David Brown
