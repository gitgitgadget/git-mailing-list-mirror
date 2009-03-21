From: Kevin McConnell <kevin.mcconnell@gmail.com>
Subject: [PATCH] Add --staged to bash completion for git diff
Date: Sat, 21 Mar 2009 16:29:27 -0700
Message-ID: <372194e70903211629w52705806l5a82c2dde19b73f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 22 00:31:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlAeg-000111-MP
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 00:31:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753989AbZCUX3b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 19:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753945AbZCUX33
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 19:29:29 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:37110 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752928AbZCUX33 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 19:29:29 -0400
Received: by wf-out-1314.google.com with SMTP id 29so2112784wff.4
        for <git@vger.kernel.org>; Sat, 21 Mar 2009 16:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=pEGXau5NzPDA60920fCRrjWm0dVBI0Zl+sUdpVmQ95M=;
        b=bEF1++Yurl38OoDCCqAkI9EKwIi787Qvd67P7zzs8B3lRnvdltR+PnhCAjm7P4uGmq
         m2KLd0ukIoIYNo0UGN0x1jGKtTXln16uO1RpmXf0qRY8A/Bef83nQAjLFsBnbgRL9fIL
         +y1KzxgA/tl94FS4ObnsYuOY4xoYYPZ9WBSCI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=OBXhL05kiDGvWFGxQIvBV3XVH4UTjZ9Q3JUOrjhJ/qnkL7WSRmOtXx4ZvrYT85+s95
         MCocyv0jNKWHA3QpFU8yJPEEBN3Ats01mGE5pKXFtvIF621obENBgq+jx+d48Y/4Nj76
         Ol+B7BIXmW4PxH7at9xh+azOJlMlmdsd9wCps=
Received: by 10.142.139.14 with SMTP id m14mr2133329wfd.309.1237678167655; 
	Sat, 21 Mar 2009 16:29:27 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114097>

The --staged option (synonym for --cached) isn't listed in the
completion choices for git diff.  This tiny patch adds it.
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash
b/contrib/completion/git-completion.bash
index ed235f7..6bc32df 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -899,7 +899,7 @@ _git_diff ()
 	local cur="${COMP_WORDS[COMP_CWORD]}"
 	case "$cur" in
 	--*)
-		__gitcomp "--cached --pickaxe-all --pickaxe-regex
+		__gitcomp "--cached --staged --pickaxe-all --pickaxe-regex
 			--base --ours --theirs
 			$__git_diff_common_options
 			"
-- 
1.6.2.1
