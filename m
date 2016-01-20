From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: [PATCH] completion: Add --word-diff-regex= to diff
Date: Wed, 20 Jan 2016 18:34:58 +0100
Message-ID: <569FC542.2060504@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	=?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 20 18:53:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLwwb-0003ep-Ai
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 18:53:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757298AbcATRxQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2016 12:53:16 -0500
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:47796 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757133AbcATRxP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jan 2016 12:53:15 -0500
X-Greylist: delayed 1093 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Jan 2016 12:53:14 EST
Received: from pd9fad860.dip0.t-ipconnect.de ([217.250.216.96] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1aLwep-0006H3-9E; Wed, 20 Jan 2016 18:34:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1453312395;7eddb633;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284457>

Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash
b/contrib/completion/git-completion.bash
index ab4da7f..d2a08dd 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1169,7 +1169,7 @@ __git_diff_common_options="--stat --numstat
--shortstat --summary
 			--no-prefix --src-prefix= --dst-prefix=
 			--inter-hunk-context=
 			--patience --histogram --minimal
-			--raw --word-diff
+			--raw --word-diff --word-diff-regex=
 			--dirstat --dirstat= --dirstat-by-file
 			--dirstat-by-file= --cumulative
 			--diff-algorithm=
-- 
2.7.0.windows.1
