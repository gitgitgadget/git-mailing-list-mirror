From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 1/2] bash: fix misindented esac statement in
	__git_complete_file()
Date: Thu, 10 Mar 2011 19:12:28 +0100
Message-ID: <1299780749-12435-1-git-send-email-szeder@ira.uka.de>
References: <7vfwrd2wbn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 19:13:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxkME-0004ho-8Y
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 19:13:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753916Ab1CJSM6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Mar 2011 13:12:58 -0500
Received: from ex-e-1.perimeter.fzi.de ([141.21.8.250]:40357 "EHLO
	EX-E-1.perimeter.fzi.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625Ab1CJSM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 13:12:56 -0500
Received: from ex-ca-ht-1.fzi.de (141.21.32.98) by EX-E-1.perimeter.fzi.de
 (141.21.8.250) with Microsoft SMTP Server (TLS) id 14.1.270.1; Thu, 10 Mar
 2011 19:12:48 +0100
Received: from localhost6.localdomain6 (141.21.7.126) by ex-ca-ht-1.fzi.de
 (141.21.32.98) with Microsoft SMTP Server (TLS) id 14.1.270.1; Thu, 10 Mar
 2011 19:12:52 +0100
X-Mailer: git-send-email 1.7.4.1.237.g62e25
In-Reply-To: <7vfwrd2wbn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168839>

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 893b771..344a47f 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -680,7 +680,7 @@ __git_complete_file ()
 		*)
 			ls=3D"$ref"
 			;;
-	    esac
+		esac
=20
 		case "$COMP_WORDBREAKS" in
 		*:*) : great ;;
--=20
1.7.4.1.237.g62e25
