From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH 0/2] Documentation/githooks: mention pwd, $GIT_PREFIX
Date: Sat, 10 Jan 2015 01:49:56 -0500
Message-ID: <1420872598-9609-1-git-send-email-rhansen@bbn.com>
Cc: rhansen@bbn.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 10 07:50:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9psI-0004hf-RI
	for gcvg-git-2@plane.gmane.org; Sat, 10 Jan 2015 07:50:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752302AbbAJGuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2015 01:50:13 -0500
Received: from smtp.bbn.com ([128.33.0.80]:30545 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751062AbbAJGuM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2015 01:50:12 -0500
Received: from socket.bbn.com ([192.1.120.102]:53654)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1Y9psB-000AUj-0G; Sat, 10 Jan 2015 01:50:11 -0500
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id A4DE43FF9A
X-Mailer: git-send-email 2.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262256>

A couple of patches to document and test that hooks are run from the
top-level directory and that GIT_PREFIX is set to the subdirectory
that Git was run from (like !aliases).

The new documentation is mostly lifted from the documentation for
alias.*.  I don't think the new documentation is perfectly clear, but
it's a start.  In particular, what does Git do for hook pwd and
GIT_PREFIX when it is run from within a bare repository?  Or from
within .git?  Or if GIT_WORK_TREE (--work-tree) and/or GIT_DIR
(--git-dir) are set?  Many of these same questions apply to !aliases,
so the documentation for alias.* should also be shored up.

-Richard


Richard Hansen (2):
  Documentation/githooks: mention pwd, $GIT_PREFIX
  t1020-subdirectory.sh: check hook pwd, $GIT_PREFIX

 Documentation/githooks.txt |  6 ++++++
 t/t1020-subdirectory.sh    | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

-- 
2.2.1
