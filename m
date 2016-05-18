From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv7 2/5] Documentation: fix a typo
Date: Wed, 18 May 2016 12:02:19 -0700
Message-ID: <20160518190222.28105-3-sbeller@google.com>
References: <20160518190222.28105-1-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed May 18 21:02:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b36jq-00023o-TH
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 21:02:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753957AbcERTCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 15:02:32 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:32838 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753349AbcERTCa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 15:02:30 -0400
Received: by mail-pf0-f170.google.com with SMTP id 206so21471795pfu.0
        for <git@vger.kernel.org>; Wed, 18 May 2016 12:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q4ZsB0PCCS+pY5qIDQy9mLBBNIR9s/x3xJ2f/SSufLs=;
        b=pJZAzUO2gFgs9d1Uo1UyXbvGkEdR0yDFY0oPPHjSbK6gA1A5udnQ7O3bDYsUMGDU0q
         QFz/EwWDHn2kT8cndR+T8kB+ujAoJjuhD91MuxDq8scgrp6SE3Jd0p84nvN2Soc+q0ja
         ks3lMqsKCqLNKlYXc0GJ1gTTRMAlmccITtMBE0iRrWnzbzyp5if28jhPeowFWyiKR7Qj
         5xqD30Wd73LvYUCAmyxpqASVwkwUWe2eVNiEezNavfrXEfmCDCNgkXItO95W3tFE/hRj
         XYAHYt7HlRtJx39VgLd0Qbbn6iOtdmuDtHLDaVke3X2xCPdvF94JUY4upqE3Gc+mg2ne
         asZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q4ZsB0PCCS+pY5qIDQy9mLBBNIR9s/x3xJ2f/SSufLs=;
        b=iqyuKHwVFUoNCns+zOhqs9gniprlmKTA072w0ULUKcbASEuDEKEqI6fbOD8NjLt0pE
         ScRZcWLv4cpCD/wW2dU9YMZP0/c4SFHs9lt4csG+WMQyVWsgyU5L9vaEzzh3l8MYIb88
         55JYLF2vGA1TCngRx2VJCZn87hzVMNqkczjO5JUGDatWYGsDjvbnQkf5dEp7hBYX0PQf
         HK1lKknphcaZ2/P02LWcDdzB3GqAg4CZ5lcHjwuP16lQrgX3F49O2Mt854xaMHMjXYuM
         Yt2TxZjVE0Wv2NVwpy9JEgKqQ6GKt6GDJR8FX0bEH2Pc9qtrKCz3mOUNMVg5d5rO5Tsg
         JIAA==
X-Gm-Message-State: AOPr4FVQAENxGBCu2BzGTVUUV7UIFSNEBST/kWdxB3ljoQBgOAQP2kUswAXf2lnsFjyGS3tS
X-Received: by 10.98.79.213 with SMTP id f82mr13121943pfj.65.1463598149785;
        Wed, 18 May 2016 12:02:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:d468:afb3:b0f0:947e])
        by smtp.gmail.com with ESMTPSA id o63sm14034765pfj.30.2016.05.18.12.02.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 18 May 2016 12:02:28 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.121.ga97fb08
In-Reply-To: <20160518190222.28105-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294987>

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
2.8.2.121.ga97fb08
