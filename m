From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: [PATCH 1/2] completion: unite --reuse-message and --reedit-message
	for 'notes'
Date: Sat, 8 Oct 2011 03:06:34 +0200
Message-ID: <20111008010634.GB11561@goldbirke>
References: <1317926431-609-1-git-send-email-teemu.matilainen@iki.fi>
	<7vd3e9yap7.fsf@alter.siamese.dyndns.org>
	<20111008010432.GA11561@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Teemu Matilainen <teemu.matilainen@iki.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Oct 08 03:10:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCLQj-00021H-RE
	for gcvg-git-2@lo.gmane.org; Sat, 08 Oct 2011 03:10:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752108Ab1JHBGh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Oct 2011 21:06:37 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:60670 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856Ab1JHBGg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 21:06:36 -0400
Received: from localhost6.localdomain6 (p5B131159.dip0.t-ipconnect.de [91.19.17.89])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0LtBsd-1R0QOg43CN-012DrB; Sat, 08 Oct 2011 03:06:34 +0200
Content-Disposition: inline
In-Reply-To: <20111008010432.GA11561@goldbirke>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:4aqugQz1QGm0FqsHOTA5e5l/jwb3S81YxhuCYtHHwAk
 tYLG4IhqsmuayJ/rJnOT9EnQhC+gNuyMP8oFcKckw5en/17tZu
 MgtFRoDnLWFGtIINdL/NUejsP+0nQMaDHka7TrlolQ42t2o75g
 6j81205j5quYTkNKoGpAQjJyftNUJs05c8A4+C7Alt2SeQnMRQ
 /kAcfyYFmlAR4dHb3+5c7PDJj7bF5umzO+ZcRHAB7uUDXNMzzz
 8H9HhePjybWD7JN4jitixNW2SiRMjtH0Te/Ko2+tlB9biYs6m8
 SPRlgksl+srGWPZU2N/9bcKdY8kcXnDrkwyFakB1RhhwbNB0h3
 s0HilX/NETLRNrm4PsIA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183131>

Signed-off-by: SZEDER G=E1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 847e6e9a..98282435 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1668,11 +1668,9 @@ _git_notes ()
 			;;
 		esac
 		;;
-	add,--reuse-message=3D*|append,--reuse-message=3D*)
-		__gitcomp "$(__git_refs)" "" "${cur##--reuse-message=3D}"
-		;;
+	add,--reuse-message=3D*|append,--reuse-message=3D*|\
 	add,--reedit-message=3D*|append,--reedit-message=3D*)
-		__gitcomp "$(__git_refs)" "" "${cur##--reedit-message=3D}"
+		__gitcomp "$(__git_refs)" "" "${cur#*=3D}"
 		;;
 	add,--*|append,--*)
 		__gitcomp '--file=3D --message=3D --reedit-message=3D
--=20
1.7.7.187.ga41de
