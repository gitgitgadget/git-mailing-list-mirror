From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [StGit PATCH 0/5] More UI clean-up
Date: Wed, 16 Sep 2009 22:40:50 +0100
Message-ID: <20090916214049.6622.44662.stgit@toshiba-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 16 23:49:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mo2N6-0003tX-CE
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 23:49:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760162AbZIPVsi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 17:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760176AbZIPVsd
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 17:48:33 -0400
Received: from cpc3-cmbg12-0-0-cust617.cmbg.cable.ntl.com ([86.9.126.106]:47222
	"EHLO toshiba-laptop" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760163AbZIPVs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 17:48:28 -0400
Received: by toshiba-laptop (Postfix, from userid 1000)
	id 8427B1C0794; Wed, 16 Sep 2009 22:40:50 +0100 (BST)
User-Agent: StGit/0.15-rc3-5-g9f71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128684>

The series adds makes the fold and import options consistent regarding
the -p and --reject options. The autosigning of new patches was extended
to the import command as well.

---

Catalin Marinas (5):
      Remove the 'fail_dump' argument to git.apply_patch()
      Add the --reject option to fold
      Do not create an empty patch if import failed without --reject
      Add the -p option to fold
      Autosign imported patches


 stgit/commands/fold.py  |   15 +++++++++++----
 stgit/commands/imprt.py |   18 +++++++++++++-----
 stgit/git.py            |   11 ++---------
 3 files changed, 26 insertions(+), 18 deletions(-)

-- 
Catalin
