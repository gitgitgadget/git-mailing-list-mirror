From: Michael O'Cleirigh <michael.ocleirigh@rivulet.ca>
Subject: [PATCH 0/1] Add new --index-filter example to git-filter-branch.txt
Date: Wed, 27 Apr 2011 14:08:03 -0400
Message-ID: <1303927684-6513-1-git-send-email-michael.ocleirigh@rivulet.ca>
Cc: Michael O'Cleirigh <michael.ocleirigh@rivulet.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 20:08:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF99u-0000Na-Hy
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 20:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753881Ab1D0SIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 14:08:13 -0400
Received: from rivulet.ca ([69.164.222.54]:51579 "EHLO smtp.rivulet.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753714Ab1D0SIL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 14:08:11 -0400
Received: from rivulet.com (localhost [127.0.0.1])
	by smtp.rivulet.ca (Postfix) with ESMTP id 6E768F000E;
	Wed, 27 Apr 2011 14:08:09 -0400 (EDT)
X-Mailer: git-send-email 1.7.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172254>

At work I patched git with the prevously sent --egrep-filter patch that allows
an irregular history to be retained, like where code reorganization occured and
you want to keep the history from the original locations.

The comments I recieved at that time was that my case was an --index-filter
variant.

I've reworked it into an --index-filter using the $GIT_COMMIT variable, tested
that it works, and have added it as an example to the git-filter-branch 
documentation.



Michael O'Cleirigh (1):
  Documentation/git-filter-branch: add --index-filter example

 Documentation/git-filter-branch.txt |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

-- 
1.7.2.3
