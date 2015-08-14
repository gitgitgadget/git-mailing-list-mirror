From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v7 0/4] notes.mergestrategy option(s)
Date: Fri, 14 Aug 2015 14:13:51 -0700
Message-ID: <1439586835-15712-1-git-send-email-jacob.e.keller@intel.com>
Cc: Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 14 23:14:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQMIx-0005z1-03
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 23:14:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752646AbbHNVOT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 17:14:19 -0400
Received: from mga09.intel.com ([134.134.136.24]:14107 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752269AbbHNVOR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 17:14:17 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP; 14 Aug 2015 14:14:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,680,1432623600"; 
   d="scan'208";a="784359580"
Received: from jekeller-desk.amr.corp.intel.com ([134.134.3.85])
  by orsmga002.jf.intel.com with ESMTP; 14 Aug 2015 14:13:57 -0700
X-Mailer: git-send-email 2.5.0.280.g4aaba03
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275959>

From: Jacob Keller <jacob.keller@gmail.com>

Changes since v6
* Eric suggested a more stream-lined approach for
  git_config_get_notes_strategy

Jacob Keller (4):
  notes: document cat_sort_uniq rewriteMode
  notes: add tests for --commit/--abort/--strategy exclusivity
  notes: add notes.mergestrategy option to select default strategy
  notes: teach git-notes about notes.<ref>.mergestrategy option

 Documentation/config.txt              | 18 ++++++++--
 Documentation/git-notes.txt           | 23 ++++++++++--
 builtin/notes.c                       | 56 ++++++++++++++++++++++-------
 notes-merge.h                         | 16 +++++----
 t/t3309-notes-merge-auto-resolve.sh   | 68 +++++++++++++++++++++++++++++++++++
 t/t3310-notes-merge-manual-resolve.sh | 12 +++++++
 6 files changed, 169 insertions(+), 24 deletions(-)

-- 
2.5.0.280.g4aaba03
