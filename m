From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: [PATCH] completion: Add --ignore-blank-lines for diff
Date: Wed, 03 Sep 2014 17:00:41 +0200
Message-ID: <54072D19.6050102@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 03 17:03:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPC5L-0005wJ-U2
	for gcvg-git-2@plane.gmane.org; Wed, 03 Sep 2014 17:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932952AbaICPAu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2014 11:00:50 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:58030 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932862AbaICPAt (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Sep 2014 11:00:49 -0400
Received: from p5ddc0f44.dip0.t-ipconnect.de ([93.220.15.68] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1XPC3C-0006NB-Nk; Wed, 03 Sep 2014 17:00:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.0
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1409756449;79f44fdd;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256395>

Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
---
 contrib/completion/git-completion.bash | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 06bf262..5ea5b82 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1175,8 +1175,8 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--full-index --binary --abbrev --diff-filter=
 			--find-copies-harder
 			--text --ignore-space-at-eol --ignore-space-change
-			--ignore-all-space --exit-code --quiet --ext-diff
-			--no-ext-diff
+			--ignore-all-space --ignore-blank-lines --exit-code
+			--quiet --ext-diff --no-ext-diff
 			--no-prefix --src-prefix= --dst-prefix=
 			--inter-hunk-context=
 			--patience --histogram --minimal
-- 
1.9.4.msysgit.1
