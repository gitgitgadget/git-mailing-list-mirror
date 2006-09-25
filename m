From: Jeff King <peff@peff.net>
Subject: [PATCH/RESEND] git-repack: allow git-repack to run in subdirectory
Date: Sun, 24 Sep 2006 22:31:11 -0400
Message-ID: <20060925023111.GA14003@coredump.intra.peff.net>
References: <fcaeb9bf0609220221w3a65af24u9db1da4e1be0d1eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 25 04:31:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRgFZ-0002Wl-Sv
	for gcvg-git@gmane.org; Mon, 25 Sep 2006 04:31:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030183AbWIYCbO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 22:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030184AbWIYCbO
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 22:31:14 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:16591 "HELO
	peff.net") by vger.kernel.org with SMTP id S1030183AbWIYCbO (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Sep 2006 22:31:14 -0400
Received: (qmail 20369 invoked from network); 24 Sep 2006 22:31:11 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 24 Sep 2006 22:31:11 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 24 Sep 2006 22:31:11 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <fcaeb9bf0609220221w3a65af24u9db1da4e1be0d1eb@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27721>

Now that we explicitly create all tmpfiles below $GIT_DIR, there's no reason
to care about which directory we're in.

Signed-off-by: Jeff King <peff@peff.net>
---
There was no response on this; is there any reason not to allow this, or
did it just get dropped?

 git-repack.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-repack.sh b/git-repack.sh
index 9ae5092..f2c9071 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -4,6 +4,7 @@ # Copyright (c) 2005 Linus Torvalds
 #
 
 USAGE='[-a] [-d] [-f] [-l] [-n] [-q]'
+SUBDIRECTORY_OK='Yes'
 . git-sh-setup
 
 no_update_info= all_into_one= remove_redundant=
-- 
1.4.2.1.gb6052-dirty
