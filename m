From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH 0/2] add notes.merge configuration variable
Date: Fri, 31 Jul 2015 12:21:34 -0700
Message-ID: <1438370496-26433-1-git-send-email-jacob.e.keller@intel.com>
Cc: Jacob Keller <jacob.keller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 31 21:21:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLFsH-0001u6-CS
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jul 2015 21:21:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbbGaTVk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 15:21:40 -0400
Received: from mga02.intel.com ([134.134.136.20]:32814 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750827AbbGaTVj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 15:21:39 -0400
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP; 31 Jul 2015 12:21:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,586,1432623600"; 
   d="scan'208";a="533864121"
Received: from jekeller-desk.amr.corp.intel.com ([134.134.3.85])
  by FMSMGA003.fm.intel.com with ESMTP; 31 Jul 2015 12:21:38 -0700
X-Mailer: git-send-email 2.5.0.482.gfcd5645
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275070>

From: Jacob Keller <jacob.keller@gmail.com>

This small series is a precursor to some thoughts I have for enabling
easier notes collaboration. First, make it so that users can configure
the default notes merge strategy. Mostly useful if you always want to
use cat_sort_uniq.

I also found that the rewriteMode supports cat_sort_uniq but does not
document this fact.

Jacob Keller (2):
  notes: document cat_sort_uniq rewriteMode
  notes: add notes.merge option to select default strategy

 Documentation/config.txt              | 11 ++++-
 Documentation/git-notes.txt           | 33 +++++++++------
 builtin/notes.c                       | 75 +++++++++++++++++++++++++----------
 notes-merge.h                         | 16 ++++----
 t/t3309-notes-merge-auto-resolve.sh   | 29 ++++++++++++++
 t/t3310-notes-merge-manual-resolve.sh | 12 ++++++
 6 files changed, 133 insertions(+), 43 deletions(-)

-- 
2.5.0.482.gfcd5645
