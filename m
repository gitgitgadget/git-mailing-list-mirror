From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/1] Documentation/config.txt: Correct info about subsection name
Date: Wed, 24 Jan 2007 15:14:33 +0100
Message-ID: <11696480732656-git-send-email-jnareb@gmail.com>
References: <11694795473648-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 24 15:14:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9isy-0005bT-01
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 15:14:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546AbXAXON5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 09:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751551AbXAXON5
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 09:13:57 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:62659 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546AbXAXON4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 09:13:56 -0500
Received: by ug-out-1314.google.com with SMTP id 44so173908uga
        for <git@vger.kernel.org>; Wed, 24 Jan 2007 06:13:55 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=s6PRDzJdr/9i/R4YVfdmxrPaXsZiFsmdddDE/npcSulwMu+RZcPo60z+KGvF+Dd+lgzeKm6yIj6JaXv8eYfXFLA8PEFYXBscgBp5+Q5cUBqlxqMBO61kG3DV3Knt8nTN6if8YFkUmUGrDr2gE4hDPMiUkSzYV5SeyqTrox/GSys=
Received: by 10.67.119.9 with SMTP id w9mr1116179ugm.1169648034765;
        Wed, 24 Jan 2007 06:13:54 -0800 (PST)
Received: from roke.D-201 ( [81.190.20.200])
        by mx.google.com with ESMTP id x33sm909600ugc.2007.01.24.06.13.53;
        Wed, 24 Jan 2007 06:13:54 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l0OEEjbY012370;
	Wed, 24 Jan 2007 15:14:46 +0100
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l0OEEYDs012368;
	Wed, 24 Jan 2007 15:14:34 +0100
X-Mailer: git-send-email 1.4.4.4
In-Reply-To: <11694795473648-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37641>

Contrary to variable values, in subsection names parsing character
escape codes (besides literal escaping of " as \", and \ as \\)
is not performed; subsection name cannot contain newlines.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 Documentation/config.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 77a2b16..d8244b1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -37,8 +37,8 @@ in the section header, like in example below:
 
 --------
 
-Subsection names can contain any characters (doublequote '`"`', backslash
-'`\`' and newline have to be entered escaped as '`\"`', '`\\`' and '`\n`',
+Subsection names can contain any characters except newline (doublequote
+'`"`' and backslash have to be escaped as '`\"`' and '`\\`',
 respecitvely) and are case sensitive.  Section header cannot span multiple
 lines.  Variables may belong directly to a section or to a given subsection.
 You can have `[section]` if you have `[section "subsection"]`, but you
-- 
1.4.4.4
