From: Tom Russello <tom.russello@grenoble-inp.org>
Subject: [PATCH v4 1/3] doc: clearer rule about formatting literals
Date: Wed,  8 Jun 2016 00:35:05 +0200
Message-ID: <20160607223507.18061-2-tom.russello@grenoble-inp.org>
References: <20160606100905.23006-1-tom.russello@grenoble-inp.org>
 <20160607223507.18061-1-tom.russello@grenoble-inp.org>
Cc: erwan.mathoniere@grenoble-inp.org, matthieu.moy@grenoble-inp.fr,
	jordan.de-gea@grenoble-inp.org, samuel.groot@grenoble-inp.org,
	gitster@pobox.com, Tom Russello <tom.russello@grenoble-inp.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 00:38:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAPbJ-0003jB-EU
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 00:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423399AbcFGWfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 18:35:36 -0400
Received: from zm-smtpout-1.grenet.fr ([130.190.244.97]:33438 "EHLO
	zm-smtpout-1.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423396AbcFGWff (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 18:35:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id E7D20256B;
	Wed,  8 Jun 2016 00:35:32 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0SFDp5SgTz_w; Wed,  8 Jun 2016 00:35:32 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id D67E024F3;
	Wed,  8 Jun 2016 00:35:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id D40C02066;
	Wed,  8 Jun 2016 00:35:32 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZoDXAbiSf8Bk; Wed,  8 Jun 2016 00:35:32 +0200 (CEST)
Received: from ux-305.numericable.fr (1.23.6.84.rev.sfr.net [84.6.23.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 976F12064;
	Wed,  8 Jun 2016 00:35:32 +0200 (CEST)
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20160607223507.18061-1-tom.russello@grenoble-inp.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296742>

Make the guideline text that we want for our documentation clearer.

Signed-off-by: Tom Russello <tom.russello@grenoble-inp.org>
Signed-off-by: Erwan Mathoniere <erwan.mathoniere@grenoble-inp.org>
Signed-off-by: Samuel Groot <samuel.groot@grenoble-inp.org>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
Changes since v3:
	- Add the rule of when environment variables must be prefixed with "$"

 Documentation/CodingGuidelines | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 0ddd368..7f4769a 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -526,12 +526,19 @@ Writing Documentation:
  modifying paragraphs or option/command explanations that contain options
  or commands:
 
- Literal examples (e.g. use of command-line options, command names, and
- configuration variables) are typeset in monospace, and if you can use
- `backticks around word phrases`, do so.
+ Literal examples (e.g. use of command-line options, command names,
+ configuration and environment variables) must be typeset in monospace (i.e.
+ wrapped with backticks):
    `--pretty=oneline`
    `git rev-list`
    `remote.pushDefault`
+   `GIT_DIR`
+
+ An environment variable must be prefixed with "$" only when referring to its
+ value and not when referring to the variable itself, in this case there is
+ nothing to add except the backticks:
+   `GIT_DIR` is specified
+   `$GIT_DIR/hooks/pre-receive`
 
  Word phrases enclosed in `backtick characters` are rendered literally
  and will not be further expanded. The use of `backticks` to achieve the
-- 
2.8.3
