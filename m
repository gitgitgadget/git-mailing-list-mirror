Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FEF63AD
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 04:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbxKIlcT"
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2CD3868
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 20:02:23 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-32d81864e3fso1492317f8f.2
        for <git@vger.kernel.org>; Fri, 10 Nov 2023 20:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699675342; x=1700280142; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xa1kf0Q0fObpfuD+wuOmeiSrQMsXByfO8rnPJ75hv2I=;
        b=WbxKIlcT++K1QMGvKBsySiGMm4vlECDJWMAVasOD5p+iIM91uvbqIRZPgMo9Wefumo
         o2XkIhncFxkWndCVplNOEnPPOtxxmVzTXENJwK0Z5MmOPGJM9GddXeF/3R+Xr5pztj+D
         fhlHzXXyjikR2h3xX6GFQueljvwv3zpX1vqMm5XP67AbB5uBljYg4hb2vN7Y670xAsCY
         c0UepD/LFDBgG2+BSyW699PXZBmzQW0+VcuP78PGszbC7C96ZvKjBXpaQn6YyU+pH3TB
         EKXnygkLavcPxNN/GDforBnJClTloi5uHXsQaGU2mCxo3LLhcVK51Mc/TaJt1RZKj4K5
         TyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699675342; x=1700280142;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xa1kf0Q0fObpfuD+wuOmeiSrQMsXByfO8rnPJ75hv2I=;
        b=M5/iSCTmVBwtRuf7SkMZoiQthLb7hnkm1SqsdH6EwzogqVCogaDu9cPXLYSe7G2ZBR
         dmmlZ/Li84At49QFkUVR8Pz9nOaQ1/y38UODakg8wcfqmIlqqFfKD/iC7XgbhtVPA+yW
         DNw3ttFQnWhjS+2av4/5QVKQc7W/iGHSiM6jvWwC7LVcE0+uaiYPyAYtgCgZ/EKMr8X8
         ePUxm2oe6hdSZ40tJa+tVtc1Eq9T60sUkIO0L3FwQmkhYNxV9ielPDFJ44wn3pkKEWBm
         0eoOr3SbECd1rZXm2jcoAqipgeB6/SXnsdxpTuLV+bhQsZCj2vYwuPF75uIaquV06CNv
         gbtA==
X-Gm-Message-State: AOJu0Yw0IqLat47OpFUvK8+oMGrJgtTVzlIA/a3YHUqBUeSXUiMnbsfG
	0maoAV93nGFkrvPUsR4mpqAkA5kZ684=
X-Google-Smtp-Source: AGHT+IEPAk71FoGLWe6gSrgOu0iSO+GhDSg+WHFjHowrT2SRS7UARMtvy9A8lZ9ckb+G1ksWqdmXaA==
X-Received: by 2002:a5d:64c7:0:b0:32c:eeee:d438 with SMTP id f7-20020a5d64c7000000b0032ceeeed438mr669991wri.54.1699675341426;
        Fri, 10 Nov 2023 20:02:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v2-20020adfa1c2000000b0032fc5f5abafsm636334wrv.96.2023.11.10.20.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 20:02:21 -0800 (PST)
Message-ID: <pull.1611.git.1699675340400.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 11 Nov 2023 04:02:20 +0000
Subject: [PATCH] RelNotes: minor wording fixes in 2.43.0 release notes
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    RelNotes: minor wording fixes in 2.43.0 release notes

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1611%2Fnewren%2Frelnotes-wording-improvements-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1611/newren/relnotes-wording-improvements-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1611

 Documentation/RelNotes/2.43.0.txt | 36 +++++++++++++++----------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/Documentation/RelNotes/2.43.0.txt b/Documentation/RelNotes/2.43.0.txt
index 74f304b1b2b..770543c464e 100644
--- a/Documentation/RelNotes/2.43.0.txt
+++ b/Documentation/RelNotes/2.43.0.txt
@@ -27,14 +27,14 @@ UI, Workflows & Features
    a branch that is checked out and protect it.  Rephrase the message
    to say that the branch is in use.
 
- * Hourly and other schedule of "git maintenance" jobs are randomly
+ * Hourly and other schedules of "git maintenance" jobs are randomly
    distributed now.
 
  * "git cmd -h" learned to signal which options can be negated by
    listing such options like "--[no-]opt".
 
- * The way authentication related data other than passwords (e.g.
-   oath token and password expiration data) are stored in libsecret
+ * The way authentication related data other than passwords (e.g.,
+   oauth token and password expiration data) are stored in libsecret
    keyrings has been rethought.
 
  * Update the libsecret and wincred credential helpers to correctly
@@ -60,7 +60,7 @@ UI, Workflows & Features
 
  * The default log message created by "git revert", when reverting a
    commit that records a revert, has been tweaked, to encourage people
-   describe complex "revert of revert of revert" situation better in
+   to describe complex "revert of revert of revert" situations better in
    their own words.
 
  * The command-line completion support (in contrib/) learned to
@@ -77,8 +77,8 @@ UI, Workflows & Features
 
  * The command line completion script (in contrib/) can be told to
    complete aliases by including ": git <cmd> ;" in the alias to tell
-   it that the alias should be completed similar to how "git <cmd>" is
-   completed.  The parsing code for the alias as been loosened to
+   it that the alias should be completed in a similar way to how "git <cmd>" is
+   completed.  The parsing code for the alias has been loosened to
    allow ';' without an extra space before it.
 
  * "git for-each-ref" and friends learned to apply mailmap to
@@ -117,8 +117,8 @@ Performance, Internal Implementation, Development Support etc.
  * Flaky "git p4" tests, as well as "git svn" tests, are now skipped
    in the (rather expensive) sanitizer CI job.
 
- * Tests with LSan from time to time seem to emit harmless message
-   that makes our tests unnecessarily flaky; we work it around by
+ * Tests with LSan from time to time seem to emit harmless messages
+   that make our tests unnecessarily flaky; we work around it by
    filtering the uninteresting output.
 
  * Unused parameters to functions are marked as such, and/or removed,
@@ -135,7 +135,7 @@ Performance, Internal Implementation, Development Support etc.
 
  * Test coverage for trailers has been improved.
 
- * The code to iterate over loose references have been optimized to
+ * The code to iterate over loose references has been optimized to
    reduce the number of lstat() system calls.
 
  * The codepaths that read "chunk" formatted files have been corrected
@@ -157,7 +157,7 @@ Fixes since v2.42
    branch tips at the same time will not waste building and testing
    the same thing twice.
 
- * The commit-graph verification code that detects mixture of zero and
+ * The commit-graph verification code that detects a mixture of zero and
    non-zero generation numbers has been updated.
 
  * "git diff -w --exit-code" with various options did not work
@@ -170,20 +170,20 @@ Fixes since v2.42
    the sequencer code has been cleaned up for consistency.
 
  * "git diff --no-such-option" and other corner cases around the exit
-   status of the "diff" command has been corrected.
+   status of the "diff" command have been corrected.
 
  * "git for-each-ref --sort='contents:size'" sorts the refs according
    to size numerically, giving a ref that points at a blob twelve-byte
    (12) long before showing a blob hundred-byte (100) long.
 
- * We now limit depth of the tree objects and maximum length of
+ * We now limit the depth of the tree objects and maximum length of
    pathnames recorded in tree objects.
    (merge 4d5693ba05 jk/tree-name-and-depth-limit later to maint).
 
  * Various fixes to the behavior of "rebase -i" when the command got
    interrupted by conflicting changes.
 
- * References from description of the `--patch` option in various
+ * References from a description of the `--patch` option in various
    manual pages have been simplified and improved.
 
  * "git grep -e A --no-or -e B" is accepted, even though the negation
@@ -203,8 +203,8 @@ Fixes since v2.42
    information for a file when fsmonitor knows it is clean and ended
    up behaving as if it is not clean, which has been corrected.
 
- * Clarify how "alias.foo = : git cmd ; aliased-command-string" should
-   be spelled with necessary whitespaces around punctuation marks to
+ * Clarify how "alias.foo = : git cmd ; aliased-command-string" should be
+   spelled with necessary whitespace around punctuation marks to
    work.
 
  * HTTP Header redaction code has been adjusted for a newer version of
@@ -256,9 +256,9 @@ Fixes since v2.42
    by "git stash create" now errors out.
    (merge d9b6634589 jc/fail-stash-to-store-non-stash later to maint).
 
- * The index file has room only for lower 32-bit of the file size in
+ * The index file has room only for the lower 32-bit of the file size in
    the cached stat information, which means cached stat information
-   will have 0 in its sd_size member for a file whose size is multiple
+   will have 0 in its sd_size member for a file whose size is a multiple
    of 4GiB.  This is mistaken for a racily clean path.  Avoid it by
    storing a bogus sd_size value instead for such files.
    (merge 5143ac07b1 bc/racy-4gb-files later to maint).
@@ -281,7 +281,7 @@ Fixes since v2.42
    20 months or so, which has been corrected.
 
  * "git send-email" did not have certain pieces of data computed yet
-   when it tried to validate the outging messages and its recipient
+   when it tried to validate the outgoing messages and its recipient
    addresses, which has been sorted out.
 
  * "git bugreport" learned to complain when it received a command line

base-commit: dadef801b365989099a9929e995589e455c51fed
-- 
gitgitgadget
