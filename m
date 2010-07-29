From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/3] contrib/svn-fe: Add the svn-fe target to .gitignore
Date: Thu, 29 Jul 2010 11:06:20 +0530
Message-ID: <1280381780-6265-4-git-send-email-artagnon@gmail.com>
References: <1280381780-6265-1-git-send-email-artagnon@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 29 07:38:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeLpa-0006l2-Qg
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 07:38:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753945Ab0G2Fi3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jul 2010 01:38:29 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61688 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753715Ab0G2FiS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jul 2010 01:38:18 -0400
Received: by mail-iw0-f174.google.com with SMTP id 7so232148iwn.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 22:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=rKlVRSKVxPlKOqhzMNhDUH1I2TGGm19QPRRWDLkngaM=;
        b=DTX+j2jKTzF4Yf+hphQ4oVBeCqTK4Lq6oB0yKNfXmmP8s2nGs412qGDsvig38S3r2r
         f4M0IjekyqHKKPukiPJ6QpdeEB+kHgVjSxR3Jkl4p1PWMMuK2La0PMEjipu6xoL8uaVc
         frR1wWjQMgOlrm3cH1+B00sDM+b4RJP3GEg2E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=NGY5lXHE1XvNJsNLpRF9eQ9ONYAnQgaGyKU26vqzcbSS2Ip5SWh7Oar/3ocYm3jN40
         Vr8IGp52cN37wMj23TnmCYAhDhNLB5jTMOwF+6Ug4pK/xHcEfK/Xnbti2uU91D+gGaTo
         dEnv6o8X6+FzrEOvfTJbiK5y7Jj5ODNfCN3XY=
Received: by 10.231.187.194 with SMTP id cx2mr12241412ibb.165.1280381898087;
        Wed, 28 Jul 2010 22:38:18 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id h8sm442940ibk.3.2010.07.28.22.38.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Jul 2010 22:38:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1280381780-6265-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152162>

Add the svn-fe target to .gitignroe.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 contrib/svn-fe/.gitignore |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/contrib/svn-fe/.gitignore b/contrib/svn-fe/.gitignore
index 27a33b6..02a7791 100644
--- a/contrib/svn-fe/.gitignore
+++ b/contrib/svn-fe/.gitignore
@@ -1,3 +1,4 @@
 /*.xml
 /*.1
 /*.html
+/svn-fe
-- 
1.7.1
