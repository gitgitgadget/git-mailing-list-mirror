Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XboQHHyp"
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE956D6C
	for <git@vger.kernel.org>; Thu, 23 Nov 2023 19:35:23 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50943ccbbaeso2007837e87.2
        for <git@vger.kernel.org>; Thu, 23 Nov 2023 19:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700796921; x=1701401721; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MwBXdyRTqAo3kOhCtwL4jQf8bnztXPotw3YylUMm43Y=;
        b=XboQHHypzXX2aVBa7bXkQUnBzwOFtM4pDHmTzPWM7u2D1xgG6IzsD3P+viKSSowCMl
         tDITlrWSP8PQ9Ian9EiWx7+65XSoNgNq5W6hmaWgglMngnZq+zBiwRY6glapVlSA8oGA
         wp+btXuks+b2+x8SGvITfSdF6J0//wkiDNzL02vSIJVrvPZAVPR87MFhg7QYA7YB/gsE
         /b+039xZw3/hVPkq1VmEGTh8BHZOxW6xoJoFwY5BwNut4hKf2Kwux7/e3RojDiEYL2qO
         +LbGcqcShOwI4mvuCU9vG84ronLlFv//xidTjRR0pShTEmVouV77UwSLWsthqOjREMoc
         UeFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700796921; x=1701401721;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MwBXdyRTqAo3kOhCtwL4jQf8bnztXPotw3YylUMm43Y=;
        b=HRZcL5vdlfL6R2PO6QxuVrLsZewuYpeBKn8lnYVMY6xVHa3x3E0IeIM9JkWTXPpbxC
         svqnDNpXgLp7gSPqxEPjLYsJcG3PNy3kNM/JfFgrnrokF8zVbubiGfjkc4ecSJNNf6In
         fEI2mBzYGhJMWDAhDhmFOxbvf9olf5hb76rCsZJ/4JiN+ilAt/EYYoHMSDdpzy+gnmQH
         gA6tqY1Z1qsEgi7mTgja7dCYgzDYHQ9YxDnvFSz9cJawt2DaVJFnSW0kQGka/QZtwYN6
         YvHeSCOcKud7ybWyQCwkrYlobShGnOlxPHw7b3RSglorXPw3AVfDbzkR3JJaLxiFB+NH
         1AEA==
X-Gm-Message-State: AOJu0Yyb6eHZtcYaxDKS7+jOCvdLN9idvcjvAxPu/PDGbRYWPurLrp2s
	lKM+uJi1TeIdY82SQs6LLV9f6PZ6H1M=
X-Google-Smtp-Source: AGHT+IEPAmWS25VbFYN/qSkqVdLnV0QL6JA6B2gmhIj6hLrmk9KKVVdmI1mF4D31Y0PM0tLO3Rh6uQ==
X-Received: by 2002:ac2:548e:0:b0:50a:a91b:1922 with SMTP id t14-20020ac2548e000000b0050aa91b1922mr658948lfk.47.1700796920948;
        Thu, 23 Nov 2023 19:35:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c3-20020a05600c0ac300b004064288597bsm3645719wmr.30.2023.11.23.19.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 19:35:20 -0800 (PST)
Message-ID: <649ce9a9bd4f2542c3b80c651df92e5a635addcc.1700796916.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1589.v3.git.1700796916.gitgitgadget@gmail.com>
References: <pull.1589.v2.git.1695553041.gitgitgadget@gmail.com>
	<pull.1589.v3.git.1700796916.gitgitgadget@gmail.com>
From: "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 24 Nov 2023 03:35:14 +0000
Subject: [PATCH v3 3/4] doc: update links for andre-simon.de
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

Beyond the fact that it's somewhat traditional to respect sites'
self-identification, it's helpful for links to point to the things
that people expect them to reference. Here that means linking to
specific pages instead of a domain.

Signed-off-by: Josh Soref <jsoref@gmail.com>
---
 Documentation/gitweb.conf.txt | 2 +-
 gitweb/INSTALL                | 2 +-
 gitweb/gitweb.perl            | 4 ++--
 gitweb/static/gitweb.css      | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
index 20df3f0e253..59fc1d27419 100644
--- a/Documentation/gitweb.conf.txt
+++ b/Documentation/gitweb.conf.txt
@@ -242,7 +242,7 @@ $mimetypes_file::
 
 $highlight_bin::
 	Path to the highlight executable to use (it must be the one from
-	http://www.andre-simon.de[] due to assumptions about parameters and output).
+	http://andre-simon.de/zip/download.php[] due to assumptions about parameters and output).
 	By default set to 'highlight'; set it to full path to highlight
 	executable if it is not installed on your web server's PATH.
 	Note that 'highlight' feature must be set for gitweb to actually
diff --git a/gitweb/INSTALL b/gitweb/INSTALL
index a58e6b3c44b..0f8bc39ad84 100644
--- a/gitweb/INSTALL
+++ b/gitweb/INSTALL
@@ -203,7 +203,7 @@ You can specify the following configuration variables when building GIT:
    created.  [Default: /etc/gitweb.conf]
  * HIGHLIGHT_BIN
    Path to the highlight executable to use (must be the one from
-   http://www.andre-simon.de due to assumptions about parameters and output).
+   http://andre-simon.de/zip/download.php due to assumptions about parameters and output).
    Useful if highlight is not installed on your webserver's PATH.
    [Default: highlight]
 
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d23468690ed..b6659410ef1 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -197,7 +197,7 @@ our @diff_opts = ('-M'); # taken from git_commit
 our $prevent_xss = 0;
 
 # Path to the highlight executable to use (must be the one from
-# http://www.andre-simon.de due to assumptions about parameters and output).
+# http://andre-simon.de/zip/download.php due to assumptions about parameters and output).
 # Useful if highlight is not installed on your webserver's PATH.
 # [Default: highlight]
 our $highlight_bin = "++HIGHLIGHT_BIN++";
@@ -269,7 +269,7 @@ our %avatar_size = (
 # Leave it undefined (or set to 'undef') to turn off load checking.
 our $maxload = 300;
 
-# configuration for 'highlight' (http://www.andre-simon.de/)
+# configuration for 'highlight' (http://andre-simon.de/doku/highlight/en/highlight.php)
 # match by basename
 our %highlight_basename = (
 	#'Program' => 'py',
diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
index 32126010326..48d2e510154 100644
--- a/gitweb/static/gitweb.css
+++ b/gitweb/static/gitweb.css
@@ -667,7 +667,7 @@ div.remote {
 }
 
 
-/* Style definition generated by highlight 2.4.5, http://www.andre-simon.de/ */
+/* Style definition generated by highlight 2.4.5, http://andre-simon.de/doku/highlight/en/highlight.php */
 
 /* Highlighting theme definition: */
 
-- 
gitgitgadget

