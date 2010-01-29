From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH] git-gui: fix shortcut for menu "Commit/Revert Changes"
Date: Fri, 29 Jan 2010 16:57:48 +0100
Message-ID: <20100129155748.GA43189@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jan 29 16:59:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NatGI-0007al-Dl
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 16:59:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751828Ab0A2P5v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 10:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751630Ab0A2P5v
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 10:57:51 -0500
Received: from darksea.de ([83.133.111.250]:34893 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751246Ab0A2P5v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 10:57:51 -0500
Received: (qmail 7381 invoked from network); 29 Jan 2010 16:57:48 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 29 Jan 2010 16:57:48 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138328>

The shortcut was not properly recognized previously.

Signed-off-by: Heiko Voigt <heiko.voigt@mahr.de>
---
 git-gui.sh |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index debcc5f..7d54511 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -3550,6 +3550,8 @@ bind .   <$M1B-Key-s> do_signoff
 bind .   <$M1B-Key-S> do_signoff
 bind .   <$M1B-Key-t> do_add_selection
 bind .   <$M1B-Key-T> do_add_selection
+bind .   <$M1B-Key-j> do_revert_selection
+bind .   <$M1B-Key-J> do_revert_selection
 bind .   <$M1B-Key-i> do_add_all
 bind .   <$M1B-Key-I> do_add_all
 bind .   <$M1B-Key-minus> {show_less_context;break}
-- 
1.7.0.rc0.27.ge8d3a
