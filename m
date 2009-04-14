From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] Add git-replace to .gitignore
Date: Mon, 13 Apr 2009 19:01:27 -0700
Message-ID: <1239674487-47460-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com, chriscool@tuxfamily.org
X-From: git-owner@vger.kernel.org Tue Apr 14 04:03:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtXzV-0007mr-Qg
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 04:03:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752501AbZDNCBj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 22:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752434AbZDNCBi
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 22:01:38 -0400
Received: from rv-out-0506.google.com ([209.85.198.232]:3835 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838AbZDNCBi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 22:01:38 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2372442rvb.1
        for <git@vger.kernel.org>; Mon, 13 Apr 2009 19:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=PsB7omq6RMnuuLL+aDfZxOUkMCEQ3K8ICM/FyCP8U3c=;
        b=Mx4DVk38AkepQctVPRiw47XOiG7gS5vziKvCSZ0Bmv8obKoZV2dfh/A0z4bChdl1Ev
         khhPpyzR71o4qhiCR+WpxXDIYAFcZCjcysE7vUse38H8Hqgzrg+E9ePhbwk5fMjJgy0g
         H9+lAMtv4FUtGC5U4hJJ6VQpHVXaIOJmCW1IM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=syx36X55BaLiJixKwWMDXMAefiem8UC9ePlH4iKPxyv41mE9jnPOZ0t8EMPUGqyVzS
         ZMCBd4K17gNMbeIBF8wkyugk96msRJ1jIVlvhGBOzeuLiZGeuu/t38GOJ9Ko2SRw0Awk
         +gOfvc1RNJhOpIq+pfcHcNj1GOVdkvwIzU9Gk=
Received: by 10.140.207.2 with SMTP id e2mr2995061rvg.148.1239674497505;
        Mon, 13 Apr 2009 19:01:37 -0700 (PDT)
Received: from localhost (wdas-1.disneyanimation.com [12.188.26.1])
        by mx.google.com with ESMTPS id g22sm6700248rvb.13.2009.04.13.19.01.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Apr 2009 19:01:36 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc0.90.g3e2c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116507>

Signed-off-by: David Aguilar <davvid@gmail.com>
---

This is based on the cc/replace branch in pu.

 .gitignore |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 1c57d4c..0d59e93 100644
--- a/.gitignore
+++ b/.gitignore
@@ -101,6 +101,7 @@ git-reflog
 git-relink
 git-remote
 git-repack
+git-replace
 git-repo-config
 git-request-pull
 git-rerere
-- 
1.6.2.2.471.g6da14
