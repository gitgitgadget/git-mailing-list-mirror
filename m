From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 09/47] remote-hg: test: be a little more quiet
Date: Mon, 13 May 2013 23:36:32 -0500
Message-ID: <1368506230-19614-10-git-send-email-felipe.contreras@gmail.com>
References: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 06:39:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc71F-00040Q-Vy
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 06:39:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752328Ab3ENEjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 00:39:11 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:51265 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276Ab3ENEjI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 00:39:08 -0400
Received: by mail-ob0-f182.google.com with SMTP id va2so94578obc.27
        for <git@vger.kernel.org>; Mon, 13 May 2013 21:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=2tZfJT9zThATuI1dO/6MMA1wz+xZWclPaGwOh0TFa/U=;
        b=sgpraGYMeZuRnShZZ9+dBYTncLqkPozN6FowDfDjIwbPB8CEIJuC14Y4x4CQi4Bin9
         /si4Q2Z24ih+eLi/OBnY5OB6C+jW2zMk8kU9sbLRuaBwEjSXPehk4A/cos0S2lxAJyHr
         Vr+QUrs1x4RtNZydbabOvfbKT+OkA8fNhfXoOaSKFjj4cECV/OR2yCeYl1lCIJrVcHoX
         9r+3K07CzS/qxRG9iB2++vyDf0+AJC2NMn6p6Q7WorG4bt+YCU8IIj8Yj7/EecE1Siac
         lbAIE0UCk7F0XU+1R3B53DW/63Ik6zpbVEGN2YptJNWYLCZg46lZ2PQM2s8T3wizBAQE
         ZmSA==
X-Received: by 10.60.116.138 with SMTP id jw10mr5719873oeb.64.1368506348127;
        Mon, 13 May 2013 21:39:08 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id x5sm20532646oep.1.2013.05.13.21.39.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 21:39:07 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224246>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-hg.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index 8de2aa7..f8d1f9e 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -109,10 +109,10 @@ test_expect_success 'update bookmark' '
   (
   git clone "hg::$PWD/hgrepo" gitrepo &&
   cd gitrepo &&
-  git checkout devel &&
+  git checkout --quiet devel &&
   echo devel > content &&
   git commit -a -m devel &&
-  git push
+  git push --quiet
   ) &&
 
   hg -R hgrepo bookmarks | egrep "devel[	 ]+3:"
-- 
1.8.3.rc1.579.g184e698
