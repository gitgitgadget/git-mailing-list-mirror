From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 1/9] completion: document __gitcomp()
Date: Sat,  8 Oct 2011 16:54:35 +0200
Message-ID: <1318085683-29830-2-git-send-email-szeder@ira.uka.de>
References: <1318085683-29830-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 08 16:55:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCYJE-0000Hc-KG
	for gcvg-git-2@lo.gmane.org; Sat, 08 Oct 2011 16:55:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977Ab1JHOzY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Oct 2011 10:55:24 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:55986 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885Ab1JHOzY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Oct 2011 10:55:24 -0400
Received: from localhost6.localdomain6 (p5B130863.dip0.t-ipconnect.de [91.19.8.99])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0Lvfyq-1R2i232hI4-017kfp; Sat, 08 Oct 2011 16:55:15 +0200
X-Mailer: git-send-email 1.7.7.187.ga41de
In-Reply-To: <1318085683-29830-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:xvWstrjriR6vxKT+zas7G6nBtoGhXeB0DNzxZO7pQpm
 6O6sAmSVBqzVWRusHm0OiijoF5qDZUR9fYI/ExiCfhPZMyVa42
 80hSO5ua+dMk0dpaXB351USldzmJS/l8RumQYXoDejWkzEm8qt
 tCx6uj4hTLt8f1RCXebCZ6uftjWNy1O8ETGoegC8BoNaLYLsgx
 GztLDeMO2b117UJB6L3fKRaG+SuYO0DnhBkoOquPk9pHEQqPsr
 jMKmCrBU37VcH/kBwyRGsD/E5wulpGXT/ApuJejAqGlO9zdwLE
 lfhwro++bdXZk00d1jV7rYYqbfCRzlg7MPgEJoHzIslO511pLt
 UiBSay96OYBsvD1rU+oR0TJthV4km79y5L0cxe7p96tytqCM5t
 GRsAedy35vYiA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183145>

I always forget which argument is which, and got tired of figuring it
out over and over again.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index b36f9e70..c0fb6e15 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -485,8 +485,13 @@ _get_comp_words_by_ref ()
 fi
 fi
=20
-# __gitcomp accepts 1, 2, 3, or 4 arguments
-# generates completion reply with compgen
+# Generates completion reply with compgen, appending a space to possib=
le
+# completion words, if necessary.
+# It accepts 1 to 4 arguments:
+# 1: List of possible completion words.
+# 2: A prefix to be added to each possible completion word (optional).
+# 3: Generate possible completion matches for this word (optional).
+# 4: A suffix to be appended to each possible completion word (optiona=
l).
 __gitcomp ()
 {
 	local cur_=3D"$cur"
--=20
1.7.7.187.ga41de
