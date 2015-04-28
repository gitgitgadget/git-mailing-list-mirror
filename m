From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] t7502-commit.sh: fix a broken and-chain
Date: Tue, 28 Apr 2015 13:04:44 +0100
Message-ID: <553F775C.3030102@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 14:04:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yn4G0-0001Tv-Nn
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 14:04:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965541AbbD1MEw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2015 08:04:52 -0400
Received: from mdfmta005.mxout.tbr.inty.net ([91.221.168.46]:36429 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965383AbbD1MEw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 08:04:52 -0400
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 8611EA64E9A;
	Tue, 28 Apr 2015 13:04:50 +0100 (BST)
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 58244A64E8A;
	Tue, 28 Apr 2015 13:04:50 +0100 (BST)
Received: from [10.0.2.15] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP;
	Tue, 28 Apr 2015 13:04:50 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
X-MDF-HostID: 8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267922>


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Junio,

This test recently started failing for me. I haven't heard anyone
else complaining about this, so maybe I should look into why my
environment may be different to everyone else ... :-D (when I can
find some time, of course!)

ATB,
Ramsay Jones

 t/t7502-commit.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index 051489e..2e0d557 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -370,7 +370,7 @@ exit 0
 EOF
 
 test_expect_success !AUTOIDENT 'do not fire editor when committer is bogus' '
-	>.git/result
+	>.git/result &&
 	>expect &&
 
 	echo >>negative &&
-- 
2.3.0
