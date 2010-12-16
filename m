From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH] Fix typo in git-gc document.
Date: Thu, 16 Dec 2010 15:16:49 +0800
Message-ID: <4D09BCE1.9030209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 16 08:22:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PT8Ab-0002W1-D7
	for gcvg-git-2@lo.gmane.org; Thu, 16 Dec 2010 08:22:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752910Ab0LPHW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Dec 2010 02:22:28 -0500
Received: from mail-pz0-f52.google.com ([209.85.210.52]:42352 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803Ab0LPHW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Dec 2010 02:22:28 -0500
X-Greylist: delayed 332 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Dec 2010 02:22:28 EST
Received: by pzk36 with SMTP id 36so563830pzk.11
        for <git@vger.kernel.org>; Wed, 15 Dec 2010 23:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=l/4OatxfpsxFXX6Esd6h/ALf+hL+ZCbNcA30cVhZO6U=;
        b=NOB8XIycN2fq69ALjnqKAmZyHwd4+0ZjI2M8tNIgA2gLeaEVaf1qcDoi97vuqlv4Gs
         w/cvKz3pqpXEaY1PUTQQRSj964vXHJDSRb2/ztTOAnL9uVAYveEmPWCkqydfn7e4qfJZ
         xJIhhDkR131pF8VFRiiSrvr2VgRq9KiE0+Lo4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=c/zzS8kZJBhqDYedoZJiL4F3MosPoBjA4zmseMQ/bdzbJOfmzr1ewNdcphbE5u3d7e
         kkZqMnReED5GMtzR3vBbbh7bUSbLwEcQOUbmMny0aQiwtgl/439vlkpMbJqnkyugzQsi
         9jTi2ZrU7pJ1jSjVWkcGBtVNr7xFC86c/GTb0=
Received: by 10.142.233.2 with SMTP id f2mr6519768wfh.395.1292483815574;
        Wed, 15 Dec 2010 23:16:55 -0800 (PST)
Received: from [192.168.0.50] ([123.115.148.126])
        by mx.google.com with ESMTPS id b11sm2690020wff.9.2010.12.15.23.16.52
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 15 Dec 2010 23:16:53 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); zh-CN; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163804>

The variable gc.packrefs for git-gc can be set to true, false and
"notbare", not "nobare".

Signed-off-by: Jiang Xin <jiangxin@ossxp.com>
---
 Documentation/config.txt |    2 +-
 Documentation/git-gc.txt |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3fd4b62..4f1e979 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -971,7 +971,7 @@ gc.packrefs::
 	Running `git pack-refs` in a repository renders it
 	unclonable by Git versions prior to 1.5.1.2 over dumb
 	transports such as HTTP.  This variable determines whether
-	'git gc' runs `git pack-refs`. This can be set to `nobare`
+	'git gc' runs `git pack-refs`. This can be set to `notbare`
 	to enable it within all non-bare repos or it can be set to a
 	boolean value.  The default is `true`.
 
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 315f07e..a01eef6 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -107,7 +107,7 @@ how long records of conflicted merge you have not resolved are
 kept.  This defaults to 15 days.
 
 The optional configuration variable 'gc.packrefs' determines if
-'git gc' runs 'git pack-refs'. This can be set to "nobare" to enable
+'git gc' runs 'git pack-refs'. This can be set to "notbare" to enable
 it within all non-bare repos or it can be set to a boolean value.
 This defaults to true.
 
-- 
1.7.3.3
