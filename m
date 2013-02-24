From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 06/16] git-cvsexportcommit: use a lowercase "usage:" string
Date: Sat, 23 Feb 2013 16:50:14 -0800
Message-ID: <1361667024-49776-7-git-send-email-davvid@gmail.com>
References: <1361667024-49776-1-git-send-email-davvid@gmail.com>
 <1361667024-49776-2-git-send-email-davvid@gmail.com>
 <1361667024-49776-3-git-send-email-davvid@gmail.com>
 <1361667024-49776-4-git-send-email-davvid@gmail.com>
 <1361667024-49776-5-git-send-email-davvid@gmail.com>
 <1361667024-49776-6-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 01:51:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9PoI-0007hj-Vn
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 01:51:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759463Ab3BXAuu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 19:50:50 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:63224 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759390Ab3BXAut (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 19:50:49 -0500
Received: by mail-pa0-f45.google.com with SMTP id kl14so1129646pab.32
        for <git@vger.kernel.org>; Sat, 23 Feb 2013 16:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=bcJmPeIjl3Ed+x6QnZR9X+kn+UOcd1UOlwV82+kmBQc=;
        b=WPMUtyJXdqKH9gO25K4AlcDShmDnng4H6HijRNm7OBrfYYqTwBthM+u506PmmZBeKK
         9XJjd8dd+xaB5QfrEtowDii0Toz7q/jmhmzJ5yi2GsvaqK+7gC+f7Czrc6kQcOs1zUfK
         cStUpQfHi5GYlLE52dLtK2FEURM4Q8F5jMFTNBROXWaxzPQKNeshioyIwCpWrxCDGMsD
         RnZU0sFkUPJLzVielHPYjfHrJvU4bcNK5dCdr7Shc+pbl2J79RPNGlUUfsclxwF5JSlt
         kyYFhdkWEALaBoaBMiZFXhEnVo00tHu20KGBHNa/i5FSUtgKuacOupdtcaLo+XnYI4jL
         RzFQ==
X-Received: by 10.68.11.35 with SMTP id n3mr10545486pbb.220.1361667048803;
        Sat, 23 Feb 2013 16:50:48 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (remote-11.disneyanimation.com. [198.187.190.11])
        by mx.google.com with ESMTPS id a4sm8190345paw.21.2013.02.23.16.50.46
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 23 Feb 2013 16:50:47 -0800 (PST)
X-Mailer: git-send-email 1.8.2.rc0.263.g20d9441
In-Reply-To: <1361667024-49776-6-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216963>

Make the usage string consistent with Git.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-cvsexportcommit.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index e6bf252..d13f02d 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -420,7 +420,7 @@ sleep(1);
 
 sub usage {
 	print STDERR <<END;
-Usage: GIT_DIR=/path/to/.git git cvsexportcommit [-h] [-p] [-v] [-c] [-f] [-u] [-k] [-w cvsworkdir] [-m msgprefix] [ parent ] commit
+usage: GIT_DIR=/path/to/.git git cvsexportcommit [-h] [-p] [-v] [-c] [-f] [-u] [-k] [-w cvsworkdir] [-m msgprefix] [ parent ] commit
 END
 	exit(1);
 }
-- 
1.8.2.rc0.263.g20d9441
