Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADAB1C68E
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 18:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W68BUF2W"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-32f8441dfb5so10239703f8f.0
        for <git@vger.kernel.org>; Wed, 03 Jan 2024 10:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704305664; x=1704910464; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ANH8HcJdaJ7cE1l4sP7xyxycfU2sQT+Ku0x5Qj+7b3k=;
        b=W68BUF2WAOT93p2kx5CdlXXpzFj70R6jtAFBI0Io4iUKbkEZKvTVlmcrZK8+1kYe7j
         X+ePTmaUfwVksBA2Ih+tdDfmkyXuHeGdU9CE6qQl533tsfKy/cZ+B/iYCMdBJfZVS/jd
         BN08RzmSAvKmlcd7p3f5trFc6DjnaoF7Pqb4hnhaqacRDHb8rV24eRnvd0LceyJqIAz/
         wFdymaCHtotTigSyLIF29jeUZ833FAi7JBeesjbIlGxgfG1YpLcW7FFlruRMDRQHGvWj
         b4ITgsNmwzayNJqrVowhM8Yzqlk4728NymthyfGYo0Q1aTFcrWkpYZjExy5C4e54qlZA
         p1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704305664; x=1704910464;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ANH8HcJdaJ7cE1l4sP7xyxycfU2sQT+Ku0x5Qj+7b3k=;
        b=OYfOli8yK1E1z9UqxiEXR8P+zWw6GzbA2A/dTW0rPFDcH8SWvik1rr0nuAQqyuxLO6
         CKNtSexXhz9DUoyHGP0d6gkf1D3Cn6X8U2ZDqBDyBHCGlzsaLD5dmfBEJyAg8swh6qZk
         PCLlPK4howcjtL3nhiwWHyLK5MxiGvmvaIZUiZRaPjefCA4754Rp3qVdvZuQYV6A5NFd
         uXBWrNpkgBaC6S/nikesxO8fhJS7w08oVfH2Fu0z80gtCF1ExwxmNWjQJ51N0XHv2tY7
         e5SYlc0nC5UQjbpSelJbmvMT66fqIyunShksBHXVPgYgZ4Y+6Q8DZLzMU91BwryiZJes
         3TwA==
X-Gm-Message-State: AOJu0YwydVqTnlaA76dtuenGuqVKIqMQ27On96UP7xLPsWYSxEiC6Z6o
	/C/udGcgLIJnymv8KFwrMbqNDH4R6Dk=
X-Google-Smtp-Source: AGHT+IEcGUVEvBtoHDF4Y0NA0b+qnYZt3QeYMhESEL+ccLM7YXWH8RbvgcRXiJNic62tjuZZQ2YFWg==
X-Received: by 2002:adf:f043:0:b0:337:2e14:6335 with SMTP id t3-20020adff043000000b003372e146335mr2975061wro.38.1704305664059;
        Wed, 03 Jan 2024 10:14:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b7-20020a5d45c7000000b00336c6b77584sm22143874wrs.91.2024.01.03.10.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 10:14:23 -0800 (PST)
Message-ID: <pull.1629.git.git.1704305663254.gitgitgadget@gmail.com>
From: "Maarten van der Schrieck via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 03 Jan 2024 18:14:23 +0000
Subject: [PATCH] Documentation: fix statement about rebase.instructionFormat
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
Cc: Maarten van der Schrieck <maarten@thingsconnected.nl>,
    Maarten van der Schrieck <maarten@thingsconnected.nl>

From: Maarten van der Schrieck <maarten@thingsconnected.nl>

Since commit 62db5247790f2612c0b407a15d1901d88789d35a "rebase -i: generate
the script via rebase--helper" (Jul 14 2017), the short hash is given in
rebase-todo. Specifying rebase.instructionFormat does not alter this
behavior, contrary to what the documentation implies.

Signed-off-by: Maarten van der Schrieck <maarten@thingsconnected.nl>
---
    Documentation: fix statement about rebase.instructionFormat
    
    Since commit 62db5247790f2612c0b407a15d1901d88789d35a "rebase -i:
    generate the script via rebase--helper" (Jul 14 2017), the short hash is
    given in rebase-todo. Specifying rebase.instructionFormat does not alter
    this behavior, contrary to what the documentation implies.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1629%2Fthingsconnected%2Fpullreq1-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1629/thingsconnected/pullreq1-v1
Pull-Request: https://github.com/git/git/pull/1629

 Documentation/config/rebase.txt | 2 +-
 Documentation/git-rebase.txt    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/rebase.txt b/Documentation/config/rebase.txt
index d59576dbb23..c6187ab28b2 100644
--- a/Documentation/config/rebase.txt
+++ b/Documentation/config/rebase.txt
@@ -40,7 +40,7 @@ rebase.missingCommitsCheck::
 rebase.instructionFormat::
 	A format string, as specified in linkgit:git-log[1], to be used for the
 	todo list during an interactive rebase.  The format will
-	automatically have the long commit hash prepended to the format.
+	automatically have the commit hash prepended to the format.
 
 rebase.abbreviateCommands::
 	If set to true, `git rebase` will use abbreviated command names in the
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 1dd6555f66b..25516c45d8b 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -523,7 +523,7 @@ See also INCOMPATIBLE OPTIONS below.
 +
 The commit list format can be changed by setting the configuration option
 rebase.instructionFormat.  A customized instruction format will automatically
-have the long commit hash prepended to the format.
+have the commit hash prepended to the format.
 +
 See also INCOMPATIBLE OPTIONS below.
 

base-commit: 055bb6e9969085777b7fab83e3fee0017654f134
-- 
gitgitgadget
