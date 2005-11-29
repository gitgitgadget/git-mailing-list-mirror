From: Chuck Lever <cel@citi.umich.edu>
Subject: [PATCH 0/7]
Date: Tue, 29 Nov 2005 17:05:52 -0500
Message-ID: <20051129220552.9885.41086.stgit@dexter.citi.umich.edu>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 29 23:12:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhDfQ-0006se-QM
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 23:09:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbVK2WJh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 17:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbVK2WJh
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 17:09:37 -0500
Received: from citi.umich.edu ([141.211.133.111]:53695 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S932428AbVK2WJg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Nov 2005 17:09:36 -0500
Received: from dexter.citi.umich.edu (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id 496FF1BBE0;
	Tue, 29 Nov 2005 17:09:36 -0500 (EST)
To: catalin.marinas@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12961>

These are road-tested and ready for your review.

+ export-saves-base       | Make "stg export" save the base commit in the output directory
+ stg-in-subdirectories   | Use git-rev-parse to find the local GIT repository
+ fix-branch-description  | Align branch descriptions in output of "stg branch -l"
+ stg-series-description  | "stg series" option to show patch summary descriptions
+ stg-series-short        | Add facility to print short list of patches around 'top'
+ stg-branch-clone        | Add a "--clone" option to "stg branch"
> series-directory        | Use a separate directory for patches under each branch subdir

Before 0.8, you might also consider addressing the patch authorship issues
that come up when mailing out patches, as discussed on git@vger last week.

I've adjusted my patchmail.tmpl file as a workaround.

        -- Chuck Lever
--
corporate:    <cel at netapp dot com>
personal:     <chucklever at bigfoot dot com>
