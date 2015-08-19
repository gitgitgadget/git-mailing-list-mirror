From: Dave Borowitz <dborowitz@google.com>
Subject: [PATCH v2 2/9] Documentation/git-send-pack.txt: Flow long synopsis line
Date: Wed, 19 Aug 2015 11:26:40 -0400
Message-ID: <1439998007-28719-3-git-send-email-dborowitz@google.com>
References: <1439998007-28719-1-git-send-email-dborowitz@google.com>
Cc: Dave Borowitz <dborowitz@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Aug 19 17:27:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZS5Gy-0004yA-PM
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 17:27:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907AbbHSP1Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2015 11:27:16 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:35391 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942AbbHSP1P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 11:27:15 -0400
Received: by iodt126 with SMTP id t126so12997102iod.2
        for <git@vger.kernel.org>; Wed, 19 Aug 2015 08:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MjT1KgrHogw8pONMb3Yj8Sx+b8V5XCmJ+OG2crsjWcE=;
        b=coImT1uWbdwcoQI58q4VLdB0D6MxVobgEMf0fWrJNnmeOArxQYyNr/twyi7u/h/VQt
         L/ktEFOByaSjjCEHRhDGNwlvUCGASfWbGgrurHDIQfSnrwX3G1L0bIsr0TTOMcMqztp+
         yE7XzcViteuokrzm7Axzu3av/VMWQnI6F6uuTvfoxfDXqHoGCcoNullCZRIhfuJshqsf
         LyUE0c2dg27f6QBTyQV8VtzhZxzwB32xFKED7robYmB9ODQ5zeh3nMFMT+gUZJ7QIroG
         Blsh9ijSvVkCyi1bjZTiEGNo5ES/Pq9KCh5+G+M9tu6hXnWSwzXbBpliDR/kuxddlO5y
         wzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MjT1KgrHogw8pONMb3Yj8Sx+b8V5XCmJ+OG2crsjWcE=;
        b=bsyei/vHQsbJ9ilCqYkqYwInjBpnRI671WLo8NGzD7N0z343CX9jmCjPqs99W4pxfe
         BSeh+3tt+ZzGytc8GTvVjwLcizUQcxrSgymCN1vkdArX216Y4rBDHkfyLvM2gCd9EipQ
         tmaFT075Tfw2JjT4KxE82z6czj0G6fcyO53E4q3kXmK+rRt1V89KdXIKqwXLOi0JXzHy
         ASxARUPOeJH2Yjwa2fKFiUFncHHUF4BA/T3C0KMCtgwMNa/FNoQvGYcHz2/g/5ei58fA
         iI6DZuYtZjR05krypLErNpxvONXRVlCxWJ5Uq0+hzyxpozJSWWiVgXNoMbItOkUPC2G7
         twZg==
X-Gm-Message-State: ALoCoQnxxxWa49gdUxoH/c5f4dwExC3coR4jxtKYiSfmtXCT4L47eLK0Ki3FFqvW2k5+C4JnyZly
X-Received: by 10.107.156.5 with SMTP id f5mr13129379ioe.111.1439998034312;
        Wed, 19 Aug 2015 08:27:14 -0700 (PDT)
Received: from serval.arb.corp.google.com ([172.29.229.12])
        by smtp.gmail.com with ESMTPSA id o19sm2347819igs.18.2015.08.19.08.27.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Aug 2015 08:27:13 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.276.gf5e568e
In-Reply-To: <1439998007-28719-1-git-send-email-dborowitz@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276190>

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
