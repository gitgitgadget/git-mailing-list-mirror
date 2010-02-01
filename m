From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH 2/2] configure: Allow --without-python
Date: Sun, 31 Jan 2010 21:15:05 -0500
Message-ID: <1264990505-29578-3-git-send-email-bwalton@artsci.utoronto.ca>
References: <1264990505-29578-1-git-send-email-bwalton@artsci.utoronto.ca>
 <1264990505-29578-2-git-send-email-bwalton@artsci.utoronto.ca>
Cc: Ben Walton <bwalton@artsci.utoronto.ca>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Feb 01 03:15:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nblp4-00005P-1F
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 03:15:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754220Ab0BACPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2010 21:15:14 -0500
Received: from www.cquest.utoronto.ca ([192.82.128.5]:44664 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752602Ab0BACPM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2010 21:15:12 -0500
Received: from ntdws12.chass.utoronto.ca ([128.100.160.253]:48752 ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1Nblok-0003Yq-UM; Sun, 31 Jan 2010 21:15:10 -0500
Received: from localhost
	([127.0.0.1] helo=ntdws12.chass.utoronto.ca ident=505)
	by ntdws12.chass.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1Nblok-0007hv-Rm; Sun, 31 Jan 2010 21:15:10 -0500
Received: (from bwalton@localhost)
	by ntdws12.chass.utoronto.ca (8.13.8/8.13.8/Submit) id o112FAew029627;
	Sun, 31 Jan 2010 21:15:10 -0500
X-Mailer: git-send-email 1.6.6
In-Reply-To: <1264990505-29578-2-git-send-email-bwalton@artsci.utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138575>

This patch allows someone to use configure to build git while at the
same time disabling the python remote helper code.  It leverages the
ability of GIT_ARG_SET_PATH to accept an optional second argument
indicating that --without-$PROGRAM is acceptable.

Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
---
 configure.ac |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/configure.ac b/configure.ac
index 9eaae7d..914ae57 100644
--- a/configure.ac
+++ b/configure.ac
@@ -288,7 +288,7 @@ GIT_ARG_SET_PATH(shell)
 GIT_ARG_SET_PATH(perl)
 #
 # Define PYTHON_PATH to provide path to Python.
-GIT_ARG_SET_PATH(python)
+GIT_ARG_SET_PATH(python, allow-without)
 #
 # Define ZLIB_PATH to provide path to zlib.
 GIT_ARG_SET_PATH(zlib)
-- 
1.6.5.3
