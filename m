From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 07/16] git-cvsimport: make usage text consistent
Date: Sat, 23 Feb 2013 16:20:45 -0800
Message-ID: <1361665254-42866-8-git-send-email-davvid@gmail.com>
References: <1361665254-42866-1-git-send-email-davvid@gmail.com>
 <1361665254-42866-2-git-send-email-davvid@gmail.com>
 <1361665254-42866-3-git-send-email-davvid@gmail.com>
 <1361665254-42866-4-git-send-email-davvid@gmail.com>
 <1361665254-42866-5-git-send-email-davvid@gmail.com>
 <1361665254-42866-6-git-send-email-davvid@gmail.com>
 <1361665254-42866-7-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 01:21:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9PLc-0000qC-Mj
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 01:21:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759359Ab3BXAVR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 19:21:17 -0500
Received: from mail-da0-f54.google.com ([209.85.210.54]:51207 "EHLO
	mail-da0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759351Ab3BXAVP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 19:21:15 -0500
Received: by mail-da0-f54.google.com with SMTP id p1so345176dad.27
        for <git@vger.kernel.org>; Sat, 23 Feb 2013 16:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=uOqBvdfz1jsmUA+C7Ia40dRN/MxkTxrSCi1Wv+kc330=;
        b=FjRX7zEgw2FiALam8xK/63s34QN6mxgaBzf9bIHvsWXdNDItjQwEdE+v9C7pgiF6gt
         W0ScADlmzHa30RvPHW9b1Y70Xf90Ec+9yqQpGYQPyGVg5w8+IpvQ+ZjFVwQ8lAbpbryi
         7MisA4NxsZ/JANTxTBpU8uFGaHuvAsF3Lkhy4Y2fYK5xg+iFrqQszfQTvvCI5KSxoaUq
         jYNn7bejP6EM1fCeGEbVLIyd6jO5TQnLYf3OPaPvYpeccjMmVqOdzPHIqupq3UMw+ybx
         aq1rOmCbSRC7uWDtbMAmH0ptp7GkThUbd7Ptvyz8LwIOgCD9lEYVllu3e4S8G/2PEqNe
         ONqg==
X-Received: by 10.66.232.33 with SMTP id tl1mr11809415pac.151.1361665274807;
        Sat, 23 Feb 2013 16:21:14 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id wm3sm7430622pbc.4.2013.02.23.16.21.12
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 23 Feb 2013 16:21:13 -0800 (PST)
X-Mailer: git-send-email 1.8.2.rc0.263.g20d9441
In-Reply-To: <1361665254-42866-7-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216943>

Use a lowercase "usage:" string for consistency with Git.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-cvsimport.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 344f120..73d367c 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -38,7 +38,7 @@ sub usage(;$) {
 	my $msg = shift;
 	print(STDERR "Error: $msg\n") if $msg;
 	print STDERR <<END;
-Usage: git cvsimport     # fetch/update GIT from CVS
+usage: git cvsimport     # fetch/update GIT from CVS
        [-o branch-for-HEAD] [-h] [-v] [-d CVSROOT] [-A author-conv-file]
        [-p opts-for-cvsps] [-P file] [-C GIT_repository] [-z fuzz] [-i] [-k]
        [-u] [-s subst] [-a] [-m] [-M regex] [-S regex] [-L commitlimit]
-- 
1.8.2.rc0.247.g811e0c0
