From: Dave Borowitz <dborowitz@google.com>
Subject: [PATCH 2/7] Documentation/git-send-pack.txt: Flow long synopsis line
Date: Thu, 13 Aug 2015 15:00:46 -0400
Message-ID: <1439492451-11233-3-git-send-email-dborowitz@google.com>
References: <1439492451-11233-1-git-send-email-dborowitz@google.com>
Cc: Dave Borowitz <dborowitz@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 13 21:01:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPxki-0003Kw-FW
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 21:01:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753858AbbHMTBU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2015 15:01:20 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:32832 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753532AbbHMTA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2015 15:00:57 -0400
Received: by iods203 with SMTP id s203so62160517iod.0
        for <git@vger.kernel.org>; Thu, 13 Aug 2015 12:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MjT1KgrHogw8pONMb3Yj8Sx+b8V5XCmJ+OG2crsjWcE=;
        b=VeuP1FjeFBhDVAES4csT+BKnPS3DHXe4/QuhmZ+f13EhOCr0XVXFru1pFNx9CLuRO2
         s4cRYkXGT+RsZEDUSVtModvBsUl6T9fYv+Aua6xcsEsBqngXxy4SeiQsE7goF72oCal+
         04qjkxElPlO/1JsoAMaC0JVnLO/9NiNCnc8Rkozg4dUgKvJm4deiRADdQOuUcp1N/JFJ
         eM3y721vJBkdYVw2Z+2EK+n/CVn84egjQzKt+GdrrvgJ3BRPCJ2qTUudnXXPOwVAuKtl
         QnTpgH62Hl19ZNt8AtRsXMmywP/FI9veuSBbGnoZm5hDAXUR5Vn97j0H17fYZIgkKLH5
         s+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MjT1KgrHogw8pONMb3Yj8Sx+b8V5XCmJ+OG2crsjWcE=;
        b=lrfUi/WS+lVfVdjKqryuD1q8ogeV9QywQDdJZeOyd72+PG4ndI0YRHoXGxaAJ0PTjB
         uPj/8zEh8Wkc+COmgh3zA2H0xGqECELclB8PwK4RrwElYqj9keo0B48o0sPNeaRcC9/H
         w4IUpyDXr2YrbzNBWzXvrucnfpllWoiDr/SyFpeeKHiLapDUNJaYZZ69CSS6k9Rb47EH
         JpkmN0HsUveO4xDzK3o9DeFZK6c5tFPfC4nF/rrg+nnilu+V8RaV+CJTkfwBi5pIM6JK
         c0a/mRgifZCtu14V98SwTXAS1O7nibNKv83mxlxAuQdXnNd1nbLvsnTtpCZsdIeS8lML
         CaRQ==
X-Gm-Message-State: ALoCoQnhW/qJirjNITr6+6L7n9TtlQamroVqN2GoHI9fYyeD+0Gf0b7ZUHETGAektHoQSroqjUhA
X-Received: by 10.107.33.18 with SMTP id h18mr36942325ioh.148.1439492456986;
        Thu, 13 Aug 2015 12:00:56 -0700 (PDT)
Received: from serval.arb.corp.google.com ([172.29.229.12])
        by smtp.gmail.com with ESMTPSA id c91sm2078646ioj.43.2015.08.13.12.00.56
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Aug 2015 12:00:56 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.276.gf5e568e
In-Reply-To: <1439492451-11233-1-git-send-email-dborowitz@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275882>

Signed-off-by: Dave Borowitz <dborowitz@google.com>
---
 Documentation/git-send-pack.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
index b5d09f7..6affff6 100644
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -9,7 +9,8 @@ git-send-pack - Push objects over Git protocol to another repository
 SYNOPSIS
 --------
 [verse]
-'git send-pack' [--all] [--dry-run] [--force] [--receive-pack=<git-receive-pack>] [--verbose] [--thin] [--atomic] [<host>:]<directory> [<ref>...]
+'git send-pack' [--all] [--dry-run] [--force] [--receive-pack=<git-receive-pack>]
+		[--verbose] [--thin] [--atomic] [<host>:]<directory> [<ref>...]
 
 DESCRIPTION
 -----------
-- 
2.5.0.276.gf5e568e
