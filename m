From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 0/4] Fix git-gui when recentrepo list has duplicates
Date: Wed, 16 Dec 2015 23:58:03 +0000
Message-ID: <1450310287-4936-1-git-send-email-philipoakley@iee.org>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Alexey Astakhov <asstv7@gmail.com>,
	Philip Oakley <philipoakley@iee.org>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 17 00:58:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9Lxg-00037l-Ur
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 00:58:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755243AbbLPX6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 18:58:20 -0500
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:3705 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751906AbbLPX6T (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Dec 2015 18:58:19 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2CSDgDm+XFWPMm3YwJeGQEBAQEPAQEBAYI5UYgftHCCfYEMEoV1BAKBKk0BAQEBAQEHAQEBAUE/hREjgRoKGohGsh6MPYZWjj0FlnyqY4IuAYI5PoUiAQEB
X-IPAS-Result: A2CSDgDm+XFWPMm3YwJeGQEBAQEPAQEBAYI5UYgftHCCfYEMEoV1BAKBKk0BAQEBAQEHAQEBAUE/hREjgRoKGohGsh6MPYZWjj0FlnyqY4IuAYI5PoUiAQEB
X-IronPort-AV: E=Sophos;i="5.20,438,1444690800"; 
   d="scan'208";a="571788356"
Received: from host-2-99-183-201.as13285.net (HELO localhost.localdomain) ([2.99.183.201])
  by out1.ip03ir2.opaltelecom.net with ESMTP; 17 Dec 2015 00:21:55 +0000
X-Mailer: git-send-email 2.6.4.windows.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282622>

git-gui won't start if either there are duplicate invalid entries or
the user selects a duplicated entry from the gui.recentrepo list. Such
duplicates have been found in the wild.

V2 corrects the spellings, grammar and quoting errors in the commit
messages as noted by Eric Sunshine ($gmane/282430 & $gmane/282432)

Also patch 1/4 title has been shortened

This re-roll will hopefully give Pat an opportunity to consider including
the fix into the git-gui for Git V2.7

V1 series at $gmane/282360


Philip Oakley (4):
  git-gui: de-dup entries from gui.recentrepo
  git gui: cope with duplicates in _get_recentrepo
  git gui: de-dup selected repo from recentrepo history
  git gui: allow for a long recentrepo list

 git-gui/lib/choose_repository.tcl | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

-- 
2.6.4.windows.1
