From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH v2] doc tweak for git-send-email
Date: Thu, 11 Jun 2009 09:30:27 +0200
Message-ID: <1244705427-3376-1-git-send-email-bonzini@gnu.org>
References: <4A30568E.7060503@gmail.com>
Cc: bebarino@gmail.com
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 11 09:30:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEekL-0007qh-VD
	for gcvg-git-2@gmane.org; Thu, 11 Jun 2009 09:30:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754809AbZFKHal (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2009 03:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754770AbZFKHak
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 03:30:40 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:52765 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754285AbZFKHaj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2009 03:30:39 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1MEekC-0004ek-GV; Thu, 11 Jun 2009 03:30:40 -0400
X-Mailer: git-send-email 1.6.0.3
In-Reply-To: <4A30568E.7060503@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121328>

The git-send-email docs do not mention except in the usage lines
the combined patch formatting/sending ability of git-send-email.
This patch expands on the possible arguments to git-send-email
and explains the meaning of the rev-list argument.

Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
---
 Documentation/git-send-email.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 794224b..a282190 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -14,6 +14,10 @@ SYNOPSIS
 DESCRIPTION
 -----------
 Takes the patches given on the command line and emails them out.
+Patches can be specified as files, directories (which will send all
+files in the directory), or directly as a revision list.  In the
+last case, any format accepted by linkgit:git-format-patch[1] can
+be passed to git send-email.
 
 The header of the email is configurable by command line options.  If not
 specified on the command line, the user will be prompted with a ReadLine
-- 
1.6.0.3
