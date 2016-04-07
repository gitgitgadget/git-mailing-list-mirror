From: David Turner <dturner@twopensource.com>
Subject: [PATCH 04/24] t1430: clean up broken refs/tags/shadow
Date: Thu,  7 Apr 2016 15:02:51 -0400
Message-ID: <1460055791-23313-5-git-send-email-dturner@twopensource.com>
References: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Apr 07 21:04:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoFEd-0007wR-IG
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 21:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757388AbcDGTEo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 15:04:44 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:34894 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756683AbcDGTD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 15:03:27 -0400
Received: by mail-qg0-f42.google.com with SMTP id f105so47940863qge.2
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 12:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=J85H1x9bTXSLlpP0AS7upodd61mtWS+Op0ntRAmT41c=;
        b=ZH7xDox+3tDIzvhBqMKGrLp/uR8AMzy9BWlosKQTgCUYI6qiCCgZrLWUohAE5cPdlq
         KxZfpT1baqZqZmxR0my9m/2pmK2r6IVOKqjdbktctRgnomCFo2dzv6s2PDpgB8XbtJ7i
         olAbx9sT5fsJIn2Jj+ulk9p6l7Ixr3lSQjgbPfFR1iWowMDKglZy5AJdBj1y/GzcPiCU
         9+Z9jk3dYFDfbFQw5h4FG7hClBdOTXIBir/g3Pk365B29cQBg2GR6pg8gU8kGpcTT0ih
         Wk4KD9nZ9FbX5X0a38tp7xon0j1cryGgn8H6PYlf+w+ontDJ5uiD30c60U4hvtmEa+Sm
         l/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=J85H1x9bTXSLlpP0AS7upodd61mtWS+Op0ntRAmT41c=;
        b=lrh9qv5v86siqg5gyG0KUuu82Se1NlXLXqEsIoKbOVvPEpXRT1Rgy+EGw5ITT+eqtH
         btZEgHzHdSwyDPtBmogKSYr894D/0q1T2nQsaApA0e0gXgLhDR9MNXQPoDKvlS5RMQ7l
         h6P8sk6HImNKoB2Z/LsyHLKyyvBdhyZMYPWEXeCnlWuX4Q+65tpV/IGlB4kGAqEEdCEC
         ZdOSPdZoK8yKq+Cuk8BL/41fXuLqzJDlbGn6jFFchZSJssGzCfBpxzhff4y/IpABFsvM
         f1aSq2/NEisGZYOImZhVXthDP5iDUC6sZ3vMxWyu+gmmNImaQ8OXPCo8vUx5RmMSsKmU
         phBQ==
X-Gm-Message-State: AD7BkJJsXGsciN4bZF8lVnpoB/smtvsWNbo/kZ5l8PhVbkeOkb8Qbp6PqoJTY/vIGO7Z2w==
X-Received: by 10.140.131.81 with SMTP id 78mr6310442qhd.34.1460055805298;
        Thu, 07 Apr 2016 12:03:25 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id e11sm3959273qkb.39.2016.04.07.12.03.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Apr 2016 12:03:24 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290971>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t1430-bad-ref-name.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
index 005e2b1..cb815ab 100755
--- a/t/t1430-bad-ref-name.sh
+++ b/t/t1430-bad-ref-name.sh
@@ -148,7 +148,7 @@ test_expect_success 'rev-parse skips symref pointing to broken name' '
 	git branch shadow one &&
 	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
 	git symbolic-ref refs/tags/shadow refs/heads/broken...ref &&
-
+	test_when_finished "rm -f .git/refs/tags/shadow" &&
 	git rev-parse --verify one >expect &&
 	git rev-parse --verify shadow >actual 2>err &&
 	test_cmp expect actual &&
-- 
2.4.2.767.g62658d5-twtrsrc
