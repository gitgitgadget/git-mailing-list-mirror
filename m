From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH 1/3] git-gui: fix usage of _gitworktree when creating
	shortcut for windows
Date: Sat, 27 Feb 2010 21:45:51 +0100
Message-ID: <20100227204549.GB33000@book.hvoigt.net>
References: <20100223224955.GB11271@book.hvoigt.net> <cb7bb73a1002231454j4720b28ei20c10de37e929fde@mail.gmail.com> <20100223230238.GD11271@book.hvoigt.net> <cb7bb73a1002242353h739786bdlb2c57df3438f5b7f@mail.gmail.com> <20100227204108.GA33000@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: msysGit Mailinglist <msysgit@googlegroups.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 21:46:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlTXz-0007Q6-Do
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 21:45:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030830Ab0B0Upy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2010 15:45:54 -0500
Received: from darksea.de ([83.133.111.250]:48462 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030770Ab0B0Upy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2010 15:45:54 -0500
Received: (qmail 2124 invoked from network); 27 Feb 2010 21:45:51 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 27 Feb 2010 21:45:51 +0100
Content-Disposition: inline
In-Reply-To: <20100227204108.GA33000@book.hvoigt.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141222>

Signed-off-by: Heiko Voigt <heiko.voigt@mahr.de>
---
 git-gui/lib/shortcut.tcl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-gui/lib/shortcut.tcl b/git-gui/lib/shortcut.tcl
index 79c1888..78878ef 100644
--- a/git-gui/lib/shortcut.tcl
+++ b/git-gui/lib/shortcut.tcl
@@ -16,7 +16,7 @@ proc do_windows_shortcut {} {
 					[info nameofexecutable] \
 					[file normalize $::argv0] \
 					] \
-					[file normalize [$_gitworktree]]
+					[file normalize $_gitworktree]
 			} err]} {
 			error_popup [strcat [mc "Cannot write shortcut:"] "\n\n$err"]
 		}
@@ -57,7 +57,7 @@ proc do_cygwin_shortcut {} {
 					$sh -c \
 					"CHERE_INVOKING=1 source /etc/profile;[sq $me] &" \
 					] \
-					[file normalize [$_gitworktree]]
+					[file normalize $_gitworktree]
 			} err]} {
 			error_popup [strcat [mc "Cannot write shortcut:"] "\n\n$err"]
 		}
-- 
1.7.0.m5.rc3.5.g38df2
