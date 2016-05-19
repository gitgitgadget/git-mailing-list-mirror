From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv8 1/5] string list: improve comment
Date: Wed, 18 May 2016 18:09:31 -0700
Message-ID: <20160519010935.27856-2-sbeller@google.com>
References: <20160519010935.27856-1-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu May 19 03:09:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3CTH-000541-Q3
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 03:09:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752272AbcESBJs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 21:09:48 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36431 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643AbcESBJr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 21:09:47 -0400
Received: by mail-pa0-f45.google.com with SMTP id bt5so22992541pac.3
        for <git@vger.kernel.org>; Wed, 18 May 2016 18:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GIuQqzm8sTaqh0+bRkErlaxzZnTg0m4jQgn5+3Q5lqs=;
        b=GqdL04zfUJGiD5g4fCXbyiAusxhG2OJHOrZmTmJScBqUwfrDkjffEAhacOVelrtNbI
         lLUmq+caoZJVZOmTIrzFPc6GDceiwkZy52pl/j/1s82kjTc/XV/GxfOPN6rUDdn07u9D
         vRQpqNBZxNLjM1tMlcyywev4dRAhNUk5ws+w4qFkRd51LM5UCkQTtdySrRRLoWVza8dS
         H6qJUKszl4suDTX3Fn4WmYjwoha+SPmGpGQWkHvB+U2EDstbJuDvDALS0daRf+XEmBLZ
         ar84phibwGM1RUNxaRL/OeJKRiGLP5l5bIu9rzujP8GghTC6RNmVcQwjGeZuCcNjKCQa
         Uckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GIuQqzm8sTaqh0+bRkErlaxzZnTg0m4jQgn5+3Q5lqs=;
        b=cVjv+ukwPLQhc/ckzg1TFvHrE94rkOonTbRU64OpZxbKsE+JL3IN5nI5GFmNcRaf4e
         WSEgKizuYxaRvD0YmQqshnuv/XvxfYVlYBeg0Y0TvIQIlNqGOC2pLW8klbYe1zN9LB1z
         7KpSTU5GZOpY518xrqzdNKRhAlhwa7ihzUnAyeCOq61Vg/U5JeBQ6Dq6L2Q7n7gHcveK
         6Iqo/X3LltOeIKooOObK8Mt0nys7u1zWf29CdKzUVcgsAEKDBRZZU36Hdx+0EmG+9jMN
         SLCHn40LVW1xWbUYhXcb6rOikAwxf3RbYY/mHGltfOZONxEzAIHj2y0liTnH/Mw7mGQA
         t8jw==
X-Gm-Message-State: AOPr4FUYMEkot51NFxHU3FwrLIR+vd1naSE51GN181Ei0o5bJRPLPTHSXs6IR9OV8hLJVX+r
X-Received: by 10.66.189.65 with SMTP id gg1mr15332055pac.148.1463620186181;
        Wed, 18 May 2016 18:09:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:d468:afb3:b0f0:947e])
        by smtp.gmail.com with ESMTPSA id t62sm14997279pfa.38.2016.05.18.18.09.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 18 May 2016 18:09:45 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.123.g3bde101
In-Reply-To: <20160519010935.27856-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295032>

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
2.8.2.123.g3bde101
