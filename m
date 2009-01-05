From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Fix sourcing "test-lib.sh" using dash shell in
 "t3003-ls-files-narrow-match.sh"
Date: Mon, 5 Jan 2009 14:30:02 +0100
Message-ID: <20090105143002.8a369535.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>,
	"Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 05 14:31:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJpXl-0000VD-U0
	for gcvg-git-2@gmane.org; Mon, 05 Jan 2009 14:30:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753979AbZAEN3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2009 08:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbZAEN3R
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jan 2009 08:29:17 -0500
Received: from smtp1-g21.free.fr ([212.27.42.1]:34673 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753905AbZAEN3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2009 08:29:16 -0500
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 6FF299400E9;
	Mon,  5 Jan 2009 14:29:05 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g21.free.fr (Postfix) with SMTP id 5F25C94016E;
	Mon,  5 Jan 2009 14:29:03 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104569>

dash barfs, on my old Ubuntu box, when "test-lib.sh" is sourced
without "./".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t3003-ls-files-narrow-match.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

	This patch applies to "pu".

diff --git a/t/t3003-ls-files-narrow-match.sh b/t/t3003-ls-files-narrow-match.sh
index 9879525..b576bca 100755
--- a/t/t3003-ls-files-narrow-match.sh
+++ b/t/t3003-ls-files-narrow-match.sh
@@ -2,7 +2,7 @@
 
 test_description='This test is for narrow spec matching'
 
-. test-lib.sh
+. ./test-lib.sh
 
 D="$(cd ..;pwd)"/t3003
 
-- 
1.6.1.143.gfd590.dirty
