From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv7 1/5] string list: improve comment
Date: Wed, 18 May 2016 12:02:18 -0700
Message-ID: <20160518190222.28105-2-sbeller@google.com>
References: <20160518190222.28105-1-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed May 18 21:02:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b36jq-00023o-9o
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 21:02:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753953AbcERTC3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 15:02:29 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35563 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753349AbcERTC2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 15:02:28 -0400
Received: by mail-pf0-f170.google.com with SMTP id b66so596227pfb.2
        for <git@vger.kernel.org>; Wed, 18 May 2016 12:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WUY6x9SQrcekWP3yWyUva90/Q1sM34P1nZ1m5AmpVrM=;
        b=lg43dwoQCWw4c0/1WDPAUXSHNfSjC9DkH6zG0uYy1GF0BzfPZLOZNd2hIgZpdoUrPn
         MwyA/vH2EsC6KpMJ25nSn6nE468kiZ9n4r4RoOjnaoYtvN8HgTjWHkJMekbBJ1byqC+k
         GhjqTX7Nh+MlxECqz1sEYlCwSfJ9DEr+TxE0xT/YjJ3FWltNv1CzUOhq36Pt/pY1AL9j
         54rI3/NbKYYmEYOORKo25GGAxa7CWsWWuIr6SynFyro50E2oCYxxE2a9FDbzPMU+LY5x
         Uwe2RT8i96gYpMuHvVoiavenkWOwYe6WArKTHfqKhdhhZNLrjgleN1cdeske14K2TTwE
         5VJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WUY6x9SQrcekWP3yWyUva90/Q1sM34P1nZ1m5AmpVrM=;
        b=leUi/I6aPjFcPm6OfVehsH6csTPJJwZhr3a/Si0YSLWZwZ0XhDIkwOIeYrfm1GODuV
         E4AnHpzN2Eg6+t0II0wYukPRdvdpqvfAfH88OmcWFLROnVnt99L7eROKmKZjWElDdprt
         hNg8JTSRguEayHbLIXV8P9FEJFP3CHz1gSq1mpSD7VgAeyxczROTaUx/cU2eKcKL+c3Q
         aQH7vtSH4x4NDM+4P0U/V3+IIJZl+uI4BZaC4IQyBpyc4kO8JK3k2kksJ0f6AxorartY
         fyQc6JsyeVaDVnDV/fH50Zf5YEOvnNKtcqYDxB3y2Dsuuw4kPFbCkytvMd4Ze6tTikju
         vT/w==
X-Gm-Message-State: AOPr4FUAnhbB0ygoSJjDBdqRYTnu666e0k5yVIh32iNWLOtb8/QqeAnevIIz43FtHaudeDxO
X-Received: by 10.98.93.7 with SMTP id r7mr13315419pfb.66.1463598147770;
        Wed, 18 May 2016 12:02:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:d468:afb3:b0f0:947e])
        by smtp.gmail.com with ESMTPSA id k78sm14003603pfk.70.2016.05.18.12.02.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 18 May 2016 12:02:27 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.121.ga97fb08
In-Reply-To: <20160518190222.28105-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294988>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 string-list.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/string-list.h b/string-list.h
index d3809a1..465a1f0 100644
--- a/string-list.h
+++ b/string-list.h
@@ -106,7 +106,7 @@ void unsorted_string_list_delete_item(struct string_list *list, int i, int free_
  * list->strdup_strings must be set, as new memory needs to be
  * allocated to hold the substrings.  If maxsplit is non-negative,
  * then split at most maxsplit times.  Return the number of substrings
- * appended to list.
+ * appended to list. The list may be non-empty already.
  *
  * Examples:
  *   string_list_split(l, "foo:bar:baz", ':', -1) -> ["foo", "bar", "baz"]
-- 
2.8.2.121.ga97fb08
