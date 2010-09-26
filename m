From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v7 1/3] rev-parse: update Documentation of --flags
Date: Mon, 27 Sep 2010 00:44:05 +1000
Message-ID: <1285512247-15600-2-git-send-email-jon.seymour@gmail.com>
References: <7v1v8hnflx.fsf@alter.siamese.dyndns.org>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org, robbat2@gentoo.org, casey@nrlssc.navy.mil,
	avarab@gmail.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Sep 26 16:41:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzsPt-00071L-Ui
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 16:41:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146Ab0IZOlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Sep 2010 10:41:07 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:57008 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932089Ab0IZOlG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 10:41:06 -0400
Received: by pwj6 with SMTP id 6so988030pwj.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 07:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Y1HqPYtNDrOIWFHOEspSTTuhnhqkqaY+wKb8iSDRPcw=;
        b=mp9k221xs+9wmFD0S1fgqHx4Ltabi+wW5q8MQjf8fSIthd4LcwrvbnW1fK+OACp76A
         A9suEOT7Ji2kMcUXmTL2PqT4mEaUpYmdVhq41B1X/PkCL9dqWfI3pZ29rqMwPR28g5yn
         kOv+BsWrg4hqa3OcUdW4WMY60RbU1ll7sCTT8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FFvcNaPj+5Y4HC7eK5rQWknabCe6tgn7wUQFmoQVakRq31EXhEP4hmpGEil/zDtVNr
         DO+yRCZbDPkriPjrgj1lAUpVftwx4dJigXVDA0VsP5v8lC9xGGjDCgDf5ncg6H7NrJeO
         xNIv9944cVUe/Y5nC1kFn9LVY/KPh7tL4T2ss=
Received: by 10.142.90.12 with SMTP id n12mr5181859wfb.192.1285512065959;
        Sun, 26 Sep 2010 07:41:05 -0700 (PDT)
Received: from localhost.localdomain (124-169-4-134.dyn.iinet.net.au [124.169.4.134])
        by mx.google.com with ESMTPS id o9sm5877375wfd.4.2010.09.26.07.41.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Sep 2010 07:41:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.3.g9129b6
In-Reply-To: <7v1v8hnflx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157228>

This change updates the documentation of git rev-parse --flags
so that the documentation accurately matches the current
implementation.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 Documentation/git-rev-parse.txt |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 341ca90..27d15b0 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -49,7 +49,10 @@ OPTIONS
 	'git rev-list' command.
 
 --flags::
-	Do not output non-flag parameters.
+	Output any flag and revision-like values in the remaining parameters.
++
+Note that any parameter which is also a valid 'git rev-parse' option
+will be interpreted as an option to 'git rev-parse' and thus will not be output.
 
 --no-flags::
 	Do not output flag parameters.
-- 
1.7.3.3.g9129b6
