From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH 2/3] Documentation: Add --line-number to git-grep synopsis
Date: Tue,  3 May 2011 23:35:56 +0200
Message-ID: <1304458557-25629-2-git-send-email-michal.kiedrowicz@gmail.com>
References: <1304458557-25629-1-git-send-email-michal.kiedrowicz@gmail.com>
Cc: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 03 23:36:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHNGU-0000mK-8E
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 23:36:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755381Ab1ECVgM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2011 17:36:12 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:59874 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755378Ab1ECVgL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2011 17:36:11 -0400
Received: by wwa36 with SMTP id 36so541954wwa.1
        for <git@vger.kernel.org>; Tue, 03 May 2011 14:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=A3itsVzz+0lhxB68EyaiT6qO7T+aM4m52/2qHyftPkU=;
        b=FzJ8CpTZAI/q9xIHXSTMUlYCdv5Vg51qjCFXBF/fqy26cTPbooPWG4oAtxLdePPYu0
         I8idTrIoEMKSB1jabLZeNuah6mW/nE+VYE1ulLWDah/+WMBlUOlbJ8a3JIleCs42NIzy
         M0RTMv55H/UFabw2JSMUGsm4gCDFi9B+Gx/Ek=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ddgOxKoPlMiK4u4aC5tCjyZvdDVNE86j06pLy9S2FeHZqpIQ0+OwfyOXX8V3wgHLfB
         KWgFnDFs7J38GsTk6YLAyqKWn7rex7DPGb2zGUsDlM7Fv+1Jgvip/jg2Zl3J8/KI5z3m
         xBmz4cSpMu09LeGxir6chxXW87N7dPhOthSTI=
Received: by 10.227.198.17 with SMTP id em17mr378024wbb.4.1304458570166;
        Tue, 03 May 2011 14:36:10 -0700 (PDT)
Received: from localhost (85-177-78-94.net.stream.pl [94.78.177.85])
        by mx.google.com with ESMTPS id b6sm16705wby.28.2011.05.03.14.36.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 03 May 2011 14:36:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1304458557-25629-1-git-send-email-michal.kiedrowicz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172696>

---
 Documentation/git-grep.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index d7523b3..4a58378 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git grep' [-a | --text] [-I] [-i | --ignore-case] [-w | --word-regexp]
 	   [-v | --invert-match] [-h|-H] [--full-name]
 	   [-E | --extended-regexp] [-G | --basic-regexp]
-	   [-F | --fixed-strings] [-n]
+	   [-F | --fixed-strings] [-n | --line-number]
 	   [-l | --files-with-matches] [-L | --files-without-match]
 	   [(-O | --open-files-in-pager) [<pager>]]
 	   [-z | --null]
-- 
1.7.3.4
