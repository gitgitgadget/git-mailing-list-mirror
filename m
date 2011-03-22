From: Nicolas Morey-Chaisemartin <nmorey@kalray.eu>
Subject: [PATCH 2/2] Documentation/git-submodule.txt: Document the new 'U'
 prefix of git submodule status on submodules with merge conflicts
Date: Tue, 22 Mar 2011 09:56:18 +0100
Message-ID: <4D886432.6060007@kalray.eu>
References: <51d033dc2978d62164dcb76b679bb7ebd9bc1802.1300784018.git.nmorey@kalray.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 22 10:01:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1xTM-0000JN-22
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 10:01:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830Ab1CVJBq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 05:01:46 -0400
Received: from mailhost.kalray.eu ([217.108.237.233]:60569 "EHLO EKA.kalray.eu"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751146Ab1CVJBo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 05:01:44 -0400
X-Greylist: delayed 326 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Mar 2011 05:01:44 EDT
Received: from sat.lin.mbt.kalray.eu (192.168.37.91) by EKA.kalray.eu
 (192.168.38.100) with Microsoft SMTP Server id 8.3.83.0; Tue, 22 Mar 2011
 09:55:28 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <51d033dc2978d62164dcb76b679bb7ebd9bc1802.1300784018.git.nmorey@kalray.eu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169711>

Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
---
 Documentation/git-submodule.txt |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 3a5aa01..1a16ff6 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -101,9 +101,10 @@ status::
 	currently checked out commit for each submodule, along with the
 	submodule path and the output of 'git describe' for the
 	SHA-1. Each SHA-1 will be prefixed with `-` if the submodule is not
-	initialized and `+` if the currently checked out submodule commit
+	initialized, `+` if the currently checked out submodule commit
 	does not match the SHA-1 found in the index of the containing
-	repository. This command is the default command for 'git submodule'.
+	repository and `U` if the submodule has merge conflicts.
+	This command is the default command for 'git submodule'.
 +
 If '--recursive' is specified, this command will recurse into nested
 submodules, and show their status as well.
-- 
1.7.4
