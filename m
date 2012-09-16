From: Yacine Belkadi <yacine.belkadi.1@gmail.com>
Subject: [PATCH] completion: add --no-edit to git-commit
Date: Sun, 16 Sep 2012 18:06:11 +0200
Message-ID: <5055F8F3.7050705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Sep 16 18:06:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDHMz-0007Vl-MG
	for gcvg-git-2@plane.gmane.org; Sun, 16 Sep 2012 18:06:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751539Ab2IPQGQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2012 12:06:16 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:56327 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202Ab2IPQGP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2012 12:06:15 -0400
Received: by eekc1 with SMTP id c1so3103052eek.19
        for <git@vger.kernel.org>; Sun, 16 Sep 2012 09:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=7H/dlJe1PF2WOoYwwURYT23T3f5F6IogCCNYrr0dSoc=;
        b=YNFKjF9IAI3udoU3LnwVXy3xu1AtfjDvBv5fS/IUrWlhcOaSJb1SMLVXTzP5GRu741
         WxQnkg21eW6dakdcFziA+xwCzXKhcmYVUb+jr18T9tX/fvHNr61xoZ77zENWl5WIonoQ
         pOX/eCpYj3SL6gmDnpA4V4RgJvSNBYZEcKOquGnuOfZmut9tD1em9Npla63Z7ibpxaiB
         Mr3wG3mfEVej3y7/h7MKHLLR9XJDP11Fzl/LymNZiS/OmCgivwEp4gBnO5uIaf9ZoSrV
         YA9GU5kxcoYJ/Ywtqu3slMoBsXDaCTurSo1FFJH3w2yosWqrgdAjZDiLfZttBd3aYwOd
         oPIA==
Received: by 10.14.207.9 with SMTP id m9mr10608687eeo.5.1347811574194;
        Sun, 16 Sep 2012 09:06:14 -0700 (PDT)
Received: from [192.168.1.81] (233.5.81.79.rev.sfr.net. [79.81.5.233])
        by mx.google.com with ESMTPS id h42sm20182434eem.5.2012.09.16.09.06.12
        (version=SSLv3 cipher=OTHER);
        Sun, 16 Sep 2012 09:06:13 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:15.0) Gecko/20120827 Thunderbird/15.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205626>

Signed-off-by: Yacine Belkadi <yacine.belkadi.1@gmail.com>
---
 contrib/completion/git-completion.bash |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash
b/contrib/completion/git-completion.bash
index 1b43329..be800e0 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1018,7 +1018,8 @@ _git_commit ()
 	--*)
 		__gitcomp "
 			--all --author= --signoff --verify --no-verify
-			--edit --amend --include --only --interactive
+			--edit --no-edit
+			--amend --include --only --interactive
 			--dry-run --reuse-message= --reedit-message=
 			--reset-author --file= --message= --template=
 			--cleanup= --untracked-files --untracked-files=
-- 
1.7.9.5
