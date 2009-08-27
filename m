From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH jh/cvs-helper 1/2] Makefile: write NO_PYTHON setting to GIT-BUILD-OPTIONS file
Date: Thu, 27 Aug 2009 11:24:23 -0500
Message-ID: <Rxz2NOwzg1UZ0TgAtOhrA7dGx1obNszSQLoUJ4IoUGJk5ekFKeKU4vpg535nyOx20P_IWNiudJo@cipher.nrlssc.navy.mil>
References: <Rxz2NOwzg1UZ0TgAtOhrA7e8wE02XwcSzNC9cc1EL_W_oN1BjtZn8ClmG5zKB_DKmTgVP0PlMYI@cipher.nrlssc.navy.mil>
Cc: gitster@pobox.com, johan@herland.net,
	Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 27 18:25:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mghmg-0008JR-AB
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 18:25:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752919AbZH0QY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 12:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752890AbZH0QY5
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 12:24:57 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:53566 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752813AbZH0QY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 12:24:56 -0400
Received: by mail.nrlssc.navy.mil id n7RGOWhK011019; Thu, 27 Aug 2009 11:24:34 -0500
In-Reply-To: <Rxz2NOwzg1UZ0TgAtOhrA7e8wE02XwcSzNC9cc1EL_W_oN1BjtZn8ClmG5zKB_DKmTgVP0PlMYI@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 27 Aug 2009 16:24:33.0657 (UTC) FILETIME=[DC9C7690:01CA2732]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127174>

From: Brandon Casey <drafnel@gmail.com>

The GIT-BUILD-OPTIONS file is sourced by the t/test-lib.sh script which
prepares the environment for the test suite.  It is used to communicate
the user's settings for things like SHELL_PATH, TAR, NO_CURL, and NO_PERL.
Add NO_PYTHON so this setting will be available to the test suite.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 128c308..5c1ae7b 100644
--- a/Makefile
+++ b/Makefile
@@ -1615,6 +1615,7 @@ GIT-BUILD-OPTIONS: .FORCE-GIT-BUILD-OPTIONS
 	@echo TAR=\''$(subst ','\'',$(subst ','\'',$(TAR)))'\' >>$@
 	@echo NO_CURL=\''$(subst ','\'',$(subst ','\'',$(NO_CURL)))'\' >>$@
 	@echo NO_PERL=\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@
+	@echo NO_PYTHON=\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'\' >>$@
 
 ### Detect Tck/Tk interpreter path changes
 ifndef NO_TCLTK
-- 
1.6.4
