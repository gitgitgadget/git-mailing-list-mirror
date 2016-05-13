From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/4] Documentation: correct typo in example for querying attributes
Date: Thu, 12 May 2016 17:19:33 -0700
Message-ID: <20160513001936.7623-2-sbeller@google.com>
References: <20160513001936.7623-1-sbeller@google.com>
Cc: pclouds@gmail.com, git@vger.kernel.org, jrnieder@gmail.com,
	Jens.Lehmann@web.de, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri May 13 02:19:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b10pb-0006f2-Mm
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 02:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbcEMATn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 20:19:43 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:32955 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006AbcEMATm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 20:19:42 -0400
Received: by mail-pa0-f41.google.com with SMTP id xk12so34701081pac.0
        for <git@vger.kernel.org>; Thu, 12 May 2016 17:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/CCcmwvbWaBnsHD4NWmr4HUG2UeTwV+LUR8rqZ4H4jg=;
        b=akAKe5znDOGTs4U3mnJQyCspQIRqV/TWHArtXZXYpTeXl8fN2tyYzHWKTpDyeeiT0U
         ScwC3t5KK8WUmpThHuLDM76eiscsyrQpxK9hf8VVEGanrKsnkU6rE53lAlOCYLTKgRku
         tT9UXfaWRxw/Dz1i7qPNixFuGaDZVNPnKEhyLBLKQnePjjmnTVy9z3lSpMuqDr8a+lRf
         KzJphTZYv+HBBsVJtmvqaFdSQyNS37uxDJVsAdtDYmF8II950cXGTd+ZuJPNDzGMYM4q
         EgZv2vHvA4C7ub7+yDxj6RmElxzrpNHC86yQkimqa2UiYPVh7Th0ncRLKztwzgcDfTsv
         tB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/CCcmwvbWaBnsHD4NWmr4HUG2UeTwV+LUR8rqZ4H4jg=;
        b=nEVdmVIoMaROK5sY+kiET6vYsUBS6pVsEKHEzWbLYew3OZ2v0BuY0gObR8UjbBclKd
         LrIiKWMOrS6g7dQygfdDIPPEKXAexy1TfS3aclzVOYrZP/zxoXvaFAvuIVsMrPDNmZTi
         zPsY5RiR4JhGzVo6mtsbu36BKZmTpbIiK+PpCP1a76FFePUv1knwvJcpD9sbc65q9XYq
         gmOZ+IStcxwzTrpamO5+wPnh6ZBTepfSdIRsMm9/+q4lK+0Vv5avIki/yRhVkrJ+pjJi
         qMC7fp+kZxHHY2oRgNqsebR4/lMmwHY0+6n8XUG7PJDqdpOOO/qG9fKS+cMN62dxxjMo
         7irg==
X-Gm-Message-State: AOPr4FUJyrqVy15DXYrqDPDuH52pgjUnADLpD3n2VVdGQT0+bQfdyeOYzZcnVVc6R8Ky3A8w
X-Received: by 10.66.152.164 with SMTP id uz4mr2072780pab.9.1463098781425;
        Thu, 12 May 2016 17:19:41 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:c9fc:8b37:8cb7:4400])
        by smtp.gmail.com with ESMTPSA id w125sm22467330pfb.53.2016.05.12.17.19.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 12 May 2016 17:19:40 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.400.g8bfb85c.dirty
In-Reply-To: <20160513001936.7623-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294493>

The introductory text of the example has a typo in the
specification which makes it harder to follow that example.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/technical/api-gitattributes.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/technical/api-gitattributes.txt b/Documentation/technical/api-gitattributes.txt
index 2602668..36fc9af 100644
--- a/Documentation/technical/api-gitattributes.txt
+++ b/Documentation/technical/api-gitattributes.txt
@@ -61,7 +61,7 @@ Querying Specific Attributes
 Example
 -------
 
-To see how attributes "crlf" and "indent" are set for different paths.
+To see how attributes "crlf" and "ident" are set for different paths.
 
 . Prepare an array of `struct git_attr_check` with two elements (because
   we are checking two attributes).  Initialize their `attr` member with
-- 
2.8.2.400.g66c4903.dirty
