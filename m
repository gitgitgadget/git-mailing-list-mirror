From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCH 3/5] Remove reference to GREP_COLORS from documentation
Date: Fri, 26 Feb 2010 23:57:48 -0500
Message-ID: <1267246670-19118-4-git-send-email-lodatom@gmail.com>
References: <1267246670-19118-1-git-send-email-lodatom@gmail.com>
Cc: Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 05:54:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlEh5-0007b4-92
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 05:54:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967853Ab0B0EyQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2010 23:54:16 -0500
Received: from mail-qy0-f179.google.com ([209.85.221.179]:51848 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967850Ab0B0EyP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 23:54:15 -0500
Received: by mail-qy0-f179.google.com with SMTP id 9so475291qyk.5
        for <git@vger.kernel.org>; Fri, 26 Feb 2010 20:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=NlrISnXu126FdtxuCakdBiNYltekFVIJJXXOh+Z+3l4=;
        b=mTanL0DN8uMw9N3SYbNTBYPBJlJCJ9gznQiF8oX/hREm4PeNaqcRGLD+n8jL3u88K/
         RfINcJOfp+lk1s8xywhblxNkdKWwpPnN5A0KzeyYaW1nMFPUhQIVLd/UiK5uIOHOI46x
         GXX5JoXBSCxaxCDjN5ssGACgjxS1LY/LZN2lE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Y/j+Os+Yty0TTwqXcvUlcJu1rRW5Oy6NMv3wnDSXgiRmBFn8+PPSkq0zDbZRzDV6R9
         Hclwp/G3xLJXlvZT6K41bbZ3BDRry80rKt5O5CkqFRd72n6+DjbroEfas+Xx4fDSffd6
         9h1vvy1Q1RBZ7LvZ+HywR4zV51FKlnctIzS94=
Received: by 10.224.99.132 with SMTP id u4mr808664qan.9.1267246455284;
        Fri, 26 Feb 2010 20:54:15 -0800 (PST)
Received: from localhost.localdomain (c-68-50-174-152.hsd1.dc.comcast.net [68.50.174.152])
        by mx.google.com with ESMTPS id 20sm622133qyk.12.2010.02.26.20.54.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Feb 2010 20:54:14 -0800 (PST)
X-Mailer: git-send-email 1.7.0
In-Reply-To: <1267246670-19118-1-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141184>

There is no longer support for external grep, as per bbc09c22b9, so
remove the reference to it in the documentation.

Signed-off-by: Mark Lodato <lodatom@gmail.com>
---
 Documentation/config.txt |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index fed18cb..791b065 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -689,9 +689,7 @@ color.grep::
 
 color.grep.match::
 	Use customized color for matches.  The value of this variable
-	may be specified as in color.branch.<slot>.  It is passed using
-	the environment variables 'GREP_COLOR' and 'GREP_COLORS' when
-	calling an external 'grep'.
+	may be specified as in color.branch.<slot>.
 
 color.interactive::
 	When set to `always`, always use colors for interactive prompts
-- 
1.7.0
