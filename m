From: cmumford <cmumford@cmumford.com>
Subject: showing unmerged changes from branch
Date: Sun, 21 Nov 2010 15:37:07 -0800 (PST)
Message-ID: <1290382627024-5761241.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 22 00:37:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKJT9-0004c2-VO
	for gcvg-git-2@lo.gmane.org; Mon, 22 Nov 2010 00:37:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754974Ab0KUXhI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Nov 2010 18:37:08 -0500
Received: from kuber.nabble.com ([216.139.236.158]:39808 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754857Ab0KUXhH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Nov 2010 18:37:07 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <cmumford@cmumford.com>)
	id 1PKJT1-0005cr-0y
	for git@vger.kernel.org; Sun, 21 Nov 2010 15:37:07 -0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161875>


Hi:

I'm a Subversion user new to Git. I've created a local branch from a remote
master and want to cherry pick changes to the remote master and merge them
into my branch. Periodically I want to do a full merge from the remote
master to my local branch, and then continue to cherry pick changes.

So to see the available changes I did this:

git show-branch

And once I identified a change that I want I did this:

git cherry-pick --no-commit <remote master commit sha1>

I then build/test the change, and once happy with I'll commit to my local
branch. My question is now that I've cherry picked one change I want to get
a list of all unmerged changes - filtering out ones I've already done?

I'm probably thinking of Git in Subversion terms and not yet thinking the
"Git way". Help is much appreciated.

-Chris
-- 
View this message in context: http://git.661346.n2.nabble.com/showing-unmerged-changes-from-branch-tp5761241p5761241.html
Sent from the git mailing list archive at Nabble.com.
