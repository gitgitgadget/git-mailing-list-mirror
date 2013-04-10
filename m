From: Barbu Paul - Gheorghe <barbu.paul.gheorghe@gmail.com>
Subject: [PATCH] git-imap-send.txt: remove the use of sslverify=false in GMail
 example
Date: Wed, 10 Apr 2013 17:59:37 +0300
Message-ID: <51657E59.7030001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 10 16:59:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPwUy-0001C4-Q3
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 16:59:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936636Ab3DJO7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 10:59:40 -0400
Received: from mail-ee0-f47.google.com ([74.125.83.47]:54964 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934984Ab3DJO7k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 10:59:40 -0400
Received: by mail-ee0-f47.google.com with SMTP id t10so278088eei.6
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 07:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=BmH/jFtK/O6QNowDebFddO11N7Liqv2IROOJLG2qUBg=;
        b=Zzg+o6ysUYnCgwUO/4Uw0fwtbEWulbDuiFpKC4OYd3F1aO4ee91E3MS7MXzs5jFJh8
         FVB3SJKaF3ONvH13Ik0yqyqVVyZNDe6wtqR2Z2cg73iF5WVeOw9s+S5myuUU+HLq7RDx
         jMHvIbberN84utmMBLnWCAQdmC5HXH7A5jfB7OWFibfFxKOtqvmCuhZCu7CQ0vtoxVWh
         uz7pShDpZi6e9g6vokTb7C/MNeOgikYwE7dgo0lvtT7O0oBWKMgcvp5GjD2UugRPTi3f
         0UdIEnNl1u+TGQeipWaou2YkLzx6T02hzzERTXWO2vde7CNsScnyYLwEIOUf0PajidA4
         H3wg==
X-Received: by 10.15.61.8 with SMTP id h8mr6268899eex.33.1365605978848;
        Wed, 10 Apr 2013 07:59:38 -0700 (PDT)
Received: from [192.168.16.100] (5-15-249-103.residential.rdsnet.ro. [5.15.249.103])
        by mx.google.com with ESMTPS id f47sm286058eep.13.2013.04.10.07.59.37
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 10 Apr 2013 07:59:38 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130403 Thunderbird/17.0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220694>

Since GMail is SSL capable there is no need to set sslverify to false, the
example using it may confuse readers that it's needed since it's also used in
the previous example configurations, too

Signed-off-by: Barbu Paul - Gheorghe <barbu.paul.gheorghe@gmail.com>
---
 Documentation/git-imap-send.txt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
index 875d283..b15dffe 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -123,7 +123,6 @@ to specify your account settings:
 	host = imaps://imap.gmail.com
 	user = user@gmail.com
 	port = 993
-	sslverify = false
 ---------
  You might need to instead use: folder = "[Google Mail]/Drafts" if you get an error
-- 
Barbu Paul - Gheorghe
Common sense is not so common - Voltaire
Visit My GitHub profile to see my open-source projects - https://github.com/paullik
