From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 32/44] revision: add missing include
Date: Sat, 28 Sep 2013 17:03:57 -0500
Message-ID: <1380405849-13000-33-git-send-email-felipe.contreras@gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 29 00:11:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2jo-0003vk-SY
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 00:11:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755354Ab3I1WLk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 18:11:40 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:33066 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755343Ab3I1WLd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 18:11:33 -0400
Received: by mail-oa0-f44.google.com with SMTP id l10so3047187oag.3
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 15:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qHQ1qAl4rBsqbqH3rd/M5+VhfGOZg3pXBrVFfTkcsK0=;
        b=WjzdlBFwrrQt7Cd6WC/V5BiN1iM0ezjG3wzRcf/QXKmVlBcCnNKQMGeC56nR7BUVf7
         gACSmiJBdKLV/qSLWljAH6TxjXCCYlWlM+fWLkir5gzFDiTl5Zv2ABm7lRpi0WQBbPAh
         2oo6yHxRxwUfsqu+wKDrfvt3RJ1RSQoReJG4CSW0xyBRPDsyzxMkpo8DSG4I1PS2BVxk
         1qmZ1Vq6z5KBW2zLdhlhHmvuFoxD2MJAHNuU2qRxa6xThB1JK0CCNeygmtdE/29CfTIq
         vjzyTr9lE3bAOhf4zjEhlzA3myV+7hDvTyk+SO+LMY352c2KfnuSlVnsjQ3woG9fhJw7
         xnLg==
X-Received: by 10.60.68.135 with SMTP id w7mr12668743oet.9.1380406293225;
        Sat, 28 Sep 2013 15:11:33 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id gc8sm19534712obb.3.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 15:11:32 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235552>

Otherwise we might not have 'struct diff_options'.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 revision.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/revision.h b/revision.h
index 95859ba..4aa5c5a 100644
--- a/revision.h
+++ b/revision.h
@@ -5,6 +5,7 @@
 #include "grep.h"
 #include "notes.h"
 #include "commit.h"
+#include "diff.h"
 
 #define SEEN		(1u<<0)
 #define UNINTERESTING   (1u<<1)
-- 
1.8.4-fc
