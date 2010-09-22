From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC 1/3] gitweb/Makefile: Include gitweb/config.mak
Date: Wed, 22 Sep 2010 16:21:24 +0200
Message-ID: <1285165286-12452-2-git-send-email-jnareb@gmail.com>
References: <1285165286-12452-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 22 16:21:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyQCl-0005b0-JZ
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 16:21:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754055Ab0IVOVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Sep 2010 10:21:46 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40730 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753025Ab0IVOVp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Sep 2010 10:21:45 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so464599bwz.19
        for <git@vger.kernel.org>; Wed, 22 Sep 2010 07:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=07EdkHW5E3zk3+tMGs9rKnV0wG6GRUtk6geRMb43QAw=;
        b=sf9BBALh8uatjA1fm2wkVGvVhzieaa9jufDkSclSS8eJy9KFXNk622yspdMa34j6WQ
         ubDkvp0TheeA1rNM1umAOpiiOYwtV5pS1sie0donRSR+I5Ikh2g0qUxP2niFJ4RfqPeh
         R4AoH6TsfY4yVGkUHkVzd3k8Jg1KuhSPahEWc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=UNMWVwGWR64d6fVTyUuBpAnYjngthmmJcsa0/ReVNBRW1aKksShoQTYh12e1+/gVti
         kh9jMSZPgvRIToJfbVa2eDXY3LwuLcERAoOC5jcWXeqzkHnFXhqy7cW2lDClOkxrrjdT
         gb3fBsS3JoiDkeKl/XVDFjhVg3mjp5zKidb90=
Received: by 10.204.66.206 with SMTP id o14mr106826bki.159.1285165304347;
        Wed, 22 Sep 2010 07:21:44 -0700 (PDT)
Received: from localhost.localdomain (abva250.neoplus.adsl.tpnet.pl [83.8.198.250])
        by mx.google.com with ESMTPS id x13sm8626411bki.12.2010.09.22.07.21.42
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 22 Sep 2010 07:21:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1285165286-12452-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156804>

Allow for gitweb-specific Makefile config to reside in config.mak file
in the 'gitweb/' subdirectory.  This means that gitweb-specific
build-time configuration variable can reside in gitweb-specific
gitweb/config.mak

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
I'm not sure if it is really neccessary, and useful.  Still...
This patch can be safely dropped from this series.

 gitweb/Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gitweb/Makefile b/gitweb/Makefile
index 2fb7c2d..88bcf08 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -39,6 +39,7 @@ GITWEB_SITE_FOOTER =
 # include user config
 -include ../config.mak.autogen
 -include ../config.mak
+-include config.mak
 
 # determine version
 ../GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
-- 
1.7.2.1
