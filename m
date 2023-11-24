Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+525NZR"
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AFCD6F
	for <git@vger.kernel.org>; Thu, 23 Nov 2023 19:35:24 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40a4848c6e1so10148085e9.1
        for <git@vger.kernel.org>; Thu, 23 Nov 2023 19:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700796919; x=1701401719; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTAlyIGj5lwq9xkANFKRh7ugnx/1jVhm0W+BkX5cTx8=;
        b=g+525NZRI4gB1p/cBw/DMYIsKTuKMlFGH9iFLiiakCY52mHkMpQjiHML66UcGHk2D9
         ACc9OxW6r6n+lJ3ghSGzkESnWlcjH0ueOuSpgSgsbM6crQuqrZwmatFNzucFyEO04Hhe
         hZhYOJ3tPEiBVPDvUHxmpY+wbDawKtA2kWR6JycCjPB3XtgAwW1VkSYZhPHaFYd+dFdN
         w7GC3PHGEz6O1fNdGOfbIjDAvmP4acDfM5OAkpB86Kv5igh2pAPkSjoTXdL0vCFyhDO9
         y+UYdZBI0ceDc4R0mFAbjVyp+ZZ0I1/Iy0xdd/zSjMaDsVT0t4uAz4Yn8GPIyl+Bja1k
         AHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700796919; x=1701401719;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jTAlyIGj5lwq9xkANFKRh7ugnx/1jVhm0W+BkX5cTx8=;
        b=WZNquwziKaW7HhEdDP+2htCuM+xC7D0yqrvjEm2i+wTlBbIQg32nHlliHtrtzKspYn
         an04ibe07CSrF9GXdl9CunxL73BjGsum2NM/09UfyEDa0mLHNbzHDoy3/DZpZY0FWlPx
         Z/8DIvldmc5xXJr/IoG7z+A0unqSHXZrqtLNe8kXA4pwzi+5xmNeMbvupEb0V3ozALkW
         LU3V9juSFOdao8SxI1fgAri+zwz++OOqbjwvLFD8HkuH/NA+x9HbTpqm+OxxW4tBYSYc
         y9kQo3qwP3v3vmAJ6T3K7I61nbtcgJGDpHJvUoJkkMGcv4Rxa2tk6jPSte+mN7BWe2+B
         2w4g==
X-Gm-Message-State: AOJu0YzyabX0WWwo6S1TBUoMXbPs/eiSUUo+VtTfJhOC6CRXC+eFJ9Zl
	yA7MK6snL0kF+PBmNmizoDckpaGYfYs=
X-Google-Smtp-Source: AGHT+IEU32iY/9GeDhFKqkmlls5Q+NVuPohcFo5QseIiNI141Dnrl4bu+2XGwljBoD3ZPLBeQXzV0A==
X-Received: by 2002:a7b:cc99:0:b0:408:40e2:773b with SMTP id p25-20020a7bcc99000000b0040840e2773bmr1015827wma.34.1700796919281;
        Thu, 23 Nov 2023 19:35:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id fl8-20020a05600c0b8800b004030e8ff964sm4444906wmb.34.2023.11.23.19.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 19:35:19 -0800 (PST)
Message-ID: <54d3861aedff81f0fe7eaa7d88131f68553296f4.1700796916.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1589.v3.git.1700796916.gitgitgadget@gmail.com>
References: <pull.1589.v2.git.1695553041.gitgitgadget@gmail.com>
	<pull.1589.v3.git.1700796916.gitgitgadget@gmail.com>
From: "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 24 Nov 2023 03:35:12 +0000
Subject: [PATCH v3 1/4] doc: update links to current pages
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Josh Soref <jsoref@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Josh Soref <jsoref@gmail.com>,
    Josh Soref <jsoref@gmail.com>

From: Josh Soref <jsoref@gmail.com>

It's somewhat traditional to respect sites' self-identification.

Signed-off-by: Josh Soref <jsoref@gmail.com>
---
 Documentation/CodingGuidelines     | 2 +-
 Documentation/RelNotes/1.6.2.txt   | 2 +-
 Documentation/RelNotes/1.6.3.txt   | 2 +-
 Documentation/RelNotes/1.6.4.txt   | 2 +-
 Documentation/RelNotes/1.6.5.txt   | 2 +-
 Documentation/RelNotes/1.6.6.txt   | 2 +-
 Documentation/git-cvsimport.txt    | 2 +-
 Documentation/git-format-patch.txt | 4 ++--
 Documentation/git.txt              | 2 +-
 git-gui/git-gui.sh                 | 2 +-
 gitk-git/gitk                      | 2 +-
 gitweb/static/js/lib/common-lib.js | 2 +-
 http.c                             | 2 +-
 imap-send.c                        | 2 +-
 json-writer.h                      | 2 +-
 15 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 8d3a467c013..030a254b376 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -518,7 +518,7 @@ For Perl programs:
 
 For Python scripts:
 
- - We follow PEP-8 (http://www.python.org/dev/peps/pep-0008/).
+ - We follow PEP-8 (https://peps.python.org/pep-0008/).
 
  - As a minimum, we aim to be compatible with Python 2.7.
 
diff --git a/Documentation/RelNotes/1.6.2.txt b/Documentation/RelNotes/1.6.2.txt
index 980adfb3154..166d73c60fb 100644
--- a/Documentation/RelNotes/1.6.2.txt
+++ b/Documentation/RelNotes/1.6.2.txt
@@ -10,7 +10,7 @@ To ease the transition plan, the receiving repository of such a
 push running this release will issue a big warning when the
 configuration variable is missing.  Please refer to:
 
-  http://git.or.cz/gitwiki/GitFaq#non-bare
+  https://archive.kernel.org/oldwiki/git.wiki.kernel.org/index.php/GitFaq.html#non-bare
   https://lore.kernel.org/git/7vbptlsuyv.fsf@gitster.siamese.dyndns.org/
 
 for more details on the reason why this change is needed and the
diff --git a/Documentation/RelNotes/1.6.3.txt b/Documentation/RelNotes/1.6.3.txt
index 4bcff945e01..bbf177fc3c5 100644
--- a/Documentation/RelNotes/1.6.3.txt
+++ b/Documentation/RelNotes/1.6.3.txt
@@ -10,7 +10,7 @@ To ease the transition plan, the receiving repository of such a
 push running this release will issue a big warning when the
 configuration variable is missing.  Please refer to:
 
-  http://git.or.cz/gitwiki/GitFaq#non-bare
+  https://archive.kernel.org/oldwiki/git.wiki.kernel.org/index.php/GitFaq.html#non-bare
   https://lore.kernel.org/git/7vbptlsuyv.fsf@gitster.siamese.dyndns.org/
 
 for more details on the reason why this change is needed and the
diff --git a/Documentation/RelNotes/1.6.4.txt b/Documentation/RelNotes/1.6.4.txt
index a2a34b43a75..0fccfb0bf0b 100644
--- a/Documentation/RelNotes/1.6.4.txt
+++ b/Documentation/RelNotes/1.6.4.txt
@@ -10,7 +10,7 @@ To ease the transition plan, the receiving repository of such a
 push running this release will issue a big warning when the
 configuration variable is missing.  Please refer to:
 
-  http://git.or.cz/gitwiki/GitFaq#non-bare
+  https://archive.kernel.org/oldwiki/git.wiki.kernel.org/index.php/GitFaq.html#non-bare
   https://lore.kernel.org/git/7vbptlsuyv.fsf@gitster.siamese.dyndns.org/
 
 for more details on the reason why this change is needed and the
diff --git a/Documentation/RelNotes/1.6.5.txt b/Documentation/RelNotes/1.6.5.txt
index 6c7f7da7eb9..79cb1b2b6df 100644
--- a/Documentation/RelNotes/1.6.5.txt
+++ b/Documentation/RelNotes/1.6.5.txt
@@ -21,7 +21,7 @@ To ease the transition plan, the receiving repository of such a
 push running this release will issue a big warning when the
 configuration variable is missing.  Please refer to:
 
-  http://git.or.cz/gitwiki/GitFaq#non-bare
+  https://archive.kernel.org/oldwiki/git.wiki.kernel.org/index.php/GitFaq.html#non-bare
   https://lore.kernel.org/git/7vbptlsuyv.fsf@gitster.siamese.dyndns.org/
 
 for more details on the reason why this change is needed and the
diff --git a/Documentation/RelNotes/1.6.6.txt b/Documentation/RelNotes/1.6.6.txt
index 3ed1e014337..88b86a827e8 100644
--- a/Documentation/RelNotes/1.6.6.txt
+++ b/Documentation/RelNotes/1.6.6.txt
@@ -63,7 +63,7 @@ users will fare this time.
 
    Please refer to:
 
-   http://git.or.cz/gitwiki/GitFaq#non-bare
+   https://archive.kernel.org/oldwiki/git.wiki.kernel.org/index.php/GitFaq.html#non-bare
    https://lore.kernel.org/git/7vbptlsuyv.fsf@gitster.siamese.dyndns.org/
 
    for more details on the reason why this change is needed and the
diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index b3f27671a0c..ac03d7686cb 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -22,7 +22,7 @@ DESCRIPTION
 deprecated; it does not work with cvsps version 3 and later.  If you are
 performing a one-shot import of a CVS repository consider using
 http://cvs2svn.tigris.org/cvs2git.html[cvs2git] or
-http://www.catb.org/esr/cvs-fast-export/[cvs-fast-export].
+https://gitlab.com/esr/cvs-fast-export[cvs-fast-export].
 
 Imports a CVS repository into Git. It will either create a new
 repository, or incrementally import into an existing one.
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index aaafce24be2..414da6b73e7 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -610,8 +610,8 @@ Approach #3 (external editor)
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 The following Thunderbird extensions are needed:
-AboutConfig from http://aboutconfig.mozdev.org/ and
-External Editor from http://globs.org/articles.php?lng=en&pg=8
+AboutConfig from https://mjg.github.io/AboutConfig/ and
+External Editor from https://globs.org/articles.php?lng=en&pg=8
 
 1. Prepare the patch as a text file using your method of choice.
 
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 2535a30194f..cf3468b3e99 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -1071,7 +1071,7 @@ Authors
 -------
 Git was started by Linus Torvalds, and is currently maintained by Junio
 C Hamano. Numerous contributions have come from the Git mailing list
-<git@vger.kernel.org>.  http://www.openhub.net/p/git/contributors/summary
+<git@vger.kernel.org>.  https://openhub.net/p/git/contributors/summary
 gives you a more complete list of contributors.
 
 If you have a clone of git.git itself, the
diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 3e5907a4609..2cbeaa483bb 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -2367,7 +2367,7 @@ proc do_quit {{rc {1}}} {
 	set ret_code $rc
 
 	# Briefly enable send again, working around Tk bug
-	# http://sourceforge.net/tracker/?func=detail&atid=112997&aid=1821174&group_id=12997
+	# https://sourceforge.net/p/tktoolkit/bugs/2343/
 	tk appname [appname]
 
 	destroy .
diff --git a/gitk-git/gitk b/gitk-git/gitk
index df3ba2ea99b..dd80ab8f3ba 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -12472,7 +12472,7 @@ if {[tk windowingsystem] eq "aqua"} {
 
 catch {
     # follow the XDG base directory specification by default. See
-    # http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
+    # https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
     if {[info exists env(XDG_CONFIG_HOME)] && $env(XDG_CONFIG_HOME) ne ""} {
         # XDG_CONFIG_HOME environment variable is set
         set config_file [file join $env(XDG_CONFIG_HOME) git gitk]
diff --git a/gitweb/static/js/lib/common-lib.js b/gitweb/static/js/lib/common-lib.js
index 018bbb7d4cb..0fdbc25728d 100644
--- a/gitweb/static/js/lib/common-lib.js
+++ b/gitweb/static/js/lib/common-lib.js
@@ -137,7 +137,7 @@ function addCssRule(selector, style) {
  *   http://www.dustindiaz.com/getelementsbyclass/
  *   http://stackoverflow.com/questions/1818865/do-we-have-getelementsbyclassname-in-javascript
  *
- * See also http://ejohn.org/blog/getelementsbyclassname-speed-comparison/
+ * See also https://johnresig.com/blog/getelementsbyclassname-speed-comparison/
  *
  * @param {String} class: name of _single_ class to find
  * @param {String} [taghint] limit search to given tags
diff --git a/http.c b/http.c
index 8f71bf00d89..8e5c4c91ea7 100644
--- a/http.c
+++ b/http.c
@@ -1902,7 +1902,7 @@ static void write_accept_language(struct strbuf *buf)
 	 * MAX_DECIMAL_PLACES must not be larger than 3. If it is larger than
 	 * that, q-value will be smaller than 0.001, the minimum q-value the
 	 * HTTP specification allows. See
-	 * http://tools.ietf.org/html/rfc7231#section-5.3.1 for q-value.
+	 * https://datatracker.ietf.org/doc/html/rfc7231#section-5.3.1 for q-value.
 	 */
 	const int MAX_DECIMAL_PLACES = 3;
 	const int MAX_LANGUAGE_TAGS = 1000;
diff --git a/imap-send.c b/imap-send.c
index 996651e4f80..3d6fdf64868 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -860,7 +860,7 @@ static void imap_close_store(struct imap_store *ctx)
 
 /*
  * hexchar() and cram() functions are based on the code from the isync
- * project (http://isync.sf.net/).
+ * project (https://isync.sourceforge.io/).
  */
 static char hexchar(unsigned int b)
 {
diff --git a/json-writer.h b/json-writer.h
index 209355e0f12..75f4f99ab00 100644
--- a/json-writer.h
+++ b/json-writer.h
@@ -4,7 +4,7 @@
 /*
  * JSON data structures are defined at:
  * [1] http://www.ietf.org/rfc/rfc7159.txt
- * [2] http://json.org/
+ * [2] https://www.json.org/
  *
  * The JSON-writer API allows one to build JSON data structures using a
  * simple wrapper around a "struct strbuf" buffer.  It is intended as a
-- 
gitgitgadget

