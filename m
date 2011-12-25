From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv3 00/11] git-p4: asciidoc documentation and fixes
Date: Sat, 24 Dec 2011 21:07:29 -0500
Message-ID: <1324778860-4821-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 25 03:08:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RedVL-0007hT-No
	for gcvg-git-2@lo.gmane.org; Sun, 25 Dec 2011 03:08:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755000Ab1LYCHt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Dec 2011 21:07:49 -0500
Received: from honk.padd.com ([74.3.171.149]:37298 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752875Ab1LYCHs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Dec 2011 21:07:48 -0500
Received: from arf.padd.com (unknown [50.55.144.134])
	by honk.padd.com (Postfix) with ESMTPSA id 8BBAE31BF;
	Sat, 24 Dec 2011 18:07:47 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 6724C315E1; Sat, 24 Dec 2011 21:07:40 -0500 (EST)
X-Mailer: git-send-email 1.7.8.1.398.gf9d11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187663>

This series starts with a revamp of the documentation for git-p4,
moving it into Documentation/ with the rest of the docs.  Changes
from v2 of this series are:

    - rename tests to be consistent: t98<num>-git-p4-<topic>.sh
    - drop debug() test helper

Pete Wyckoff (11):
  rename git-p4 tests
  git-p4: introduce asciidoc documentation
  git-p4: clone does not use --git-dir
  git-p4: test cloning with two dirs, clarify doc
  git-p4: document and test clone --branch
  git-p4: honor --changesfile option and test
  git-p4: document and test --import-local
  git-p4: test --max-changes
  git-p4: test --keep-path
  git-p4: test and document --use-client-spec
  git-p4: document and test submit options

 Documentation/git-p4.txt                           |  480 ++++++++++++++++++++
 contrib/fast-import/git-p4                         |   32 ++-
 contrib/fast-import/git-p4.txt                     |  302 ------------
 t/{t9800-git-p4.sh => t9800-git-p4-basic.sh}       |   60 +++
 ...etachars.sh => t9803-git-p4-shell-metachars.sh} |    0
 ...it-edit.sh => t9805-git-p4-skip-submit-edit.sh} |    0
 t/t9806-git-p4-options.sh                          |  170 +++++++
 t/t9807-git-p4-submit.sh                           |   92 ++++
 t/t9807-submit.sh                                  |   38 --
 t/{t9808-chdir.sh => t9808-git-p4-chdir.sh}        |    0
 10 files changed, 831 insertions(+), 343 deletions(-)
 create mode 100644 Documentation/git-p4.txt
 delete mode 100644 contrib/fast-import/git-p4.txt
 rename t/{t9800-git-p4.sh => t9800-git-p4-basic.sh} (90%)
 rename t/{t9803-git-shell-metachars.sh => t9803-git-p4-shell-metachars.sh} (100%)
 rename t/{t9805-skip-submit-edit.sh => t9805-git-p4-skip-submit-edit.sh} (100%)
 create mode 100755 t/t9806-git-p4-options.sh
 create mode 100755 t/t9807-git-p4-submit.sh
 delete mode 100755 t/t9807-submit.sh
 rename t/{t9808-chdir.sh => t9808-git-p4-chdir.sh} (100%)

-- 
1.7.8.534.g03ab.dirty
