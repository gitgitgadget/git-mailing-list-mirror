From: Marc Branchaud <marcnarc@xiplink.com>
Subject: [PATCH v2] Provide some linguistic guidance for the documentation.
Date: Thu,  1 Aug 2013 11:10:25 -0400
Message-ID: <1375369825-28636-1-git-send-email-marcnarc@xiplink.com>
References: <1375197114-10742-1-git-send-email-marcnarc@xiplink.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Fredrik Gustafsson <iveqy@iveqy.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 01 17:10:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4uWF-0003fw-EE
	for gcvg-git-2@plane.gmane.org; Thu, 01 Aug 2013 17:10:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755405Ab3HAPKS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Aug 2013 11:10:18 -0400
Received: from 175-249-254-64.static.cogecodata.net ([64.254.249.175]:33217
	"EHLO cubert.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754889Ab3HAPKR (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Aug 2013 11:10:17 -0400
Received: from xiplink.com (rincewind.xiplink.com [10.10.1.32])
	by cubert.xiplink.com (Postfix) with ESMTP id E7FCB60051;
	Thu,  1 Aug 2013 11:10:14 -0400 (EDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1375197114-10742-1-git-send-email-marcnarc@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231488>

This will hopefully avoid questions over which spelling and grammar should
be used.  Translators are of course free to create localizations for other
specific English dialects.

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---

A little less stringent now.

 Documentation/CodingGuidelines  |  6 ++++++
 Documentation/SubmittingPatches | 10 ++++++++++
 2 files changed, 16 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 559d5f9..fc397f3 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -242,6 +242,12 @@ Writing Documentation:
  processed into HTML and manpages (e.g. git.html and git.1 in the
  same directory).
 
+ The documentation generally follows US English (en_US) norms for spelling
+ and grammar, although most spelling variations are tolerated.  Just avoid
+ mixing styles when updating existing text.  If you wish to correct the
+ English of some of the existing documentation, please see the documentation-
+ related advice in the Documentation/SubmittingPatches file.
+
  Every user-visible change should be reflected in the documentation.
  The same general rule as for code applies -- imitate the existing
  conventions.  A few commented examples follow to provide reference
diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index d0a4733..998e407 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -65,6 +65,16 @@ feature does not trigger when it shouldn't.  Also make sure that the
 test suite passes after your commit.  Do not forget to update the
 documentation to describe the updated behaviour.
 
+Speaking of the documentation, if you are attempting to correct typographical
+or grammatical errors use one patch for indisputably correct changes (e.g.
+"teh" -> "the") and put subjective/stylistic changes in a separate patch.
+This helps to streamline reviews of your patches.  Also, although the
+documentation is mainly written in US English, most non-US spelling variants
+are acceptable.  Patches that change one common spelling to another (such as
+changing "behaviour" to "behavior") are generally not helpful, as
+oftentimes a few months later some generous soul will want to change the
+spelling the other way.
+
 Oh, another thing.  I am picky about whitespaces.  Make sure your
 changes do not trigger errors with the sample pre-commit hook shipped
 in templates/hooks--pre-commit.  To help ensure this does not happen,
-- 
1.8.3.1
