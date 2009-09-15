From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 3/4] bash: teach 'git reset --patch'
Date: Tue, 15 Sep 2009 12:21:45 +0200
Message-ID: <ccf129a01115027ee7438ac47f1bc35631a1b2bb.1253009868.git.szeder@ira.uka.de>
References: <e927e4d3bfe50d93e5e6d65c46821158332b37f9.1253009868.git.szeder@ira.uka.de>
	<0d125e60b97ab58ad51fef170fd36b707a271a10.1253009868.git.szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Sep 15 12:22:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnVB2-0004bX-Uf
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 12:22:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752728AbZIOKWS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Sep 2009 06:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752708AbZIOKWS
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 06:22:18 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:53067 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355AbZIOKWR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 06:22:17 -0400
Received: from [127.0.1.1] (p5B131467.dip0.t-ipconnect.de [91.19.20.103])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0MKt2u-1MnVAp3CSS-000G1t; Tue, 15 Sep 2009 12:22:12 +0200
X-Mailer: git-send-email 1.6.5.rc1.92.gee3c1
In-Reply-To: <0d125e60b97ab58ad51fef170fd36b707a271a10.1253009868.git.szeder@ira.uka.de>
In-Reply-To: <e927e4d3bfe50d93e5e6d65c46821158332b37f9.1253009868.git.szeder@ira.uka.de>
References: <e927e4d3bfe50d93e5e6d65c46821158332b37f9.1253009868.git.szeder@ira.uka.de>
X-Provags-ID: V01U2FsdGVkX1+T7FNFmF4xaLF8+jYBiJW2R63rpYUN0enzn3U
 cw3IBgC9Y4ts/IkY128gy4wJOGsBUMSLdh5h5XowoGpmsWDOvg
 uukUpi+3jeYSQ354+qkbA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128521>

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 2529cec..8c268a1 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1782,7 +1782,7 @@ _git_reset ()
 	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
 	case "$cur" in
 	--*)
-		__gitcomp "--merge --mixed --hard --soft"
+		__gitcomp "--merge --mixed --hard --soft --patch"
 		return
 		;;
 	esac
--=20
1.6.5.rc1.92.gee3c1
