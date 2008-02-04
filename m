From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] Documentation/SubmittingPatches: Instruct how to use [PATCH] Subject header
Date: Mon, 04 Feb 2008 02:24:10 +0200
Organization: Private
Message-ID: <r6ft1sd1.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 04 01:25:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLp9p-0005H4-1a
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 01:25:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754022AbYBDAZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 19:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754018AbYBDAZE
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 19:25:04 -0500
Received: from main.gmane.org ([80.91.229.2]:44503 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753942AbYBDAZB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 19:25:01 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JLp8n-0003Kx-TU
	for git@vger.kernel.org; Mon, 04 Feb 2008 00:24:53 +0000
Received: from a91-155-178-181.elisa-laajakaista.fi ([91.155.178.181])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 04 Feb 2008 00:24:53 +0000
Received: from jari.aalto by a91-155-178-181.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 04 Feb 2008 00:24:53 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-178-181.elisa-laajakaista.fi
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.1 (windows-nt)
Cancel-Lock: sha1:XtI/P9lHPGu5xZnAZ+9i8NaJaG0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72432>

Suggest putting additional message inside brackets, like [PATCH v2]
for reworked content.

Signed-off-by: Jari Aalto <jari.aalto AT cante.net>
---
 Idea by Jakub Narebski

 Documentation/SubmittingPatches |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index de08d09..69ecbd3 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -37,6 +37,9 @@ Checklist (and a short version for the impatient):
 	  maintainer (gitster@pobox.com). If you use
 	  git-send-email(1), please test it first by sending
 	  email to yourself.
+        - If you rework the patch, announce the message
+          in brackets. For example "[PATCH/RFC]", "[PATCH (resend)]",
+          "[PATCH v2]" etc.
 
 Long version:
 
-- 
1.5.4-rc5.GIT-dirty



-- 
Welcome to FOSS revolution: we fix and modify until it shines
