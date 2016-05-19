From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv9 1/4] Documentation: fix a typo
Date: Thu, 19 May 2016 16:23:20 -0700
Message-ID: <20160519232323.12775-2-sbeller@google.com>
References: <20160519232323.12775-1-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Fri May 20 01:23:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3XHy-0005kO-RZ
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 01:23:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754799AbcESXXb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 19:23:31 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33060 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753824AbcESXXa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 19:23:30 -0400
Received: by mail-pa0-f47.google.com with SMTP id xk12so33354106pac.0
        for <git@vger.kernel.org>; Thu, 19 May 2016 16:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Su/U5LWa8s2LvlLMeQZidUtD/9SzMGJVgjnSYiVj79I=;
        b=BRNxjgz8aBhKiU7t47UojaN2nQtqae5AXguRnZktKfVK6NqH9ik93QeZjDYEtU2FfB
         JAGukkeiSxruQ4OYk8qP0yyhRWLzJwQLKVV/JghNMMa+7oe/T8f5sDj0cFcO5aRemHuA
         pGRHO2x8KAdanKiOJ/bOzcluMLcx1zA+np2lAg0LdDsgnQuwFdwD9SpCKxDBZ4njVb2z
         WSsjsIUVEOus54pK7NBMoVhz1chiDLi9PgEizaWrt2Qkqpz+dk0oqnjt1FWGdpaNJ1Fp
         yyN56rr2GYEQcHVNymOZYC/J9PJfpMmCJwny0mVKEE/tP8jhGBiSSLnGtwFK1mysYMm7
         h0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Su/U5LWa8s2LvlLMeQZidUtD/9SzMGJVgjnSYiVj79I=;
        b=fwBHa84dXl1c+2MEDFMIaIyegPIVE+q3pDrCOZvIx7ZRb9q+Yek2wXCVGbX0O9EmDR
         JNryB1S9hNTe8TgrmRDp0Xrw4JTjvh5C4J9nUgFIl8P/nqzSzVZxIJ0efMsTFoVX6aWc
         2apq/GXkCk6N8x1iliDncx7Xc3IMQCCSIyKrjcvwxxFwpAz7Tx3df077PlvunyUSGzR7
         BQsHyeAtjw4laPsSG4ZJoQ4HshBFPXdB1Ebb87wukUWt4MF95K3RrCV1ZtS4QMiP+TnY
         jj2jo1BGROUIjhEak2NfgzgJuXTJmklKGQ/k/gRKkXsmqUcswS/NZfhLZ8hiJQOBD7/G
         TGlg==
X-Gm-Message-State: AOPr4FXfvg5wfqrOQJT3/2fB57sLhyQcm9fZ20cFJsey3uW/hvUfsBEaY6WFy1syFmfBN9E/
X-Received: by 10.66.196.105 with SMTP id il9mr23471164pac.97.1463700209583;
        Thu, 19 May 2016 16:23:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:acf4:8121:b728:8fc4])
        by smtp.gmail.com with ESMTPSA id q70sm22267339pfj.81.2016.05.19.16.23.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 19 May 2016 16:23:29 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.123.gb4ad9b6.dirty
In-Reply-To: <20160519232323.12775-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295128>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/gitattributes.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index e3b1de8..af2c682 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -86,7 +86,7 @@ is either not set or empty, $HOME/.config/git/attributes is used instead.
 Attributes for all users on a system should be placed in the
 `$(prefix)/etc/gitattributes` file.
 
-Sometimes you would need to override an setting of an attribute
+Sometimes you would need to override a setting of an attribute
 for a path to `Unspecified` state.  This can be done by listing
 the name of the attribute prefixed with an exclamation point `!`.
 
-- 
2.8.2.123.gb4ad9b6.dirty
