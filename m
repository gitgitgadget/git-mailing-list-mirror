From: Stefan Naewe <stefan.naewe@gmail.com>
Subject: [PATCH v3] Documentation/git-update-index: refer to 'ls-files'
Date: Tue, 20 Sep 2011 15:11:33 +0200
Message-ID: <1316524293-23458-1-git-send-email-stefan.naewe@gmail.com>
Cc: Stefan Naewe <stefan.naewe@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 15:11:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6077-0000PB-JB
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 15:11:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890Ab1ITNLs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Sep 2011 09:11:48 -0400
Received: from mail96.atlas.de ([194.156.172.86]:27426 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750803Ab1ITNLs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2011 09:11:48 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id 2E609100A1;
	Tue, 20 Sep 2011 15:11:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at lxsrv96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (lxsrv96.atlas.de [127.0.0.1]) (amavisd-new, port 10124)
	with ESMTP id akITjWdxrJLJ; Tue, 20 Sep 2011 15:11:47 +0200 (CEST)
Received: from mgsrv01.atlas.de (mailrelay-atlas.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Tue, 20 Sep 2011 15:11:46 +0200 (CEST)
Received: from as100897.atlas.de (as100897.atlas.de [141.200.51.220])
	by mgsrv01.atlas.de (Postfix) with ESMTP id C35F12718E;
	Tue, 20 Sep 2011 15:11:46 +0200 (CEST)
Received: by as100897.atlas.de (Postfix, from userid 1000)
	id AC7D014088; Tue, 20 Sep 2011 15:11:46 +0200 (CEST)
X-Mailer: git-send-email 1.7.7.rc2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181763>

'ls-files' refers to 'update-index' to show how the 'assume unchanged'
bit can be seen. This makes the connection 'bi-directional'.

Signed-off-by: Stefan Naewe <stefan.naewe@gmail.com>
---

 The commit message in v2 of this got truncated somehow.

 Documentation/git-update-index.txt |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index d393129..cb1dd7b 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -276,6 +276,8 @@ unchanged".  Note that "assume unchanged" bit is *not* set if
 the index (use `git update-index --really-refresh` if you want
 to mark them as "assume unchanged").
 
+To see which files have the "assume unchanged" bit set, use
+`git ls-files -v` (see linkgit:git-ls-files[1]).
 
 Examples
 --------
@@ -363,7 +365,8 @@ ctime for marking files processed) (see linkgit:git-config[1]).
 SEE ALSO
 --------
 linkgit:git-config[1],
-linkgit:git-add[1]
+linkgit:git-add[1],
+linkgit:git-ls-files[1]
 
 GIT
 ---
-- 
1.7.7.rc2
