Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926E627476
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 22:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ye2jeXWT"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61420ED
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 15:28:46 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5afc00161daso47952727b3.1
        for <git@vger.kernel.org>; Tue, 31 Oct 2023 15:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698791325; x=1699396125; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t9HBWOCEKUxSXkT1IcU5St6aM3a2nN0UYhwsakuLLKc=;
        b=Ye2jeXWTSgRnGSZVj6s58qe9kHYBpuDedhh/uFiUw+JGNt7Azo+QjUUXo44Sp/S6Dp
         FFn39skPC23s3dxZb1UK+Wmo9qGMKnI7Rp9bt7jpYc9fvvTASOCkFdxdoswJASFIs5st
         ERgNNadvNhvU25QUmr4qH8mPJKf5OrEm60ipzMc5YeFGHkLTK/zLFfFs8vsG53n99eeY
         uITg2ISucpYZKulpZs5+bGGByD7WLOkrTCID97jmY8eIOz2jbpzDvlPzQiCkyXQ8V6nB
         4JSCEYJFMW8Le+ujZIvdreqCZeE6/Ij20ejVkTY3m+RtnFyIUEUYAF14VB4zwSt7zJUK
         iJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698791325; x=1699396125;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t9HBWOCEKUxSXkT1IcU5St6aM3a2nN0UYhwsakuLLKc=;
        b=qIFed7nXRcMOxoRn9YukOSaU+wHtL/mNKuADP1BkPGf4fqy3A1IT3mwu/0NHNBx6uy
         cJT86iV+F1uCImWapWlIA1Rh/IVOJEVHRS+ICMfdqlcS4OVpUG+aB1OkSW7LkvyQrHeZ
         WFbc2Feur7o/7fgQg314Qa9Z8snYYupUnsVJ5RYta7fdG+wacZk5qyNwjFeW6684KkGA
         01wMUFKAp2eHhN/zYVErbzY0jZyHScmzwXlVGR5DVZToLNVUUf4tYyiQ9Z46kSsoN0Fe
         G0SftRCESVgURFZZrN1MkrGfzjhJugHZ0yc5Pztlx+BZo07VHPwYPXnVYN04oFQsQUd+
         TzwA==
X-Gm-Message-State: AOJu0YwW3DO72KzM6umHEgMSRmkhbkAtX1Zz+ansPexEgLHrlNRF35GE
	2dS0qA+N0lb1YfNPf3+m80I5WHzgEBSAn408oeD0hlamcbq724PLi+iuIiu6RRpGy6V/YDmyOAc
	lQKYebJdXmTg0x2kfTk6054lr5etShXpIwCJlRinpFG/hvZZgbMabeNNUCvoA7NiLmHIZyHFM+r
	Qe
X-Google-Smtp-Source: AGHT+IHOeg1McY/IVugcAzTSZLHINozbF4NWIrtRfq2PjDioKBNS0WB0NpFeTi6iPofhkgj7XDtAexuvEAvN+aTv3C3Q
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:70a1:f59a:2e01:c62e])
 (user=jonathantanmy job=sendgmr) by 2002:a0d:d54b:0:b0:59b:e684:3c7a with
 SMTP id x72-20020a0dd54b000000b0059be6843c7amr270488ywd.4.1698791325550; Tue,
 31 Oct 2023 15:28:45 -0700 (PDT)
Date: Tue, 31 Oct 2023 15:28:33 -0700
In-Reply-To: <cover.1698791220.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <db6702ba-11a7-44c1-af2a-95b080aaeb77@gmail.com> <cover.1698791220.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <4097385820973b30a78f2e45741444a3f6eee98d.1698791220.git.jonathantanmy@google.com>
Subject: [PATCH v2 4/4] strbuf: move env-using functions to environment.c
From: Jonathan Tan <jonathantanmy@google.com>
To: git@vger.kernel.org
Cc: Jonathan Tan <jonathantanmy@google.com>, Dragan Simic <dsimic@manjaro.org>, 
	Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

This eliminates the dependency from strbuf to environment.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 environment.c | 32 ++++++++++++++++++++++++++++++++
 environment.h | 14 ++++++++++++++
 strbuf.c      | 32 --------------------------------
 strbuf.h      | 15 ---------------
 4 files changed, 46 insertions(+), 47 deletions(-)

diff --git a/environment.c b/environment.c
index bb3c2a96a3..942c5b8dd3 100644
--- a/environment.c
+++ b/environment.c
@@ -18,6 +18,7 @@
 #include "refs.h"
 #include "fmt-merge-msg.h"
 #include "commit.h"
+#include "strbuf.h"
 #include "strvec.h"
 #include "object-file.h"
 #include "object-store-ll.h"
@@ -416,3 +417,34 @@ int print_sha1_ellipsis(void)
 	}
 	return cached_result;
 }
+
+void strbuf_commented_addf(struct strbuf *sb,
+			   const char *fmt, ...)
+{
+	va_list params;
+	struct strbuf buf = STRBUF_INIT;
+	int incomplete_line = sb->len && sb->buf[sb->len - 1] != '\n';
+
+	va_start(params, fmt);
+	strbuf_vaddf(&buf, fmt, params);
+	va_end(params);
+
+	strbuf_add_commented_lines(sb, buf.buf, buf.len);
+	if (incomplete_line)
+		sb->buf[--sb->len] = '\0';
+
+	strbuf_release(&buf);
+}
+
+void strbuf_add_commented_lines(struct strbuf *out,
+				const char *buf, size_t size)
+{
+	static char prefix1[3];
+	static char prefix2[2];
+
+	if (prefix1[0] != comment_line_char) {
+		xsnprintf(prefix1, sizeof(prefix1), "%c ", comment_line_char);
+		xsnprintf(prefix2, sizeof(prefix2), "%c", comment_line_char);
+	}
+	strbuf_add_lines_varied_prefix(out, prefix1, prefix2, buf, size);
+}
diff --git a/environment.h b/environment.h
index e5351c9dd9..f801dbe36e 100644
--- a/environment.h
+++ b/environment.h
@@ -229,4 +229,18 @@ extern const char *excludes_file;
  */
 int print_sha1_ellipsis(void);
 
+/**
+ * Add a formatted string prepended by a comment character and a
+ * blank to the buffer.
+ */
+__attribute__((format (printf, 2, 3)))
+void strbuf_commented_addf(struct strbuf *sb, const char *fmt, ...);
+
+/**
+ * Add a NUL-terminated string to the buffer. Each line will be prepended
+ * by a comment character and a blank.
+ */
+void strbuf_add_commented_lines(struct strbuf *out,
+				const char *buf, size_t size);
+
 #endif
diff --git a/strbuf.c b/strbuf.c
index d5ee8874f8..f6c1978ecf 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "environment.h"
 #include "gettext.h"
 #include "hex-ll.h"
 #include "strbuf.h"
@@ -360,37 +359,6 @@ void strbuf_add_lines_varied_prefix(struct strbuf *sb,
 	strbuf_complete_line(sb);
 }
 
-void strbuf_add_commented_lines(struct strbuf *out,
-				const char *buf, size_t size)
-{
-	static char prefix1[3];
-	static char prefix2[2];
-
-	if (prefix1[0] != comment_line_char) {
-		xsnprintf(prefix1, sizeof(prefix1), "%c ", comment_line_char);
-		xsnprintf(prefix2, sizeof(prefix2), "%c", comment_line_char);
-	}
-	strbuf_add_lines_varied_prefix(out, prefix1, prefix2, buf, size);
-}
-
-void strbuf_commented_addf(struct strbuf *sb,
-			   const char *fmt, ...)
-{
-	va_list params;
-	struct strbuf buf = STRBUF_INIT;
-	int incomplete_line = sb->len && sb->buf[sb->len - 1] != '\n';
-
-	va_start(params, fmt);
-	strbuf_vaddf(&buf, fmt, params);
-	va_end(params);
-
-	strbuf_add_commented_lines(sb, buf.buf, buf.len);
-	if (incomplete_line)
-		sb->buf[--sb->len] = '\0';
-
-	strbuf_release(&buf);
-}
-
 void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap)
 {
 	int len;
diff --git a/strbuf.h b/strbuf.h
index a9333ac1ad..d5f0d4c579 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -282,14 +282,6 @@ void strbuf_remove(struct strbuf *sb, size_t pos, size_t len);
 void strbuf_splice(struct strbuf *sb, size_t pos, size_t len,
 		   const void *data, size_t data_len);
 
-/**
- * Add a NUL-terminated string to the buffer. Each line will be prepended
- * by a comment character and a blank.
- */
-void strbuf_add_commented_lines(struct strbuf *out,
-				const char *buf, size_t size);
-
-
 /**
  * Add data of given length to the buffer.
  */
@@ -373,13 +365,6 @@ void strbuf_humanise_rate(struct strbuf *buf, off_t bytes);
 __attribute__((format (printf,2,3)))
 void strbuf_addf(struct strbuf *sb, const char *fmt, ...);
 
-/**
- * Add a formatted string prepended by a comment character and a
- * blank to the buffer.
- */
-__attribute__((format (printf, 2, 3)))
-void strbuf_commented_addf(struct strbuf *sb, const char *fmt, ...);
-
 __attribute__((format (printf,2,0)))
 void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
 
-- 
2.42.0.820.g83a721a137-goog

