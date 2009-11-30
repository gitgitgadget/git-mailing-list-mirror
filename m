From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH v2 6/6] INSTALL: document a simpler way to run uninstalled builds
Date: Sun, 29 Nov 2009 23:19:31 -0700
Message-ID: <1259561971-25730-7-git-send-email-mmogilvi_git@miniinfo.net>
References: <1259561971-25730-1-git-send-email-mmogilvi_git@miniinfo.net>
 <1259561971-25730-2-git-send-email-mmogilvi_git@miniinfo.net>
 <1259561971-25730-3-git-send-email-mmogilvi_git@miniinfo.net>
 <1259561971-25730-4-git-send-email-mmogilvi_git@miniinfo.net>
 <1259561971-25730-5-git-send-email-mmogilvi_git@miniinfo.net>
 <1259561971-25730-6-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Nov 30 07:28:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEzjx-0002dE-3o
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 07:28:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753251AbZK3G1j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 01:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753210AbZK3G1j
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 01:27:39 -0500
Received: from qmta14.emeryville.ca.mail.comcast.net ([76.96.27.212]:55524
	"EHLO QMTA14.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753191AbZK3G1j (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Nov 2009 01:27:39 -0500
Received: from OMTA17.emeryville.ca.mail.comcast.net ([76.96.30.73])
	by QMTA14.emeryville.ca.mail.comcast.net with comcast
	id BJLD1d0011afHeLAEJTmzf; Mon, 30 Nov 2009 06:27:46 +0000
Received: from mmogilvi.homeip.net ([24.8.125.243])
	by OMTA17.emeryville.ca.mail.comcast.net with comcast
	id BJTk1d0075FCJCg8dJTlR2; Mon, 30 Nov 2009 06:27:46 +0000
Received: from localhost.localdomain (bean [192.168.30.96])
	by mmogilvi.homeip.net (Postfix) with ESMTP id E095389114;
	Sun, 29 Nov 2009 23:20:04 -0700 (MST)
X-Mailer: git-send-email 1.6.4.GIT
In-Reply-To: <1259561971-25730-6-git-send-email-mmogilvi_git@miniinfo.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134055>

The new scripts automatically saved in the bin-wrappers
directory allow you test run a build when you have neither installed
git nor tweaked environment variables.  Mention this in INSTALL,
along with the slight performance issue of doing so.

This can be especially handy for manually testing
network-invoked git (from ssh, web servers, or similar), but
it is also handy with a plain command prompt.

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---
 INSTALL |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/INSTALL b/INSTALL
index be504c9..ee718c6 100644
--- a/INSTALL
+++ b/INSTALL
@@ -39,7 +39,19 @@ Issues of note:
    with --disable-transition option to avoid this.
 
  - You can use git after building but without installing if you
-   wanted to.  Various git commands need to find other git
+   want to.
+
+   The simplest option for running some manual tests of a build
+   before installing it is to use the wrapper scripts that are built
+   and saved into `pwd`/bin-wrappers.  Either invoke the scripts in
+   bin-wrappers using their full paths, put bin-wrappers in your
+   PATH, or copy/symlink just the bin-wrappers scripts into somewhere
+   already in your PATH.  But this option is slightly inefficient,
+   so for a more permanent solution we recommend either installing
+   git (you can set a prefix to install right next to your
+   build directory), or use the alternative below.
+
+   Alternatively, various git commands need to find other git
    commands and scripts to do their work, so you would need to
    arrange a few environment variables to tell them that their
    friends will be found in your built source area instead of at
-- 
1.6.4.GIT
