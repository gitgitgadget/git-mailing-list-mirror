From: Stefan Naewe <stefan.naewe@atlas-elektronik.com>
Subject: [PATCH] git ls-remote: make usage string match manpage
Date: Tue, 11 Nov 2008 16:52:31 +0100
Message-ID: <1226418751-18747-1-git-send-email-stefan.naewe@atlas-elektronik.com>
Cc: Stefan Naewe <stefan.naewe@atlas-elektronik.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 11 17:17:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzvsW-0001pI-07
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 17:14:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbYKKQMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 11:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbYKKQMx
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 11:12:53 -0500
Received: from lxsrv96.atlas.de ([194.156.172.86]:57278 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751459AbYKKQMw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 11:12:52 -0500
X-Greylist: delayed 1220 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Nov 2008 11:12:52 EST
Received: from vssrv01.atlas.de (vssrv01.atlas.de [10.200.101.18])
	by mail96.atlas.de (Postfix) with SMTP id 9EDEA138B3
	for <git@vger.kernel.org>; Tue, 11 Nov 2008 16:52:31 +0100 (CET)
Received: from mgsrv01.atlas.de ([10.200.101.16])
 by vssrv01.atlas.de (SMSSMTP 4.1.9.35) with SMTP id M2008111116523110433
 for <git@vger.kernel.org>; Tue, 11 Nov 2008 16:52:31 +0100
Received: from mgsrv01.atlas.de (localhost [127.0.0.1])
	by mail01-int.atlas.de (Postfix) with ESMTP id 6E62927177;
	Tue, 11 Nov 2008 16:52:31 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on mgsrv01.atlas.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=5.0 tests=ALL_TRUSTED,BAYES_50
	autolearn=disabled version=3.2.5
Received: from as100897.atlas.de (as100897.atlas.de [141.200.51.220])
	by mail01.atlas.de (Postfix) with ESMTP id 651C127176;
	Tue, 11 Nov 2008 16:52:31 +0100 (CET)
Received: by as100897.atlas.de (Postfix, from userid 1000)
	id 60E8314101; Tue, 11 Nov 2008 16:52:31 +0100 (CET)
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100647>

The usage string of 'git ls-remote' is pretty terse. The manpage
however gives the correct 'synopsis'.

Signed-off-by: Stefan Naewe <stefan.naewe@atlas-elektronik.com>
---
 builtin-ls-remote.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-ls-remote.c b/builtin-ls-remote.c
index c21b841..78a88f7 100644
--- a/builtin-ls-remote.c
+++ b/builtin-ls-remote.c
@@ -4,7 +4,7 @@
 #include "remote.h"
 
 static const char ls_remote_usage[] =
-"git ls-remote [--upload-pack=<git-upload-pack>] [<host>:]<directory>";
+"git ls-remote [--heads] [--tags]  [-u <exec> | --upload-pack <exec>] <repository> <refs>...";
 
 /*
  * Is there one among the list of patterns that match the tail part
-- 
1.5.6.5
