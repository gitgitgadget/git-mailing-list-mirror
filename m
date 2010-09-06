From: Elijah Newren <newren@gmail.com>
Subject: [PATCH] revert: Fix trivial comment style issue
Date: Mon,  6 Sep 2010 15:53:24 -0600
Message-ID: <1283810004-25670-1-git-send-email-newren@gmail.com>
Cc: gitster@pobox.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 06 23:52:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Osjbd-0005mk-P8
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 23:52:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755933Ab0IFVv5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 17:51:57 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:44196 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755717Ab0IFVv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 17:51:56 -0400
Received: by pxi10 with SMTP id 10so1115256pxi.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 14:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=ksnkZCDK7aq8oEeMo8qcwLf+jZ4F5dvmdxfT+lO1wMo=;
        b=eyK2DfmFloEcBnhs1pZB/zCCRQDa2/N+Qu7lPZS3tF1ZwpQ6IYta7Chi8thw8QDqy2
         FVnBKYAfQNbTCdvZpQqEhR9/mSmh88wJw2FqWZBtCtm5zmfLTzIAixrlvJSp7TcRjy3/
         ymNHE+SywMVP0DwWT3rgRckZpcsiMHWfMBdwM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=GSVXDWwVPE57MZ+3C7DrsLI8prlrVcnw3nHP/TH6iHCG5TS8r2ct2yzL3nP0pEnvGw
         QPHwX1K0lj2lTEg7X/FfbqxSa0wzWEZ6VOtFzr23zcy0ni/7wxPgUzZ3faoJ30Ya38zh
         aFatgzfHeyvo62zLn6fcVqRg+GzHhcfFMPSy4=
Received: by 10.142.49.15 with SMTP id w15mr2910412wfw.220.1283809915671;
        Mon, 06 Sep 2010 14:51:55 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id t18sm4805566wfc.11.2010.09.06.14.51.53
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 14:51:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.5.g80c1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155629>


Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/revert.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 8b9d829..54d13cf 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -495,7 +495,6 @@ static int do_pick_commit(void)
 	free_message(&msg);
 
 	/*
-	 *
 	 * If we are cherry-pick, and if the merge did not result in
 	 * hand-editing, we will hit this commit and inherit the original
 	 * author date and name.
-- 
1.7.2.3.5.g80c1
