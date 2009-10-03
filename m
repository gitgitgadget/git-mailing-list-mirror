From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH/RFC 7/7] mingw: enable OpenSSL
Date: Sat,  3 Oct 2009 00:39:45 +0000
Message-ID: <1254530385-2824-7-git-send-email-kusmabite@gmail.com>
References: <1254530385-2824-1-git-send-email-kusmabite@gmail.com>
 <1254530385-2824-2-git-send-email-kusmabite@gmail.com>
 <1254530385-2824-3-git-send-email-kusmabite@gmail.com>
 <1254530385-2824-4-git-send-email-kusmabite@gmail.com>
 <1254530385-2824-5-git-send-email-kusmabite@gmail.com>
 <1254530385-2824-6-git-send-email-kusmabite@gmail.com>
Cc: git@vger.kernel.org
To: msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Sat Oct 03 02:40:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mtsfw-0004Ya-BQ
	for gcvg-git-2@lo.gmane.org; Sat, 03 Oct 2009 02:40:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756024AbZJCAk0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2009 20:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755832AbZJCAkZ
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Oct 2009 20:40:25 -0400
Received: from mail-qy0-f173.google.com ([209.85.221.173]:60096 "EHLO
	mail-qy0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755684AbZJCAkY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2009 20:40:24 -0400
Received: by mail-qy0-f173.google.com with SMTP id 3so1339018qyk.4
        for <git@vger.kernel.org>; Fri, 02 Oct 2009 17:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=9GJfdgUPNPijXn8V5qpHV7TI4nCklKNzlGk0jYkMcEE=;
        b=IYp9yoFEyFB2j4aw3zrmB/+uFixjP+XaUefSPVet4XsT3SXldzF1r5Y+TjlttWnD9B
         TrTy+7+6WyEFnbboxYMrpGhDT8Emz21cMsYIjtMY0ZFHF2c6yflfvCFdWhBg4Ll33Mgi
         Oys31NmeCflRHiox0dM93Tv/E5nQcbMjvICzo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=sNC5Auuq41TMkv4SKqguRN6Snqp3dZ+P9vbrYdsXjuEKaAdBSFKf7JTUuU4+z4Mdcs
         Cbdv+XF5iV7sUfZGACbPZJ79kbQDmpvO6Ll4tn2X11rZpwj+5yN2xdlyOurMF4YkFX8Q
         R5GtQNObx995gJg39XCpCFixp4oVIa3MN+rFs=
Received: by 10.224.7.80 with SMTP id c16mr1581351qac.381.1254530428094;
        Fri, 02 Oct 2009 17:40:28 -0700 (PDT)
Received: from localhost ([75.35.230.210])
        by mx.google.com with ESMTPS id 20sm160877qyk.1.2009.10.02.17.40.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 02 Oct 2009 17:40:25 -0700 (PDT)
X-Mailer: git-send-email 1.6.4
In-Reply-To: <1254530385-2824-6-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129477>

Since we have OpenSSL in msysgit now, enable it to support SSL
encryption for imap-send.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 Makefile |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 8ba789a..8818f0f 100644
--- a/Makefile
+++ b/Makefile
@@ -933,7 +933,6 @@ else
 ifneq (,$(findstring MINGW,$(uname_S)))
 	pathsep = ;
 	NO_PREAD = YesPlease
-	NO_OPENSSL = YesPlease
 	NO_LIBGEN_H = YesPlease
 	NO_SYMLINK_HEAD = YesPlease
 	NO_IPV6 = YesPlease
-- 
1.6.5.rc2.7.g4f8d3
