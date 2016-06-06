From: Tom Russello <tom.russello@grenoble-inp.org>
Subject: [PATCH v3 1/3] doc: clearer rule about formatting literals
Date: Mon,  6 Jun 2016 12:09:03 +0200
Message-ID: <20160606100905.23006-2-tom.russello@grenoble-inp.org>
References: <20160603220837.9842-1-tom.russello@grenoble-inp.org>
 <20160606100905.23006-1-tom.russello@grenoble-inp.org>
Cc: gitster@pobox.com, erwan.mathoniere@grenoble-inp.org,
	samuel.groot@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	matthieu.moy@grenoble-inp.fr,
	Tom Russello <tom.russello@grenoble-inp.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 12:09:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9rTZ-0006eY-EQ
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 12:09:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbcFFKJa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 06:09:30 -0400
Received: from zm-smtpout-1.grenet.fr ([130.190.244.97]:50622 "EHLO
	zm-smtpout-1.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294AbcFFKJ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 06:09:28 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 6E841258D;
	Mon,  6 Jun 2016 12:09:26 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qIfo6AboqoRt; Mon,  6 Jun 2016 12:09:26 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 5F2FC2583;
	Mon,  6 Jun 2016 12:09:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 5B4D52066;
	Mon,  6 Jun 2016 12:09:26 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O0zGJAnhoh51; Mon,  6 Jun 2016 12:09:26 +0200 (CEST)
Received: from ux-305.grenet.fr (eduroam-033212.grenet.fr [130.190.33.212])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 40F112055;
	Mon,  6 Jun 2016 12:09:26 +0200 (CEST)
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20160606100905.23006-1-tom.russello@grenoble-inp.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296494>

Make the guideline text that we want for our documentation clearer.

Signed-off-by: Tom Russello <tom.russello@grenoble-inp.org>
Signed-off-by: Erwan Mathoniere <erwan.mathoniere@grenoble-inp.org>
Signed-off-by: Samuel Groot <samuel.groot@grenoble-inp.org>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
IMHO, the previous "rule" was not so clear on what we have to do and didn't give
a guideline to whether an environment variable has to be wrapped with backticks,
single-quotes or something else.

 Documentation/CodingGuidelines | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 0ddd368..c6f8188 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -526,12 +526,13 @@ Writing Documentation:
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
 
  Word phrases enclosed in `backtick characters` are rendered literally
  and will not be further expanded. The use of `backticks` to achieve the
-- 
2.8.3
