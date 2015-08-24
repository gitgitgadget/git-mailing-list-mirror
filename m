From: Brett Randall <javabrett@gmail.com>
Subject: [PATCH] Doc, git-svn, added mention of config key: svn-remote.<name>.include-paths
Date: Mon, 24 Aug 2015 10:23:45 +1000
Message-ID: <1440375825-2587-2-git-send-email-javabrett@gmail.com>
References: <1440375825-2587-1-git-send-email-javabrett@gmail.com>
Cc: javabrett@gmail.com
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 24 02:24:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTfYu-000866-NR
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 02:24:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753345AbbHXAYL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2015 20:24:11 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36748 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752500AbbHXAYF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2015 20:24:05 -0400
Received: by padfo6 with SMTP id fo6so3251602pad.3
        for <git@vger.kernel.org>; Sun, 23 Aug 2015 17:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LvHqGpSa+xJOJXxeCjp/f5uJbnPJf6HdBVYm/MKa1oM=;
        b=ClmQd6SvWs6vwTOiQFcowCUl47kHWC9+yANlpCPJi3G6KToTQDjtU1tiJQs8At3w9u
         JI7L9RIGqH+sjvzH1VbgO/DezLXdkFgvEL7tNcLx+XkyhKe4RBT10dEyxPS/6p7Rj5pI
         i6tdx3iY3KuPL4iIL1Vwm8eDDv5lo03uLg0eFreFH156ndTgAYXmUBy99noRdY+mr7sw
         GsmxZkQURrmLE3U+aS6XcGTrQVjdinHKm9actLoWEADQ/Jl4sszPvJgeglbcsBAjjINi
         FEkxmkUhHceHyk/EX9bH+Ds/rSX72lFS8CkC0F8WL5IF5HVTxQ/dGscjR7Fu5afhAW1n
         QNnA==
X-Received: by 10.68.168.161 with SMTP id zx1mr40414424pbb.35.1440375845324;
        Sun, 23 Aug 2015 17:24:05 -0700 (PDT)
Received: from bsrandal-t3600.iiNet (124-149-100-161.dyn.iinet.net.au. [124.149.100.161])
        by smtp.gmail.com with ESMTPSA id im2sm15100521pbc.34.2015.08.23.17.24.03
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 23 Aug 2015 17:24:04 -0700 (PDT)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1440375825-2587-1-git-send-email-javabrett@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276429>

Signed-off-by: Brett Randall <javabrett@gmail.com>
---
 Documentation/git-svn.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 11d1e2f..0c0f60b 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -174,6 +174,9 @@ Skip "branches" and "tags" of first level directories;;
 	(including automatic fetches due to 'clone', 'dcommit',
 	'rebase', etc) on a given repository. '--ignore-paths' takes
 	precedence over '--include-paths'.
++
+[verse]
+config key: svn-remote.<name>.include-paths
 
 --log-window-size=<n>;;
 	Fetch <n> log entries per request when scanning Subversion history.
-- 
2.5.0
