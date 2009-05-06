From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RESEND/PATCH] git config: improve documentation
Date: Thu,  7 May 2009 01:57:08 +0300
Message-ID: <1241650628-12503-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 07 00:57:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1q3J-0006XG-Sx
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 00:57:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753884AbZEFW5N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 18:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753318AbZEFW5N
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 18:57:13 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:21647 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595AbZEFW5M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 18:57:12 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1167599fga.17
        for <git@vger.kernel.org>; Wed, 06 May 2009 15:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=l+wFfu8DjUU5SfMVH150D0hyLnhMTvqWzOOF22Ets74=;
        b=IsI48viUo4/GZ6tibi0hYim9zOPFTiOnx4Tmmm9+Xui1YEO/XnZ32TvZZ1JKMCdRKJ
         6TuhIop4aVUI0bZ3rIk9uivVIEZBuaAmau27jHx43AtBoXXLxVqd11wiTFeBiMlzWjs2
         EvqLJOs60oVLXWf2Tixu0BuArEv0DaSueZYWc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=q1LzUEcTgKhRApcwKnOlD7pac01gpy0ld05/gckZ/M+hq5aQqn+rjCqqCcvNpr+4us
         FKj2jE2oyhLto2W/JIq4Vpd6ZVqDvVRQA2VegxrXQHZMEACupxoOzsZdznSXwt1M4Vkr
         3WKkNszBr6n8kmkDFT86szJpzdL7saYMFPW3Y=
Received: by 10.86.59.2 with SMTP id h2mr1826570fga.30.1241650631561;
        Wed, 06 May 2009 15:57:11 -0700 (PDT)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi [91.153.253.80])
        by mx.google.com with ESMTPS id e11sm11492247fga.11.2009.05.06.15.57.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 06 May 2009 15:57:11 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc4.14.g96da.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118402>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-config.txt |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 7131ee3..f68b198 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -69,7 +69,8 @@ OPTIONS
 
 --add::
 	Adds a new line to the option without altering any existing
-	values.  This is the same as providing '^$' as the value_regex.
+	values.  This is the same as providing '^$' as the value_regex
+	in `--replace-all`.
 
 --get::
 	Get the value for a given key (optionally filtered by a regex
@@ -155,7 +156,7 @@ See also <<FILES>>.
 	When the color setting for `name` is undefined, the command uses
 	`color.ui` as fallback.
 
---get-color name default::
+--get-color name [default]::
 
 	Find the color configured for `name` (e.g. `color.diff.new`) and
 	output it as the ANSI color escape sequence to the standard
-- 
1.6.3.rc4.14.g96da.dirty
