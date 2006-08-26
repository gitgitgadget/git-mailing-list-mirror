From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Fix typo in git_difftree_body
Date: Sat, 26 Aug 2006 23:33:58 +0200
Message-ID: <200608262333.59039.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Aug 26 23:34:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GH5n8-0006ds-47
	for gcvg-git@gmane.org; Sat, 26 Aug 2006 23:34:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbWHZVeB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 17:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbWHZVeB
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 17:34:01 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:20053 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750875AbWHZVeA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Aug 2006 17:34:00 -0400
Received: by nf-out-0910.google.com with SMTP id o25so1011588nfa
        for <git@vger.kernel.org>; Sat, 26 Aug 2006 14:33:58 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=nq6l3uujjGJad7dRtv/dwbC/6B6N+SrXYLGNibrTa9mz0d92T320EeH5jCLLMAD8syipKkGvSYIK/pcE1HYUZKnFmuw40kwUz4tfZNqPaTYFK9efI+N3dN01uPgohIczzbC1wEMyvPeGtsxbDGL5zvKjCNhOkjDW0rm1Iyh6Gc4=
Received: by 10.48.14.4 with SMTP id 4mr7086753nfn;
        Sat, 26 Aug 2006 14:33:58 -0700 (PDT)
Received: from host-81-190-21-215.torun.mm.pl ( [81.190.21.215])
        by mx.gmail.com with ESMTP id c1sm4525130nfe.2006.08.26.14.33.58;
        Sat, 26 Aug 2006 14:33:58 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26071>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 02d327c..9cf2b78 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1557,7 +1557,7 @@ sub git_difftree_body {
 			              "blob") .
 			      " | " .
 			      $cgi->a({-href => href(action=>"history", hash_base=>$parent,
-			                             file_name=>$diff{'file'})},\
+			                             file_name=>$diff{'file'})},
 			              "history") .
 			      "</td>\n";
 
-- 
1.4.1.1
