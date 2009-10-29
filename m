From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 19/19] .gitignore: add git-remote-cvs
Date: Thu, 29 Oct 2009 11:01:27 -0700
Message-ID: <1256839287-19016-20-git-send-email-srabbelier@gmail.com>
References: <1256839287-19016-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Oct 29 19:03:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3ZLc-00051l-Sy
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 19:03:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755001AbZJ2SDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 14:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754714AbZJ2SC7
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 14:02:59 -0400
Received: from mail-pw0-f42.google.com ([209.85.160.42]:32951 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754663AbZJ2SCx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 14:02:53 -0400
Received: by pwj9 with SMTP id 9so194829pwj.21
        for <git@vger.kernel.org>; Thu, 29 Oct 2009 11:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ytGC2SHsVbmMtVPlQzao7JiXXJDUSA0L4BBcmrtTBV8=;
        b=S47KAQd1jBMfc4+qxBmSS6n4ratoEWe5q3s6bjat5j1vdLW0WcWnXXwZFGTD8g5vJ+
         cf8HbE82Yj67/lrq6HaRZFSi26EWxb0T90PVfY9MnOMvtwHbYw6+5P0uUVe7aKTZ9LPC
         NfD2GQ72nLu1WNywIkaO20cwh77vSGbDoNQms=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ez1ISo7qyeEzZkp9EiitOYi/cvNnVX3sLqoYgAZWkV97CBLple6vlMgXOxPwmmzvNF
         RoAtcC28XkTjjMDHKj6P+v6UW/37BClOKOksLu3x4rzBDqf7+ePudC60VtOfXFWQniQo
         xIxr8YWKOASmF4DkCiMqEE9WeYyrLO7mr2nZ4=
Received: by 10.115.98.29 with SMTP id a29mr246623wam.142.1256839376835;
        Thu, 29 Oct 2009 11:02:56 -0700 (PDT)
Received: from localhost.localdomain (ip67-152-86-163.z86-152-67.customer.algx.net [67.152.86.163])
        by mx.google.com with ESMTPS id 23sm1332445pxi.5.2009.10.29.11.02.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 Oct 2009 11:02:55 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.2.291.gf76a3
In-Reply-To: <1256839287-19016-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131636>

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---
 .gitignore |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 51a37b1..461f6ee 100644
--- a/.gitignore
+++ b/.gitignore
@@ -105,6 +105,7 @@ git-reflog
 git-relink
 git-remote
 git-remote-curl
+git-remote-cvs
 git-repack
 git-replace
 git-repo-config
-- 
1.6.5.2.291.gf76a3
