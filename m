From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: [PATCH v2] Documentation/config.txt: Add git-gui options
Date: Thu,  8 May 2008 10:55:02 +0200
Message-ID: <1210236902-8008-1-git-send-email-hendeby@isy.liu.se>
References: <20080507230948.GT29038@spearce.org>
Cc: git@vger.kernel.org, Gustaf Hendeby <hendeby@isy.liu.se>
To: spearce@spearce.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu May 08 10:56:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ju1v2-0007jZ-He
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 10:56:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753728AbYEHIzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 04:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753759AbYEHIzI
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 04:55:08 -0400
Received: from bogotron.isy.liu.se ([130.236.48.26]:61740 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753697AbYEHIzF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 04:55:05 -0400
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id C2C002598F;
	Thu,  8 May 2008 10:55:03 +0200 (MEST)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 26261-09; Thu,  8 May 2008 07:37:10 +0200 (MEST)
Received: from pluring.isy.liu.se (pluring.isy.liu.se [130.236.56.134])
	by bogotron.isy.liu.se (Postfix) with ESMTP id E30CB2593F;
	Thu,  8 May 2008 10:55:02 +0200 (MEST)
Received: by pluring.isy.liu.se (Postfix, from userid 2087)
	id D7B2D177A0; Thu,  8 May 2008 10:55:02 +0200 (CEST)
X-Mailer: git-send-email 1.5.5.1.273.g4b2d7
In-Reply-To: <20080507230948.GT29038@spearce.org>
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81519>

The 'git gui' has a number of options that can be specified using the
options dialog. Sometimes it is convenient to be able to specify these
from the command line, therefor document these options.

Signed-off-by: Gustaf Hendeby <hendeby@isy.liu.se>
Acked-by: Shawn O. Pearce <speace@spearce.org>
---

This patch differs from the previous one in two ways:

1. Since Shawn has fixed the problem with the spell checking already
(thanks!) and it will make its way into git soon, I removed the
comment about how gui.spellingdictionary="no can used to have git gui
start with older versions of aspell.  I think it just confuse people
if it doesn't apply any more.

2. Some of the language looked a bit strange when I read it through
this time, so I changed some wordings.  A pair of native English eyes
would probably not be a bad idea.

/Gustaf

 Documentation/config.txt |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 00f089f..c4d6ccd 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -684,6 +684,36 @@ specified as 'gitcvs.<access_method>.<varname>' (where 'access_method'
 is one of "ext" and "pserver") to make them apply only for the given
 access method.
 
+gui.commitmsgwidth::
+	Defines how wide the commit message window is in the
+	linkgit:git-gui[1]. "75" is the default.
+
+gui.diffcontext::
+	Specifies how many context lines should be used in calls to diff
+	made by the linkgit:git-gui[1]. The default is "5".
+
+gui.matchtrackingbranch::
+	Determines if new branches created with linkgit:git-gui[1] should
+	default to tracking remote branches with matching names or
+	not. Default: "false".
+
+gui.newbranchtemplate::
+	Is used as suggested name when creating new branches using the
+	linkgit:git-gui[1].
+
+gui.pruneduringfetch::
+	"true" if linkgit:git-gui[1] should prune tracking branches when
+	performing a fetch. The default value is "false".
+
+gui.trustmtime::
+	Determines if linkgit:git-gui[1] should trust the file modification
+	timestamp or not. By default the timestamps are not trusted.
+
+gui.spellingdictionary::
+	Specifies the dictionary used for spell checking commit messages in
+	the linkgit:git-gui[1]. When set to "none" spell checking is turned
+	off.
+
 help.browser::
 	Specify the browser that will be used to display help in the
 	'web' format. See linkgit:git-help[1].
-- 
1.5.5.1.273.g4b2d7
