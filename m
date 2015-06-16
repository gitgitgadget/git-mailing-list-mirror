From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] Documentation/describe: improve one-line summary
Date: Tue, 16 Jun 2015 15:16:38 +0200
Message-ID: <1434460598-23201-1-git-send-email-Matthieu.Moy@imag.fr>
References: <CAKEGsXTY_rstoK4Gcga6XqkqKCeOkXdL-TjAWUu0Cqi6mWW7bA@mail.gmail.com>
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com, albertnetymk@gmail.com
X-From: git-owner@vger.kernel.org Tue Jun 16 15:16:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4qjX-0005UH-2X
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 15:16:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754173AbbFPNQv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 09:16:51 -0400
Received: from mx1.imag.fr ([129.88.30.5]:53784 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752384AbbFPNQu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 09:16:50 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5GDGfI5030091
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 16 Jun 2015 15:16:41 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5GDGgrC013088;
	Tue, 16 Jun 2015 15:16:42 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Z4qjK-0006i7-MC; Tue, 16 Jun 2015 15:16:42 +0200
X-Mailer: git-send-email 2.4.1.171.g060e6ae.dirty
In-Reply-To: <CAKEGsXTY_rstoK4Gcga6XqkqKCeOkXdL-TjAWUu0Cqi6mWW7bA@mail.gmail.com>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 16 Jun 2015 15:16:42 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5GDGfI5030091
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1435065403.87663@HTzah40BrPDzq1H8B7v4SQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271751>

git describe does not show 'the most recent tag that is reachable from a
commit', but a descriptive name based on this tag. Fix the description to
reflect that.

Suggested-by: Albert Netymk <albertnetymk@gmail.com>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
> According to the man of git-describe, http://git-scm.com/docs/git-describe
> 
> git-describe - Show the most recent tag that is reachable from a commit
> 
> It means that this command shows the name of the most recent tag.
> 
> However, actually, it construct a new tag name if the current commit
> is not tagged.
> 
> I think, "git-describe - Describe a commit using the most recent tag
> reachable from it" is a better summary.

Indeed. Here's a patch fixing this.

 Documentation/git-describe.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index d20ca40..e045fc7 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -3,7 +3,7 @@ git-describe(1)
 
 NAME
 ----
-git-describe - Show the most recent tag that is reachable from a commit
+git-describe - Describe a commit using the most recent tag reachable from it
 
 
 SYNOPSIS
-- 
2.4.1.171.g060e6ae.dirty
