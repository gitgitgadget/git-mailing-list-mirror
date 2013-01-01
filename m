From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] SubmittingPatches: mention subsystems with dedicated
 repositories
Date: Tue,  1 Jan 2013 15:24:54 -0800
Message-ID: <1357082695-29713-3-git-send-email-gitster@pobox.com>
References: <1357082695-29713-1-git-send-email-gitster@pobox.com>
Cc: Jason Holden <jason.k.holden.swdev@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 02 00:25:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqBD4-0001ZC-9r
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 00:25:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752270Ab3AAXZF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 18:25:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63667 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751679Ab3AAXZC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 18:25:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C0F21A4FB;
	Tue,  1 Jan 2013 18:25:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=t6p9
	to1bCgIbOrauIlwuiMf+4Qw=; b=AI7pC3bbYp+f0FybDLuyIx3SVj4u9MzOv59o
	MuGG/FChom/SMzQlT5EdUmr3XuT5WTGLYR07x6pXazs25ApT6LzkufYKkX1IjhmU
	Yn4sK/j3ctrUL0f/Z0FoEAlO5YY250abPKrBrB/FhBSB9BRXohTZ5Nw7jq1hjWdS
	fyynpeM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	NfCAHQEdP9ifNUWmYUOuS9/D/TNtA52WTwGaStUeNLU5lrMRVWBb0zmTECPY2CN2
	wR3SebhuoBj2/MIFp2VeYgmqT/7pA+yQTsBFHPRQSRZ8Rqz5TAww9izbkGLvaTEM
	ir6Hs482KfNHeKaax0Hmo2u98z6wyoZel+cvnARE4P4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B09A0A4FA;
	Tue,  1 Jan 2013 18:25:01 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 17C0AA4F9; Tue,  1 Jan 2013
 18:25:00 -0500 (EST)
X-Mailer: git-send-email 1.8.1.209.gc32ab23
In-Reply-To: <1357082695-29713-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 76CE7B88-546A-11E2-BE8E-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212472>

These were only mentioned in periodical "A note from the maintainer"
posting and not in the documentation suite.  SubmittingPatches has a
section to help contributors decide on what commit to base their
changes, which is the most suitable place for this information.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/SubmittingPatches | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index b9fd182..e810263 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -88,6 +88,10 @@ change is relevant to.
    wait until some of the dependent topics graduate to 'master', and
    rebase your work.
 
+ - Some parts of the system have dedicated maintainers with their own
+   repositories (see the section "Subsystems" below).  Changes to
+   these parts should be based on their trees.
+
 To find the tip of a topic branch, run "git log --first-parent
 master..pu" and look for the merge commit. The second parent of this
 commit is the tip of the topic branch.
@@ -279,6 +283,26 @@ You can also create your own tag or use one that's in common usage
 such as "Thanks-to:", "Based-on-patch-by:", or "Mentored-by:".
 
 ------------------------------------------------
+Subsystems with dedicated maintainers
+
+Some parts of the system have dedicated maintainers with their own
+repositories.
+
+ - git-gui/ comes from git-gui project, maintained by Pat Thoyts:
+
+        git://repo.or.cz/git-gui.git
+
+ - gitk-git/ comes from Paul Mackerras's gitk project:
+
+        git://ozlabs.org/~paulus/gitk
+
+ - po/ comes from the localization coordinator, Jiang Xin:
+
+	https://github.com/git-l10n/git-po/
+
+Patches to these parts should be based on their trees.
+
+------------------------------------------------
 An ideal patch flow
 
 Here is an ideal patch flow for this project the current maintainer
-- 
1.8.1.209.gc32ab23
