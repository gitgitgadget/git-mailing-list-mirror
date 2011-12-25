From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 01/11] rename git-p4 tests
Date: Sat, 24 Dec 2011 21:07:30 -0500
Message-ID: <1324778860-4821-2-git-send-email-pw@padd.com>
References: <1324778860-4821-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 25 03:08:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RedVT-0007nj-W5
	for gcvg-git-2@lo.gmane.org; Sun, 25 Dec 2011 03:08:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755439Ab1LYCIH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Dec 2011 21:08:07 -0500
Received: from honk.padd.com ([74.3.171.149]:37299 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754511Ab1LYCIG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Dec 2011 21:08:06 -0500
Received: from arf.padd.com (unknown [50.55.144.134])
	by honk.padd.com (Postfix) with ESMTPSA id B3CFB31BF;
	Sat, 24 Dec 2011 18:08:04 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 716B3315E1; Sat, 24 Dec 2011 21:08:00 -0500 (EST)
X-Mailer: git-send-email 1.7.8.1.398.gf9d11
In-Reply-To: <1324778860-4821-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187664>

Use consistent naming for all tests: "t98<num>-git-p4-<topic>.sh"

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/{t9800-git-p4.sh => t9800-git-p4-basic.sh}       |    0
 ...etachars.sh => t9803-git-p4-shell-metachars.sh} |    0
 ...it-edit.sh => t9805-git-p4-skip-submit-edit.sh} |    0
 t/{t9807-submit.sh => t9807-git-p4-submit.sh}      |    0
 t/{t9808-chdir.sh => t9808-git-p4-chdir.sh}        |    0
 5 files changed, 0 insertions(+), 0 deletions(-)
 rename t/{t9800-git-p4.sh => t9800-git-p4-basic.sh} (100%)
 rename t/{t9803-git-shell-metachars.sh => t9803-git-p4-shell-metachars.sh} (100%)
 rename t/{t9805-skip-submit-edit.sh => t9805-git-p4-skip-submit-edit.sh} (100%)
 rename t/{t9807-submit.sh => t9807-git-p4-submit.sh} (100%)
 rename t/{t9808-chdir.sh => t9808-git-p4-chdir.sh} (100%)

diff --git a/t/t9800-git-p4.sh b/t/t9800-git-p4-basic.sh
similarity index 100%
rename from t/t9800-git-p4.sh
rename to t/t9800-git-p4-basic.sh
diff --git a/t/t9803-git-shell-metachars.sh b/t/t9803-git-p4-shell-metachars.sh
similarity index 100%
rename from t/t9803-git-shell-metachars.sh
rename to t/t9803-git-p4-shell-metachars.sh
diff --git a/t/t9805-skip-submit-edit.sh b/t/t9805-git-p4-skip-submit-edit.sh
similarity index 100%
rename from t/t9805-skip-submit-edit.sh
rename to t/t9805-git-p4-skip-submit-edit.sh
diff --git a/t/t9807-submit.sh b/t/t9807-git-p4-submit.sh
similarity index 100%
rename from t/t9807-submit.sh
rename to t/t9807-git-p4-submit.sh
diff --git a/t/t9808-chdir.sh b/t/t9808-git-p4-chdir.sh
similarity index 100%
rename from t/t9808-chdir.sh
rename to t/t9808-git-p4-chdir.sh
-- 
1.7.8.534.g03ab.dirty
