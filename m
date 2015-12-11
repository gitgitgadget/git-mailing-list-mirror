From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] completion: remove 'git column' from porcelain commands
Date: Fri, 11 Dec 2015 13:05:00 +0100
Message-ID: <1449835500-24844-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 11 13:05:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7MS6-0002Pc-IU
	for gcvg-git-2@plane.gmane.org; Fri, 11 Dec 2015 13:05:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754166AbbLKMFa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Dec 2015 07:05:30 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:39216 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751177AbbLKMF3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Dec 2015 07:05:29 -0500
Received: from x4db27576.dyn.telefonica.de ([77.178.117.118] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 25 
	iface 141.3.10.81 id 1a7MRw-0006dU-GS; Fri, 11 Dec 2015 13:05:26 +0100
X-Mailer: git-send-email 2.7.0.rc0.37.g77d69b9
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1449835526.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282255>

'git column' is an internal helper, so it should not be offered on
'git <TAB>' along with porcelain commands.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 111b05302b..5dec8778f7 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -664,6 +664,7 @@ __git_list_porcelain_commands ()
 		check-mailmap)    : plumbing;;
 		check-ref-format) : plumbing;;
 		checkout-index)   : plumbing;;
+		column)           : internal helper;;
 		commit-tree)      : plumbing;;
 		count-objects)    : infrequent;;
 		credential)       : credentials;;
--=20
2.6.3.420.g7bbb372
