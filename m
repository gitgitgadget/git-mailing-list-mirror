From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 2/4] Document the .git-file
Date: Mon,  4 Feb 2008 21:59:19 +0100
Message-ID: <1202158761-31211-3-git-send-email-hjemli@gmail.com>
References: <1202158761-31211-1-git-send-email-hjemli@gmail.com>
 <1202158761-31211-2-git-send-email-hjemli@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 22:02:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM8S3-0008Ne-2L
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 22:02:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752755AbYBDVBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 16:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752750AbYBDVBR
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 16:01:17 -0500
Received: from mail42.e.nsc.no ([193.213.115.42]:46925 "EHLO mail42.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752735AbYBDVBQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 16:01:16 -0500
Received: from localhost.localdomain (ti231210a341-0149.bb.online.no [88.88.168.149])
	by mail42.nsc.no (8.13.8/8.13.5) with ESMTP id m14L0REe021902;
	Mon, 4 Feb 2008 22:00:30 +0100 (MET)
X-Mailer: git-send-email 1.5.4.5.g25d066
In-Reply-To: <1202158761-31211-2-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72568>

---
 Documentation/repository-layout.txt |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/Documentation/repository-layout.txt b/Documentation/repository-layout.txt
index 6939130..e9db3a1 100644
--- a/Documentation/repository-layout.txt
+++ b/Documentation/repository-layout.txt
@@ -3,7 +3,10 @@ git repository layout
 
 You may find these things in your git repository (`.git`
 directory for a repository associated with your working tree, or
-`'project'.git` directory for a public 'bare' repository).
+`'project'.git` directory for a public 'bare' repository. It is
+also possible to have a working tree where `.git` is a plain
+ascii file containing `gitdir: <path>\n`, i.e. the path to the
+real git repository).
 
 objects::
 	Object store associated with this repository.  Usually
-- 
1.5.4.5.g25d066
