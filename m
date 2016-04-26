From: Xiaolong Ye <xiaolong.ye@intel.com>
Subject: [PATCH v6 0/4] Add --base option to git-format-patch to record base tree info
Date: Tue, 26 Apr 2016 15:51:20 +0800
Message-ID: <1461657084-9223-1-git-send-email-xiaolong.ye@intel.com>
Cc: fengguang.wu@intel.com, ying.huang@intel.com, philip.li@intel.com,
	julie.du@intel.com, Xiaolong Ye <xiaolong.ye@intel.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 09:52:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auxnS-0007wY-N0
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 09:52:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752448AbcDZHwf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 03:52:35 -0400
Received: from mga09.intel.com ([134.134.136.24]:45363 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752324AbcDZHwe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 03:52:34 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP; 26 Apr 2016 00:52:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,536,1455004800"; 
   d="scan'208";a="962811994"
Received: from yexl-desktop.sh.intel.com ([10.239.159.139])
  by orsmga002.jf.intel.com with ESMTP; 26 Apr 2016 00:52:31 -0700
X-Mailer: git-send-email 2.6.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292592>

Thanks for Junio's reviews and suggestions.

This version contains the following changes since v5:

 - Fix a decl-after-statement in patch 3/4.

 - Improve testcases to cover more scenarios and make them more portable and
   readable.

Thanks,
Xiaolong

Xiaolong Ye (4):
  patch-ids: make commit_patch_id() a public helper function
  format-patch: add '--base' option to record base tree info
  format-patch: introduce --base=auto option
  format-patch: introduce format.useAutoBase configuration

 Documentation/config.txt           |   5 ++
 Documentation/git-format-patch.txt |  60 +++++++++++++
 builtin/log.c                      | 168 +++++++++++++++++++++++++++++++++++++
 patch-ids.c                        |   2 +-
 patch-ids.h                        |   2 +
 t/t4014-format-patch.sh            | 105 +++++++++++++++++++++++
 6 files changed, 341 insertions(+), 1 deletion(-)

-- 
2.8.1.343.gda643e5

base-commit: 3ad15fd5e17bbb73fb1161ff4e9c3ed254d5b243
