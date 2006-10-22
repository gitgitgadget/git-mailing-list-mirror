From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [PATCH 1/2] ignore-errors requires cl
Date: Sun, 22 Oct 2006 20:46:31 +0200
Message-ID: <20061022184631.4093.50273.stgit@localhost>
References: <20061022184108.4093.65651.stgit@localhost>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: quoted-printable
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 20:46:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbiLD-00070C-JI
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 20:46:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWJVSqe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 14:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWJVSqe
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 14:46:34 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:36584 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S1750815AbWJVSqd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 14:46:33 -0400
Received: from ironport2.bredband.com ([195.54.107.84] [195.54.107.84])
          by mxfep02.bredband.com with ESMTP
          id <20061022184631.TOCX2091.mxfep02.bredband.com@ironport2.bredband.com>
          for <git@vger.kernel.org>; Sun, 22 Oct 2006 20:46:31 +0200
Received: from ua-83-227-180-148.cust.bredbandsbolaget.se (HELO yoghurt.hemma.treskal.com) ([83.227.180.148])
  by ironport2.bredband.com with ESMTP; 22 Oct 2006 20:46:31 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by yoghurt.hemma.treskal.com (Postfix) with ESMTP id 8921D4C010;
	Sun, 22 Oct 2006 20:46:31 +0200 (CEST)
To: Alexandre Julliard <julliard@winehq.org>
In-Reply-To: <20061022184108.4093.65651.stgit@localhost>
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29772>

From: Karl Hasselstr=C3=B6m <kha@yoghurt.hemma.treskal.com>

vc-git complains that it can't find the definition of ignore-errors
unless I (require 'cl). So I guess the correct place to do that is in
the file itself.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

 contrib/emacs/vc-git.el |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/contrib/emacs/vc-git.el b/contrib/emacs/vc-git.el
index 4189c4c..1ec228f 100644
--- a/contrib/emacs/vc-git.el
+++ b/contrib/emacs/vc-git.el
@@ -30,6 +30,8 @@
 ;;  - working with revisions other than HEAD
 ;;
=20
+(require 'cl)
+
 (defvar git-commits-coding-system 'utf-8
   "Default coding system for git commits.")
=20
