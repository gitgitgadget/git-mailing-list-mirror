From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 4/4] Documentation: replace: talk a little bit about
	GIT_NO_REPLACE_OBJECTS
Date: Sun, 22 Nov 2009 07:56:44 +0100
Message-ID: <20091122065645.4811.8117.chriscool@tuxfamily.org>
References: <20091122064652.4811.38993.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	bill lam <cbill.lam@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Paul Mackerras <paulus@samba.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 22 07:55:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NC6MU-0000Ul-SH
	for gcvg-git-2@lo.gmane.org; Sun, 22 Nov 2009 07:55:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053AbZKVGzh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Nov 2009 01:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbZKVGzh
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 01:55:37 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:38980 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751449AbZKVGzW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2009 01:55:22 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id A4B0D8180A4;
	Sun, 22 Nov 2009 07:55:20 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 6498A818039;
	Sun, 22 Nov 2009 07:55:17 +0100 (CET)
X-git-sha1: 948e657336c49e8b7472c139431e6def5a706079 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20091122064652.4811.38993.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133425>

It may be useful to know that this environment variable can be used
to prevent commands from using replacement refs.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-replace.txt |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
index 69f704f..65a0da5 100644
--- a/Documentation/git-replace.txt
+++ b/Documentation/git-replace.txt
@@ -44,6 +44,9 @@ $ git cat-file commit foo
 
 shows information about commit 'bar'.
 
+The 'GIT_NO_REPLACE_OBJECTS' environment variable can be set to
+achieve the same effect as the `--no-replace-objects` option.
+
 OPTIONS
 -------
 -f::
-- 
1.6.5.1.gaf97d
