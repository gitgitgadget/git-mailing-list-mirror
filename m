From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: [PATCH] completion: Add '--edit-todo' to rebase
Date: Mon, 13 Jul 2015 13:27:56 +0200
Message-ID: <1436786876.6619.0.camel@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	SZEDER =?ISO-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 13 13:30:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZEbwB-0008EN-9G
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jul 2015 13:30:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737AbbGML2C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2015 07:28:02 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:59718 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751658AbbGML17 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Jul 2015 07:27:59 -0400
Received: from p5dd6f60f.dip0.t-ipconnect.de ([93.214.246.15] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1ZEbts-0005UB-Qg; Mon, 13 Jul 2015 13:27:56 +0200
X-Mailer: Evolution 3.12.9-1+b1 
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1436786879;d1bd2119;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273915>

Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c97c648..2567a61 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1668,7 +1668,7 @@ _git_rebase ()
 {
 	local dir="$(__gitdir)"
 	if [ -d "$dir"/rebase-apply ] || [ -d "$dir"/rebase-merge ]; then
-		__gitcomp "--continue --skip --abort"
+		__gitcomp "--continue --skip --abort --edit-todo"
 		return
 	fi
 	__git_complete_strategy && return
