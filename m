From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [PATCH 2/2] Better installation instructions
Date: Sun, 22 Oct 2006 20:46:36 +0200
Message-ID: <20061022184636.4093.12373.stgit@localhost>
References: <20061022184108.4093.65651.stgit@localhost>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: quoted-printable
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 20:46:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbiLK-000726-6k
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 20:46:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWJVSqj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 14:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWJVSqj
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 14:46:39 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:7145 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S1750817AbWJVSqi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 14:46:38 -0400
Received: from ironport2.bredband.com ([195.54.107.84] [195.54.107.84])
          by mxfep02.bredband.com with ESMTP
          id <20061022184637.TODQ2091.mxfep02.bredband.com@ironport2.bredband.com>
          for <git@vger.kernel.org>; Sun, 22 Oct 2006 20:46:37 +0200
Received: from ua-83-227-180-148.cust.bredbandsbolaget.se (HELO yoghurt.hemma.treskal.com) ([83.227.180.148])
  by ironport2.bredband.com with ESMTP; 22 Oct 2006 20:46:37 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by yoghurt.hemma.treskal.com (Postfix) with ESMTP id C4FA14C010;
	Sun, 22 Oct 2006 20:46:36 +0200 (CEST)
To: Alexandre Julliard <julliard@winehq.org>
In-Reply-To: <20061022184108.4093.65651.stgit@localhost>
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29773>

From: Karl Hasselstr=C3=B6m <kha@yoghurt.hemma.treskal.com>

Provide some more detailed installation instructions, for the
elisp-challenged among us.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

 contrib/emacs/vc-git.el |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/contrib/emacs/vc-git.el b/contrib/emacs/vc-git.el
index 1ec228f..535ce97 100644
--- a/contrib/emacs/vc-git.el
+++ b/contrib/emacs/vc-git.el
@@ -23,7 +23,10 @@
 ;; system.
 ;;
 ;; To install: put this file on the load-path and add GIT to the list
-;; of supported backends in `vc-handled-backends'.
+;; of supported backends in `vc-handled-backends'; the following line,
+;; placed in your ~/.emacs, will accomplish this:
+;;
+;;     (add-to-list 'vc-handled-backends 'GIT)
 ;;
 ;; TODO
 ;;  - changelog generation
