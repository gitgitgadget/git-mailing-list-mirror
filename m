From: David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [StGit PATCH 10/17] Emacs mode: Bind n and p
Date: Fri, 14 Dec 2007 11:58:28 +0100
Message-ID: <20071214105817.18066.55619.stgit@krank>
References: <20071214105238.18066.23281.stgit@krank>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: catalin.marinas@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 14 11:59:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J38Fp-0001Hm-EA
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 11:58:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764152AbXLNK6N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 05:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763217AbXLNK6N
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 05:58:13 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:51838 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761604AbXLNK6L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 05:58:11 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 73AB5200A238;
	Fri, 14 Dec 2007 11:58:10 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 30527-01-29; Fri, 14 Dec 2007 11:58:10 +0100 (CET)
Received: from krank (vtab.com [62.20.90.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 32051200A1E8;
	Fri, 14 Dec 2007 11:58:10 +0100 (CET)
Received: from [127.0.1.1] (localhost [127.0.0.1])
	by krank (Postfix) with ESMTP id 9B20A7B406D;
	Fri, 14 Dec 2007 11:58:28 +0100 (CET)
In-Reply-To: <20071214105238.18066.23281.stgit@krank>
User-Agent: StGIT/0.13
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68286>


Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---

 contrib/stgit.el |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)


diff --git a/contrib/stgit.el b/contrib/stgit.el
index 82f0d38..2d18061 100644
--- a/contrib/stgit.el
+++ b/contrib/stgit.el
@@ -85,6 +85,8 @@ Argument DIR is the repository path."
   (suppress-keymap stgit-mode-map)
   (define-key stgit-mode-map "?"   'stgit-help)
   (define-key stgit-mode-map "h"   'stgit-help)
+  (define-key stgit-mode-map "p"   'previous-line)
+  (define-key stgit-mode-map "n"   'next-line)
   (define-key stgit-mode-map "g"   'stgit-refresh)
   (define-key stgit-mode-map "r"   'stgit-rename)
   (define-key stgit-mode-map ">"   'stgit-push-next)
