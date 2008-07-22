From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] t/t4202-log.sh: add newline at end of file
Date: Tue, 22 Jul 2008 16:23:31 -0500
Message-ID: <LYsdPT0j_XgCi1Weyj5TOaloxtMJN0eFb0f6uag-lNlOoVmPI1sKIA@cipher.nrlssc.navy.mil>
References: <0GfECozN3g0ZvAESKMi76RyOVHEb2OhhwET9GWmEm7pbzYQJub50UlWpZtBa7MGn1UGb-7mzbzE@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 22 23:27:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLPNT-0003dW-SH
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 23:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752201AbYGVVZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 17:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752182AbYGVVZf
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 17:25:35 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:52239 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782AbYGVVZf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 17:25:35 -0400
Received: by mail.nrlssc.navy.mil id m6MLNViZ023225; Tue, 22 Jul 2008 16:23:31 -0500
In-Reply-To: <0GfECozN3g0ZvAESKMi76RyOVHEb2OhhwET9GWmEm7pbzYQJub50UlWpZtBa7MGn1UGb-7mzbzE@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 22 Jul 2008 21:23:31.0411 (UTC) FILETIME=[30B2C230:01C8EC41]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89540>

Some shells hang when parsing the script if the last statement is not
followed by a newline. So add one.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


I expect this is a bug in ksh. The ksh installed on my solaris box went
into some infinite loop on this script, continually allocating memory.
Adding the newline fixed it.

-brandon


 t/t4202-log.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index b536454..4c8af45 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -71,4 +71,5 @@ test_expect_success 'diff-filter=D' '
 
 
 
-test_done
\ No newline at end of file
+test_done
+
-- 
1.6.0.rc0.38.g8b8fb7
