From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: checking for 'clean' bare repo before push
Date: Sun, 24 Jun 2012 05:21:49 -0500
Message-ID: <js6pnt$28f$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 24 12:22:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SijxN-00046G-4N
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jun 2012 12:22:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754906Ab2FXKWI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jun 2012 06:22:08 -0400
Received: from plane.gmane.org ([80.91.229.3]:60429 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754372Ab2FXKWH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2012 06:22:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SijxC-000410-Q2
	for git@vger.kernel.org; Sun, 24 Jun 2012 12:22:02 +0200
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 24 Jun 2012 12:22:02 +0200
Received: from nkreitzinger by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 24 Jun 2012 12:22:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200519>

I'm being asked to provide commands to check for 'clean' state of bare 
repo before and after a git-push.  This request is based on the notion 
of checking for a clean worktree (git status) before a checkout, merge, 
etc on a non-bare repo and checking the worktree state after such 
operations.

Context:
Since the bare repo and non-bare clone repos in question only have 
branch master, and deny-non-ff is set for the bare repo, I don't think 
there are checks to be done before and after git-push in our case. 
git-gc and git-fsck could be possible, but don't seem normative for 
every single push.  git-gc has auto configurations, and git fsck is 
expensive.  It seems like routine git-gc obviates the need for git fsck.

Am I correct on this?

v/r,
neal
