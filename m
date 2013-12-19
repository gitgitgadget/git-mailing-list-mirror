From: Samuel Bronson <naesten@gmail.com>
Subject: [PATCH] git-cherry.txt: cross reference "git log --cherry"
Date: Thu, 19 Dec 2013 15:20:50 -0500
Message-ID: <1387484450-935-1-git-send-email-naesten@gmail.com>
References: <5167369f.ea15340a.5e12.0282@mx.google.com>
Cc: Samuel Bronson <naesten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 19 21:21:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vtk6V-00077U-Bf
	for gcvg-git-2@plane.gmane.org; Thu, 19 Dec 2013 21:21:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755736Ab3LSUVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Dec 2013 15:21:51 -0500
Received: from mail-qe0-f49.google.com ([209.85.128.49]:37843 "EHLO
	mail-qe0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753389Ab3LSUVu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Dec 2013 15:21:50 -0500
Received: by mail-qe0-f49.google.com with SMTP id w7so1519972qeb.8
        for <git@vger.kernel.org>; Thu, 19 Dec 2013 12:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c9GKfB2BuL2aM7YtK9PZMmXv5T8101yYtmoGCdMyB9c=;
        b=nIwsgBn/4EN+U4+TaAEW4xlex2zJMybRkWDQFmoUbCBv3kk8kyqGYoBULpHH9IqzO9
         CSJHvnh1fS9pDGZSlOStLTTZkbxJd4ayH4FTEqGWzXQ91cdtp3fMgzlm5nipbC1sAChl
         7AtzZWDiMjOq2JvIcHpL5fjWFQcHYujwtVnWGiEQm/Nc+1cTR27eXGfzVpDcivja0+op
         EqIJDmgwlEKodVIAyePxFxiZEKfnXSFAgilC05HJOBkiAdNHRVf6TeUl288h4Y/czBfF
         LLUDU30xZ8euV3IaCww6boZqYFZG55uFUJWBlIy2csudJrBM/CBxtn1NS8IDJwcTLvFz
         LiTA==
X-Received: by 10.224.0.68 with SMTP id 4mr6730932qaa.17.1387484510466;
        Thu, 19 Dec 2013 12:21:50 -0800 (PST)
Received: from hydrogen (naesten-pt.tunnel.tserv4.nyc4.ipv6.he.net. [2001:470:1f06:57::2])
        by mx.google.com with ESMTPSA id nq5sm12916298qeb.8.2013.12.19.12.21.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 19 Dec 2013 12:21:48 -0800 (PST)
Received: from naesten by hydrogen with local (Exim 4.80)
	(envelope-from <naesten@gmail.com>)
	id 1Vtk6M-0000Fs-2Z; Thu, 19 Dec 2013 15:21:46 -0500
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <5167369f.ea15340a.5e12.0282@mx.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239539>

I learned of "git cherry" some days ago, but only learned of --cherry
and related options to "git log" today[1] (more-or-less by chance).

If the git-cherry(1) manpage had mentioned --cherry, I would have
learned of these options sooner.

[1]: Thu, 11 Apr 2013

Signed-off-by: Samuel Bronson <naesten@gmail.com>
---
 Documentation/git-cherry.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-cherry.txt b/Documentation/git-cherry.txt
index 0ea921a..cff9ae5 100644
--- a/Documentation/git-cherry.txt
+++ b/Documentation/git-cherry.txt
@@ -138,7 +138,8 @@ $ git cherry origin/master topic base
 
 SEE ALSO
 --------
-linkgit:git-patch-id[1]
+linkgit:git-patch-id[1],
+the `--cherry` option to linkgit:git-log[1]
 
 GIT
 ---
-- 
1.8.4.3
