From: Stefan Beller <sbeller@google.com>
Subject: [RFC-PATCHv6 1/4] Documentation: fix a typo
Date: Mon, 16 May 2016 20:13:50 -0700
Message-ID: <20160517031353.23707-2-sbeller@google.com>
References: <20160517031353.23707-1-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Tue May 17 05:14:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2VSo-00077N-WB
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 05:14:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754742AbcEQDOK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 23:14:10 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34318 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754128AbcEQDOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 23:14:09 -0400
Received: by mail-pf0-f172.google.com with SMTP id y69so1673401pfb.1
        for <git@vger.kernel.org>; Mon, 16 May 2016 20:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N/gaXUT8/WiqfZYZpJ801EjChNyeQDRafZWgA1piv6o=;
        b=Bxanufdg9LOWpSpqDI1ogWt+gxxO4tSTRLiY/4ahDuThe8Ks8RH6/m+W8sLflS6gtd
         uFOvsQcoiSbPTKaE7yD6oY1ujFVDX2APLUArgMrQLR3p0Up1OZ63w9/8MIoqLafLsIZ2
         /5u74KKToFIPmV0KJQ0S5JnEfmhHuDsNAcv1Kfr+Jy5dNu0zqLClAtsmb155WDR/Opoq
         JKrmvBVfHI56UqBUea3M+Wy651CwXb/rOpe10k8iJ8Xi+pL9Xm8yR8MjjGO7pApDDwx6
         8nBgc+547XmuOGz5JAeLM/CK1gFbTt4w1AZKKaCpOpkJeP/8c62dIdkZBW7zduMlL/qS
         ysdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N/gaXUT8/WiqfZYZpJ801EjChNyeQDRafZWgA1piv6o=;
        b=a8qnabvX5wEklAODaotTeYdvgK3i7EP2TYRE/GAgzmamCT7TbVB3vK2VnFIeKPWwqJ
         vPrU5WvNmIRXirGSQQNR+i02YoUzpXLuUX6fN3M674x3iHWf3atd4yKvJTlW3eDhaZEv
         WOlGV6Pd1KzdYLGiFLXZSjhvvg6LruyfZmphchMQQqA0FwaEBS1M9tjvmD0uFuRyPpsF
         6/mvo9n9cX63uZVQJnfmIbdXpPMhqMc3b98ICMHyiwotybl18GmXv33p8QJUPiggDbZp
         3aHJ0a95LTU4PHb/On+UN3EeLxnAc8v6bxIJGEple/PHrznkosF7l6NRRMGUJT4q3EZd
         izMg==
X-Gm-Message-State: AOPr4FV+JxS3uOImWUB/4BqL9LcO/w4hWtg9pKvFCL+r87dz59iU1uVkrgxfVEu9DYGaflag
X-Received: by 10.98.18.80 with SMTP id a77mr50027788pfj.27.1463454839306;
        Mon, 16 May 2016 20:13:59 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:d9b2:8bac:9e16:6023])
        by smtp.gmail.com with ESMTPSA id eh9sm468566pad.47.2016.05.16.20.13.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 16 May 2016 20:13:58 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.401.g9c0faef
In-Reply-To: <20160517031353.23707-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294835>

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
2.8.2.401.g9c0faef
