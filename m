From: GyuYong Jung <obliviscence@gmail.com>
Subject: [PATCH] git-cvsserver.perl: fix typo
Date: Wed, 17 Feb 2016 11:14:58 +0900
Message-ID: <1455675298-75332-1-git-send-email-obliviscence@gmail.com>
Cc: mmogilvi_git@miniinfo.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 03:14:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVrdX-0003Od-2q
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 03:14:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964997AbcBQCOf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 21:14:35 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34747 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964967AbcBQCOe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 21:14:34 -0500
Received: by mail-pa0-f54.google.com with SMTP id fy10so2124521pac.1
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 18:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=hlMn8UYDU3zhUQNZ2W5CzJAExyMrgvdj9EuuE3MXs/8=;
        b=TpJo6u90MKlVrJxtChFPtnskvkTgN4dXgiK+bdKqymX6uWsthD5qv9qdGtnA9Jlb90
         Rm/Z2c3dx7Ud3jOkMq1BijeOpZftTK8uTNPsCfRnut5m0gUISWwpaOHSpdm54y4dZPtZ
         lXWl18SSJlx9d69L32VqPEhnphAMkN7y4aR0Ntw9h27NwuWwb0qeYJ9OqHXikBMnXVYp
         xjpONZIvMQyM32vIDGsgLJG6oqBAfcYFb8UmxjzLA42oD4zrxH2jMQqiruTb4/jABZa9
         uEERyKDlnjdnFEkYYbB/XIfTH4O8NGca1fRrSs4YwGdapNDAdsJWQ4KJZfMHHTIGtpfi
         CQJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hlMn8UYDU3zhUQNZ2W5CzJAExyMrgvdj9EuuE3MXs/8=;
        b=bLeG3sPvt0klzLi5sj0tQG4FCYp4ayQK86Vq7X+M1ljT6gdsOsB0NmbCKpvkObkvMf
         0x7L/hdYIbrpGLC36W2lly+z2Y1sq7X6no3AxKv0hcNgf9GPo8m6Fw3LSKjSQc6CJEVj
         s46CHGhEzYjfoMgsBHwdcyaTNDivjtj82HH7SWuTpigTO5lRiQlN1zj0ZgLNwBnMSQuN
         C/JC4O8OTdohKa4R/95auh5wqSH9vKw0YxWzLUvVe03Am/zaL7tX7UdPdkJXVH9j7N7c
         Um5k3BT8S1wl4IPdwzQW35IjbDDNHdXu5IvOj3AmzM9Ekph3KBzrrmQ6y/azUBgc8Am3
         ZKlQ==
X-Gm-Message-State: AG10YOSeiGtecJPDWrWaTPmzVlJGqcK2d7pP5csbil/FwalM5WCnP4G6coG+5jjuieCp2Q==
X-Received: by 10.66.151.177 with SMTP id ur17mr35306449pab.68.1455675274164;
        Tue, 16 Feb 2016 18:14:34 -0800 (PST)
Received: from localhost.localdomain ([211.56.96.51])
        by smtp.gmail.com with ESMTPSA id x10sm48619145pas.37.2016.02.16.18.14.32
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 16 Feb 2016 18:14:33 -0800 (PST)
X-Mailer: git-send-email 2.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286475>

Signed-off-by: GyuYong Jung <obliviscence@gmail.com>
---
 git-cvsserver.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 95e69b1..02c0445 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -2664,7 +2664,7 @@ sub argsfromdir
     #   co  # Obtain list directly.
     #   remove # HERE: TEST: MAYBE client does the recursion for us,
     #          # since it only makes sense to remove stuff already in
-    #          # the sandobx?
+    #          # the sandbox?
     #   ci # HERE: Similar to remove...
     #      # Don't try to implement the confusing/weird
     #      # ci -r bug er.."feature".
-- 
2.7.1
