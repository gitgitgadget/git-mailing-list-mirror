From: Michal Vitecek <fuf@mageo.cz>
Subject: [RFH] git cherry-pick takes forever
Date: Wed, 10 Sep 2008 10:26:10 +0200
Message-ID: <20080910082610.GA3144@mageo.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 10 10:47:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdLMG-0005Fn-92
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 10:47:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751989AbYIJIqH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 04:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751946AbYIJIqG
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 04:46:06 -0400
Received: from interactive-1.com ([193.85.232.82]:49127 "EHLO
	interactive-1.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838AbYIJIqF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 04:46:05 -0400
X-Greylist: delayed 1190 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Sep 2008 04:46:05 EDT
Received: from interactive-1.com (localhost.localdomain [127.0.0.1])
	by interactive-1.com (Postfix) with ESMTP id 305762D3CA2
	for <git@vger.kernel.org>; Wed, 10 Sep 2008 10:26:12 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95499>

 Hello everyone,

 I have two git repositories: one is the origin of the other. However no
 merging is being done as the projects in the repositories quite differ
 but still use the same core. So to propagate changes I cherry-pick
 those which are useful from one repository to another.

 however 'git cherry-pick' has lately started to last almost forever:

 $ time git cherry-pick b42b77e66a83f1298d9900a9bb1078b9b42e8618
 Finished one cherry-pick.
 Created commit 7caef83: - removed some superfluous newlines
 2 files changed, 0 insertions(+), 2 deletions(-)
 git cherry-pick b42b77e66a83f1298d9900a9bb1078b9b42e8618  282.97s user 34.69s system 100% cpu 5:17.63 total

 Both repositories have approximately 16k commits and their forking
 point (merge base) is 250 to 490 commits far away. 'git gc' (even
 --prune) has been run.

 What can I do to make the 'git cherry-pick' instant again?

        Thank you,

 P.S.: I'm using git-1.6.0.1.
-- 
		Michal Vitecek		(fuf@mageo.cz)
