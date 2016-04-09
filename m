From: Antonin <antonin@delpeuch.eu>
Subject: [PATCH] Fixed grammar mistake in the french localization
Date: Sat, 9 Apr 2016 06:38:33 +0000
Message-ID: <01020153f9be55b1-84948015-9e20-43da-9f9b-d2658d744c64-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 09 08:38:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aomXc-0006dw-OT
	for gcvg-git-2@plane.gmane.org; Sat, 09 Apr 2016 08:38:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752834AbcDIGih convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Apr 2016 02:38:37 -0400
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:46481
	"EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752613AbcDIGig convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Apr 2016 02:38:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1460183913;
	h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=TLMz4ZXXqXb5PvP1XyiSciO3rGvN5vmj7ThLhQCSSyw=;
	b=cNigbfBGxS3f0NZkv4ulBUkV3+7UueeWF3PjCy4gqS0qRx+3nnRB1LEXHXUBZUtA
	SpBAwq4htfDWTuS22iWHSrm/HKePRA4CWwrMUA9AX+NSYWHY58n5JGE22+46pJcqfqV
	xiOvKMuZ8m/JUQ4fD+ZLJcc+JIcFVPMnlukGfObg=
X-SES-Outgoing: 2016.04.09-54.240.7.12
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291084>

"tous le d=C3=A9p=C3=B4ts distants" -> "tous les d=C3=A9p=C3=B4ts dista=
nts"
---
 po/fr.po | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/po/fr.po b/po/fr.po
index 88b0b8a7..36c7c99 100644
--- a/po/fr.po
+++ b/po/fr.po
@@ -6135,7 +6135,7 @@ msgstr "git fetch --all [<options>]"
=20
 #: builtin/fetch.c:92 builtin/pull.c:166
 msgid "fetch from all remotes"
-msgstr "r=C3=A9cup=C3=A9rer depuis tous le d=C3=A9p=C3=B4ts distants"
+msgstr "r=C3=A9cup=C3=A9rer depuis tous les d=C3=A9p=C3=B4ts distants"
=20
 #: builtin/fetch.c:94 builtin/pull.c:169
 msgid "append to .git/FETCH_HEAD instead of overwriting"

--
https://github.com/git/git/pull/221
