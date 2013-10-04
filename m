From: Stefan Saasen <ssaasen@atlassian.com>
Subject: [PATCH] mergetool--lib: Fix typo in the merge/difftool help
Date: Fri,  4 Oct 2013 07:34:53 -0700
Message-ID: <1380897293-41652-1-git-send-email-ssaasen@atlassian.com>
Cc: davvid@gmail.com, Stefan Saasen <ssaasen@atlassian.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 04 16:44:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VS6c8-0007oq-GA
	for gcvg-git-2@plane.gmane.org; Fri, 04 Oct 2013 16:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755012Ab3JDOoQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Oct 2013 10:44:16 -0400
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:55427 "HELO
	na3sys009aog133.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754996Ab3JDOoP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Oct 2013 10:44:15 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]) (using TLSv1) by na3sys009aob133.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUk7UP+D7o27041V7dDZ5B4KWXOtCqBDF@postini.com; Fri, 04 Oct 2013 07:44:15 PDT
Received: by mail-pb0-f52.google.com with SMTP id wz12so4081854pbc.11
        for <git@vger.kernel.org>; Fri, 04 Oct 2013 07:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vkEWSx4Hi4XTFJLJXuYZjzIWjwRz2TrRHpjr3ur8AIk=;
        b=lCj99/KFsimStP5gL0RqW3UYAZXVS/sLxD3r51645l6lciKh1PvreSFqWBw2hdT3Uw
         gBdvshxiFFIGOLQaHvGam+xt269M0a3SunrbJHPNBvePGLiNC1c8OGD0/yx1iM1bbxeX
         wItNpIof7nCH+F8NvjFeFLXPsHggsv2D1R+6GyPQ7Uy5RhmVXtCv2QJ8gs2+aKPqLdMz
         qNuOh+nwFRZ7ZiccYt0v64gb4OL/K/5ms8vcYZ+Ggiyca1ek0Ry9fqO86dq1F8FbeVRg
         RzvsLm0B3UUAKoTbtPQiIL2a8ZpRQBgkszv8/LJ0QtJ9qUAkiIJQsDpsNP7Xaz0jpG3Z
         p5Cg==
X-Received: by 10.66.19.137 with SMTP id f9mr16099334pae.138.1380897411977;
        Fri, 04 Oct 2013 07:36:51 -0700 (PDT)
X-Gm-Message-State: ALoCoQnQn//jy1zTlmnE6lOrG0naRfOIoaTmFlXDg9sgu9POtRaxzsef4O7pZG/qcGoaQMHV35puwCmtaZlHVD1/4eooskAiuiXdkoF1eJO3epw8taZLfVi5G+I3Q3xZY9lliY3TaTqJ3LC0O1Ra97Gr4Ekn6pU/jg==
X-Received: by 10.66.19.137 with SMTP id f9mr16099320pae.138.1380897411868;
        Fri, 04 Oct 2013 07:36:51 -0700 (PDT)
Received: from monteiths.local ([69.38.217.3])
        by mx.google.com with ESMTPSA id j9sm18534113paj.18.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 04 Oct 2013 07:36:51 -0700 (PDT)
Received: by monteiths.local (Postfix, from userid 501)
	id 95FDF1E6D71A; Fri,  4 Oct 2013 07:35:09 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.474.g128a96c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235715>

The help text for the `tool` flag should mention:

    --tool=<tool>

instead of:

    --tool-<tool>

Signed-off-by: Stefan Saasen <ssaasen@atlassian.com>
---
 git-mergetool--lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index feee6a4..e1c7eb1 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -263,7 +263,7 @@ list_merge_tool_candidates () {
 }
 
 show_tool_help () {
-	tool_opt="'git ${TOOL_MODE}tool --tool-<tool>'"
+	tool_opt="'git ${TOOL_MODE}tool --tool=<tool>'"
 
 	tab='	'
 	LF='
-- 
1.8.4.474.g128a96c.dirty
