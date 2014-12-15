From: Peter van der Does <peter@avirtualhome.com>
Subject: [PATCH] Update documentation occurrences of filename .sh
Date: Mon, 15 Dec 2014 09:34:28 -0500
Message-ID: <548EF174.1010705@avirtualhome.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 15 15:54:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0X2Y-0003ce-98
	for gcvg-git-2@plane.gmane.org; Mon, 15 Dec 2014 15:54:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753145AbaLOOyV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2014 09:54:21 -0500
Received: from zandvoort.avirtualhome.com ([96.126.105.64]:59914 "EHLO
	mail.avirtualhome.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905AbaLOOyS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2014 09:54:18 -0500
X-Greylist: delayed 1186 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Dec 2014 09:54:18 EST
Received: from [192.168.1.106] (c-69-248-90-230.hsd1.nj.comcast.net [69.248.90.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.avirtualhome.com (Postfix) with ESMTPSA id 5134B17570
	for <git@vger.kernel.org>; Mon, 15 Dec 2014 09:34:29 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.9.1 mail.avirtualhome.com 5134B17570
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=avirtualhome.com;
	s=mail; t=1418654069;
	bh=JQFylXFAR9IGqV/h3mKJD4ZammfmOjFrbjiTRjDsppQ=;
	h=Date:From:To:Subject:From;
	b=nU3AMf/o/cYh8rv2GV0jbibqo6NbExCls54DpVFQfHl1zTtpoEBq+NC+9/SJYWaj/
	 I1U9+Gw9Mfd86r7GNwgGh4Zbp5sGZphcLp2FdeZKJRW/my6JYEzW/iBThwARG4w38G
	 HD4iQ2/+8phU5FhLdveqmhExcIvE2hYdZ6+6HXHg=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:36.0) Gecko/20100101 Thunderbird/36.0a2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261407>

Documentation in the completion scripts for Bash and Zsh state the wrong filenames.

Signed-off-by: Peter van der Does <peter@avirtualhome.com>

---
 contrib/completion/git-completion.bash | 4 ++--
 contrib/completion/git-completion.zsh  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 2fece98..41608ad 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -16,9 +16,9 @@
 #
 # To use these routines:
 #
-#    1) Copy this file to somewhere (e.g. ~/.git-completion.sh).
+#    1) Copy this file to somewhere (e.g. ~/.git-completion.bash).
 #    2) Add the following line to your .bashrc/.zshrc:
-#        source ~/.git-completion.sh
+#        source ~/.git-completion.bash
 #    3) Consider changing your PS1 to also show the current branch,
 #       see git-prompt.sh for details.
 #
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 9f6f0fa..e255413 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -9,7 +9,7 @@
 #
 # If your script is somewhere else, you can configure it on your ~/.zshrc:
 #
-#  zstyle ':completion:*:*:git:*' script ~/.git-completion.sh
+#  zstyle ':completion:*:*:git:*' script ~/.git-completion.zsh
 #
 # The recommended way to install this script is to copy to '~/.zsh/_git', and
 # then add the following to your ~/.zshrc file:
-- 
2.2.0
