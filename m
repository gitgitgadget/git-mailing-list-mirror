Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D534B7E
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 07:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mufjAn79"
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39E2184
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 00:27:38 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-32fb1c35fe0so490948f8f.1
        for <git@vger.kernel.org>; Fri, 03 Nov 2023 00:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698996456; x=1699601256; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=h+Lyalwrt5P3NolaoLuCME8NuzkNgfanux5FRlpYr/A=;
        b=mufjAn79n0pagxxjzt8x+vzpogsN37AddVx+FxZXVlyneTeno0hpdmiiz8bbDxiTig
         l8X6ObdXCOSQmHWxkl2Wk6nmsJmbGENSACm1LSYtKN8DoRvGKzHtEQpN+vvN8YnZq1nR
         4IU2tnl5iI+RT1Ocf5cX/+SvN4hmin1OVTacNa7r6VbE32B6PCEEamofoGxsILqn2E1K
         0t11ux9QmgogOUgeLt/+41zta/dr5uzoCUTGFklvo3fcy4VpKJjNZHa/u+OwB1qJfAhb
         vC1hgj2V4tfpD8LmvH3M1f1BXaM4Ys3KkEd3kKMkSNxlhmxNCSP6HzqEKXKpz1I7DYbq
         qeZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698996456; x=1699601256;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h+Lyalwrt5P3NolaoLuCME8NuzkNgfanux5FRlpYr/A=;
        b=qZT8I8dHufITfb5OeiMTScAD3vmt65ELkLNZ/dVX7niyMQAGZZVGzFrn4qKIUlGd5I
         CboTBpt/4rw/uKXAaIbIN2XDedjT3XPjoGxEGqw80h5MhalY2Mv3cSzZ0Rv9VmY1akWe
         oUk+630G26apsJfOqsmkIKP6cDX1vcR/mXzGxrXdOWawZHuNk7b33DkP1hEf2xIHCw04
         h/lzgeUQIFtG/H1z8APqVEoP9RbXnk/05KIH9ifPy0nzxFi+2dfc2iIFX/yEWb6n5h7W
         GR057SPxLEt3bfNpN+yaQWOnQ+DpZlaxoJ+ihpMk0b0D5a5Pd3TSxzjtGv8OKKD9jhwG
         WpAQ==
X-Gm-Message-State: AOJu0YwxR6CqqHCW19WIO1kaq6kAWY7WCL9DeUOddbtgmnyLoiauJ4iB
	Ucs1XtBQFYCRCHOF/9W9PmGwvkZFZVk=
X-Google-Smtp-Source: AGHT+IHItmFzbLGHy1FLUkbWufM/n5PVeHbkvq6s94IKNrg0iAPy7aQV7J37QyBaE8vfJmmTHOhrNQ==
X-Received: by 2002:a5d:4049:0:b0:32d:9d6b:ac99 with SMTP id w9-20020a5d4049000000b0032d9d6bac99mr14193600wrp.31.1698996456356;
        Fri, 03 Nov 2023 00:27:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k17-20020a5d6e91000000b0032d9382e6e0sm1141038wrz.45.2023.11.03.00.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 00:27:36 -0700 (PDT)
Message-ID: <pull.1607.git.1698996455218.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 03 Nov 2023 07:27:35 +0000
Subject: [PATCH] ci: upgrade to using macos-13
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In April, GitHub announced that the `macos-13` pool is available:
https://github.blog/changelog/2023-04-24-github-actions-macos-13-is-now-available/.
It is only a matter of time until the `macos-12` pool is going away,
therefore we should switch now, without pressure of a looming deadline.

Since the `macos-13` runners no longer include Python2, we also drop
specifically testing with Python2 and switch uniformly to Python3, see
https://github.com/actions/runner-images/blob/HEAD/images/macos/macos-13-Readme.md
for details about the software available on the `macos-13` pool's
runners.

Also, on macOS 13, Homebrew seems to install a `gcc@9` package that no
longer comes with a regular `unistd.h` (there seems only to be a
`ssp/unistd.h`), and hence builds would fail with:

    In file included from base85.c:1:
    git-compat-util.h:223:10: fatal error: unistd.h: No such file or directory
      223 | #include <unistd.h>
          |          ^~~~~~~~~~
    compilation terminated.

The reason why we install GCC v9.x explicitly is historical, and back in
the days it was because it was the _newest_ version available via
Homebrew: 176441bfb58 (ci: build Git with GCC 9 in the 'osx-gcc' build
job, 2019-11-27).

To reinstate the spirit of that commit _and_ to fix that build failure,
let's switch to the now-newest GCC version: v13.x.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    ci: upgrade to using macos-13
    
    GitHub announced in April that the macos-13 pool is available
    [https://github.blog/changelog/2023-04-24-github-actions-macos-13-is-now-available/],
    so let's switch. This might also stave off CI failures we experience
    over in GitGitGadget (e.g. here
    [https://github.com/gitgitgadget/git/actions/runs/6729366919/job/18290134547#step:3:56])
    and in Git for Windows (e.g. here
    [https://github.com/git-for-windows/git/actions/runs/6708618181/job/18252834721#step:3:57])
    where occasionally macos-12-xl runners seem to be co-opted to cope with
    macos-12 workload (and the former don't have Python2 in their PATH).

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1607%2Fdscho%2Fswitch-ci-to-macos-13-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1607/dscho/switch-ci-to-macos-13-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1607

 .github/workflows/main.yml | 6 +++---
 ci/lib.sh                  | 6 ++----
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index dcf7d78f1d0..9fdbd540289 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -276,11 +276,11 @@ jobs:
             pool: ubuntu-20.04
           - jobname: osx-clang
             cc: clang
-            pool: macos-12
+            pool: macos-13
           - jobname: osx-gcc
             cc: gcc
-            cc_package: gcc-9
-            pool: macos-12
+            cc_package: gcc-13
+            pool: macos-13
           - jobname: linux-gcc-default
             cc: gcc
             pool: ubuntu-latest
diff --git a/ci/lib.sh b/ci/lib.sh
index 6fbb5bade12..bc0b23099df 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -253,11 +253,9 @@ ubuntu-*)
 	export PATH="$GIT_LFS_PATH:$P4_PATH:$PATH"
 	;;
 macos-*)
-	if [ "$jobname" = osx-gcc ]
+	MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python3)"
+	if [ "$jobname" != osx-gcc ]
 	then
-		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python3)"
-	else
-		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python2)"
 		MAKEFLAGS="$MAKEFLAGS APPLE_COMMON_CRYPTO_SHA1=Yes"
 	fi
 	;;

base-commit: 692be87cbba55e8488f805d236f2ad50483bd7d5
-- 
gitgitgadget
