From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] date.c: phrase a comment gender neutral
Date: Tue, 18 Nov 2014 11:24:28 -0800
Message-ID: <1416338668-30683-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 18 20:24:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqoOC-0008UU-Ku
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 20:24:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754379AbaKRTYc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 14:24:32 -0500
Received: from mail-ig0-f180.google.com ([209.85.213.180]:45704 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753903AbaKRTYc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 14:24:32 -0500
Received: by mail-ig0-f180.google.com with SMTP id h15so7685385igd.1
        for <git@vger.kernel.org>; Tue, 18 Nov 2014 11:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=VMbqJfnbSzKyvIsIcTTC92h0GcplH9w3qkKOdBUIt7o=;
        b=S4E+3+KFhdvaAWL9nkrFqXxs7o96Czmp96vGJtFW5Uv4GRQh/LrEiGjz0Rq+DOuYyh
         po9dQSK8QvvUFAS+Z+uehRQYUgAf7TpHu6L3YRyMvAg4Cephq/1aM6z/903HtEnAo04D
         DOzaNmvMpA8MlvEVeg3yzxaaz3Ml2aaxNMZwCpL2N95TeLkUngAa6B44TA4tou22bKec
         SuAAfoo0KTdhegZGt9nRBbEG2acvyYUoSvU7mmNjRx9rteqvmPeJk9t8BUuh0X/aqpJu
         r/RABB8C+/INJrzerur5cFEm8OXEHD9eoypBcbi3YzbE8pDxoiSSfGlqNwul0pR/Qgeh
         3cJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VMbqJfnbSzKyvIsIcTTC92h0GcplH9w3qkKOdBUIt7o=;
        b=X7yHeEHKLfzJolEAL9TYBrueCMFX/dTQhibeDI5tlC1vB2ERBJFCONKdUcpUOsgKcq
         7avKhQePzw/tRA4RS1h+FJZqG2Fj5XrtLrSFYuMvL8+JPAT+FwBBMe5CHcfg8UJOqjK1
         3BhPFyxb+9pdp9HwtzQvQslYLQWkKw7RO/YxNM+YHGxIzE8lBxl42f1TkG+DN7GIuL1J
         b+MALqdkoukBxE86z/K8OrqkiEnfrqAF050umNfjgwuIMaL1tezYRx+MxvZhBQP11sM/
         JtK0FUeGyciZ3GnAwbLzF+jUazpOhQhyeF8fpfVcs07UAB9KdVYDJO9AFPkUjv0824v7
         1mYQ==
X-Gm-Message-State: ALoCoQlfNTLguMdyO80xQ5cbEWObiR/ofP2u9eS/Hd0+3QAh5umfVz7IoBdzfdETNAEEH2b4VBdZ
X-Received: by 10.50.4.102 with SMTP id j6mr611154igj.37.1416338671502;
        Tue, 18 Nov 2014 11:24:31 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:d130:77f5:c37c:28a8])
        by mx.google.com with ESMTPSA id c17sm7805973ioc.9.2014.11.18.11.24.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 18 Nov 2014 11:24:31 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.5.gf7b9fb2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When looking for suitable functions to print dates,
I found this gem. Let's make it gender neutral as
nowadays people get upset by this gender debate.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 date.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/date.c b/date.c
index 59dfe57..19fb439 100644
--- a/date.c
+++ b/date.c
@@ -732,7 +732,7 @@ int parse_expiry_date(const char *date, unsigned long *timestamp)
 		/*
 		 * We take over "now" here, which usually translates
 		 * to the current timestamp.  This is because the user
-		 * really means to expire everything she has done in
+		 * really means to expire everything they have done in
 		 * the past, and by definition reflogs are the record
 		 * of the past, and there is nothing from the future
 		 * to be kept.
-- 
2.2.0.rc2.5.gf7b9fb2
