From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] Documentation: update tar.umask default
Date: Tue, 21 Aug 2007 20:01:16 +0200
Message-ID: <46CB286C.8000403@lsrfire.ath.cx>
References: <20070820164411.GA15637@piper.oerlikon.madduck.net> <20070820174142.GA7943@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Mike Hommey <mh@glandium.org>,
	git discussion list <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Aug 21 20:01:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INY2b-0006Qz-1Q
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 20:01:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760513AbXHUSBU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Aug 2007 14:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761362AbXHUSBU
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 14:01:20 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:46398
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760150AbXHUSBT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Aug 2007 14:01:19 -0400
Received: from [10.0.1.201] (p508EBE32.dip.t-dialin.net [80.142.190.50])
	by neapel230.server4you.de (Postfix) with ESMTP id 50D068B009;
	Tue, 21 Aug 2007 20:01:18 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20070820174142.GA7943@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56318>

As noted by Mike Hommey, the documentation for the config setting tar.umask
is not up-to-date.  Commit f08b3b0e2e9ad87767d80ff03b013c686e08ba4b changed
the default from 0 to 2; this patch finally documents it.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 4da07c1..9984a11 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -80,8 +80,8 @@ in the repository configuration as follows :
         umask = 002	;# group friendly
 
 The special umask value "user" indicates that the user's current umask
-will be used instead. The default value remains 0, which means world
-readable/writable files and directories.
+will be used instead.  The default is 002, which allows reading for all
+and writing for both owner and group.
 
 EXAMPLES
 --------
