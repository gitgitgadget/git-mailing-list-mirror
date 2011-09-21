From: Stefan Naewe <stefan.naewe@gmail.com>
Subject: [PATCH v4] Documentation/git-update-index: refer to 'ls-files'
Date: Wed, 21 Sep 2011 08:21:50 +0200
Message-ID: <1316586110-6845-1-git-send-email-stefan.naewe@gmail.com>
References: <7vmxdz56xt.fsf@alter.siamese.dyndns.org>
Cc: Stefan Naewe <stefan.naewe@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 21 08:22:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6GC5-0008KN-1f
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 08:22:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752099Ab1IUGWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Sep 2011 02:22:00 -0400
Received: from mail96.atlas.de ([194.156.172.86]:20031 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752017Ab1IUGV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2011 02:21:59 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id B7AE010091;
	Wed, 21 Sep 2011 08:21:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at lxsrv96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (lxsrv96.atlas.de [127.0.0.1]) (amavisd-new, port 10124)
	with ESMTP id gc7L1WsyzyxT; Wed, 21 Sep 2011 08:21:57 +0200 (CEST)
Received: from mgsrv01.atlas.de (mailrelay-atlas.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Wed, 21 Sep 2011 08:21:55 +0200 (CEST)
Received: from as100897.atlas.de (as100897.atlas.de [141.200.51.220])
	by mgsrv01.atlas.de (Postfix) with ESMTP id 970DB27193;
	Wed, 21 Sep 2011 08:21:55 +0200 (CEST)
Received: by as100897.atlas.de (Postfix, from userid 1000)
	id 804F2140DE; Wed, 21 Sep 2011 08:21:55 +0200 (CEST)
X-Mailer: git-send-email 1.7.7.rc2
In-Reply-To: <7vmxdz56xt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181816>

'ls-files' refers to 'update-index' to show how the 'assume unchanged'
bit can be seen. This makes the connection 'bi-directional'.

Signed-off-by: Stefan Naewe <stefan.naewe@gmail.com>
---

 As Junio suggested, move the new sentence a little to the place where
 setting and unsetting are explained.

 Documentation/git-update-index.txt |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index d393129..d8af8ae 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -264,7 +264,9 @@ tree files, you have to explicitly tell git about it by dropping
 "assume unchanged" bit, either before or after you modify them.
 
 In order to set "assume unchanged" bit, use `--assume-unchanged`
-option.  To unset, use `--no-assume-unchanged`.
+option.  To unset, use `--no-assume-unchanged`. To see which files
+have the "assume unchanged" bit set, use `git ls-files -v` 
+(see linkgit:git-ls-files[1]).
 
 The command looks at `core.ignorestat` configuration variable.  When
 this is true, paths updated with `git update-index paths...` and
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
