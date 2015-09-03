From: David Turner <dturner@twopensource.com>
Subject: [PATCH 04/43] refs.c: add a new refs.c file to hold all common refs code
Date: Wed,  2 Sep 2015 21:54:34 -0400
Message-ID: <1441245313-11907-5-git-send-email-dturner@twopensource.com>
References: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Sep 03 03:57:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXJmR-0007Ih-0e
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 03:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756326AbbICBzi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 21:55:38 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:33406 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543AbbICBza (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 21:55:30 -0400
Received: by qgev79 with SMTP id v79so18591937qge.0
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 18:55:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j7xqEDS1AFVGG2BmCITe/c2Tdwoq0NhIKgiHk+qO/TY=;
        b=ZLFga34J7H4XWBMZOYUwS+pEoKfxNsUZuCO+BX3Q3xfKexR/2NVtndFZMhGk7ilLRl
         siolPVWUFtDP9lYE/IKomEXSRvJqBDm7SR7iL9k8EwxTXkdKQCTUlmc46qJ+E073h8/a
         UFNYu8jQJiM2ZNgqaUM0Npu7SdeUhLonSqgtnzS5CzNfb0piDKL4sAUQ2VtWJc2J2AkZ
         1wW0LCpswhEARVmYbchuopI8vF3eDAEEIGyihj5vutLXE/ewa652C++bELeciFALv+aL
         xhQaVGywfQNFqVEpNwP7TghRfaazpSJmxWf34R6Jp358IbAam3FE2lXKCTNGwnMDbR/r
         PytQ==
X-Gm-Message-State: ALoCoQlb00DpbxInvkQj9GoHAjnpVn97kLf7vjCgiGx+l4GhNZeDTqeA2ebiVOiypQ+6hen8N1IF
X-Received: by 10.140.235.142 with SMTP id g136mr67970569qhc.18.1441245329768;
        Wed, 02 Sep 2015 18:55:29 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 95sm11108155qgt.12.2015.09.02.18.55.28
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Sep 2015 18:55:29 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277174>

From: Ronnie Sahlberg <sahlberg@google.com>

Create a new refs.c file that will be used to hold all the refs
code that is backend agnostic and will be shared across all backends.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/refs.c b/refs.c
index e69de29..77492ff 100644
--- a/refs.c
+++ b/refs.c
@@ -0,0 +1,3 @@
+/*
+ * Common refs code for all backends.
+ */
-- 
2.0.4.315.gad8727a-twtrsrc
