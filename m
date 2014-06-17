From: "Yi, EungJun" <semtlenori@gmail.com>
Subject: [PATCH v2] http-protocol.txt: Basic Auth is RFC 2617, not RFC 2616
Date: Tue, 17 Jun 2014 10:11:10 +0900
Message-ID: <CAFT+Tg-PH6wD722U=RK-NL1+3dH8m5AZ5jvxCL06zGGZ95FFEQ@mail.gmail.com>
Reply-To: semtlenori@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 03:11:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwhvf-0003WJ-NK
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 03:11:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752959AbaFQBLL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 21:11:11 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:53689 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752855AbaFQBLK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 21:11:10 -0400
Received: by mail-ie0-f170.google.com with SMTP id tr6so5807222ieb.15
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 18:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:date:message-id:subject:from:to:cc
         :content-type;
        bh=JWrCWy46oz+0KdtP3SD72+OIl8H7/rlcIPPpcWUt2E4=;
        b=q+vWjleZJp2eroBSpDAFvivU8DXttq4i6p2MQNXo/+cpIaebIVw+6yd8nWltXFr2tr
         x4HDNBwS/Z69181XI/KnLben4GQISqa8x5LHb7RCXDZMNmDXpWcwVGjCWa8gy8P6ZmQP
         tg8cgnLUn/dj4B6TRrpjw4efoAt1vaKLdDm++SdG3UKQDkbKDZ8we62JfDq03Cr16MCt
         xcGl5LJbPsQXoCJhYOh5eXzCXVVIlZ0TmUKXaLPImEPRxvHXts0VcqmX4MssvPs4M38Q
         eFFiuacLxA+VYOyt9xTYdLM5ff0N0rlfsHvSeN47ik8YbGGARVB6YRzYOXIwQdxWbRFX
         E92Q==
X-Received: by 10.50.39.45 with SMTP id m13mr1075480igk.1.1402967470100; Mon,
 16 Jun 2014 18:11:10 -0700 (PDT)
Received: by 10.50.153.110 with HTTP; Mon, 16 Jun 2014 18:11:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251841>

From: Yi EungJun <eungjun.yi@navercorp.com>

Signed-off-by: Yi EungJun <eungjun.yi@navercorp.com>
---
 Documentation/technical/http-protocol.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/technical/http-protocol.txt
b/Documentation/technical/http-protocol.txt
index 544373b..2d0eb19 100644
--- a/Documentation/technical/http-protocol.txt
+++ b/Documentation/technical/http-protocol.txt
@@ -60,7 +60,7 @@ Because Git repositories are accessed by standard
path components
 server administrators MAY use directory based permissions within
 their HTTP server to control repository access.

-Clients SHOULD support Basic authentication as described by RFC 2616.
+Clients SHOULD support Basic authentication as described by RFC 2617.
 Servers SHOULD support Basic authentication by relying upon the
 HTTP server placed in front of the Git server software.

-- 
2.0.0.422.gb6302de
