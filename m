From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 1/2] Emacs mode: change "stg repair" binding
Date: Mon, 11 Feb 2008 23:25:29 +0100
Message-ID: <20080211222518.15978.22325.stgit@yoghurt>
References: <87tzkfssxv.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 23:26:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOh6R-0007gT-0Q
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 23:26:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756934AbYBKWZm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Feb 2008 17:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756861AbYBKWZm
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 17:25:42 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4401 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753230AbYBKWZl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 17:25:41 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JOh5f-0001dF-00; Mon, 11 Feb 2008 22:25:31 +0000
In-Reply-To: <87tzkfssxv.fsf@lysator.liu.se>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73597>

It used to be C-r, but that's commonly used for reverse searching, so
use R instead.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 contrib/stgit.el |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/contrib/stgit.el b/contrib/stgit.el
index e8bbb2c..aa54772 100644
--- a/contrib/stgit.el
+++ b/contrib/stgit.el
@@ -143,7 +143,7 @@ Argument DIR is the repository path."
   (define-key stgit-mode-map "e"   'stgit-edit)
   (define-key stgit-mode-map "c"   'stgit-coalesce)
   (define-key stgit-mode-map "N"   'stgit-new)
-  (define-key stgit-mode-map "\C-r"   'stgit-repair)
+  (define-key stgit-mode-map "R"   'stgit-repair)
   (define-key stgit-mode-map "C"   'stgit-commit)
   (define-key stgit-mode-map "U"   'stgit-uncommit)
   (define-key stgit-mode-map ">"   'stgit-push-next)
