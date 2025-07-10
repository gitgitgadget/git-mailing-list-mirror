Received: from avasout-peh-004.plus.net (avasout-peh-004.plus.net [212.159.14.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA96421A43D
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 19:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752175947; cv=none; b=VrynW9WL2qsL1/obCyIy4QXg14tciBSV1kmN64vj0d9e23KlOBOfZ9WM79F7d67p23LXuPVmp2e1ve5MH+VMiTl86tWDVxEoM8QAA8YKQ0P/pxEAn8TNP+aJgxNCUa2h++6j/et7HHttz/AjD5/okn/GX45AW6iASkw+82DZPD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752175947; c=relaxed/simple;
	bh=AMBS7FusEI+VXrOYarwsGXNy7px0/+Y2ri0n/sIORjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EzJvXD01hCVjccPu81h5UMQGs0j2Lx9e4vFGcP7SnbckylOJ6ElFBPcoua2Nr9bUBN0Jf9rbN5XaFYz/gPlxLZGcg+UgN+9/1ZlMKAyK1rTku1FDBe/SciZBa/lLVD0lo0ie5VlyyriX7z5aalvUy+feUQqdcjssJv+6b9bG8EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=LUQmCvz0; arc=none smtp.client-ip=212.159.14.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="LUQmCvz0"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id Zx09uhWLUMhRjZx0AuMm08; Thu, 10 Jul 2025 20:32:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1752175935; bh=n/k6s/Ksd2dCMfqnAYdhbfGWxkLWRPchSThQ4z2i1lA=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=LUQmCvz0/WEBTVFSZI7H1CWHPSKcnTWhfL/UkvMvCeZEY/NYYXil1qfJ+LcdXviha
	 l/bZITJpgiZM8wjfTPQ1uANNHPzj9cab99cgKyHUbxykGHWooSKBAVujEzodAuy32b
	 c0sH0lrM0lCnWyeQ4C2cT34PEJmsFSgXPLCPt1d90mmAXCFioe2R2EdIMws37K3fE+
	 C/kYxDmMCvWsm7UZwXy2PCkaNyq+qTkjYdPTo+YLx2TNPP0jaLfF/cPbP3oy7X22ra
	 Ta7HsdiB1j1bXAHpYJiM/CkCFx0oA3zhEqz4GgKND0u7A8zhm+cDMVLvEnIaQVJuGj
	 wkCVPGhH9XFdA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=Xq9ZOkF9 c=1 sm=1 tr=0 ts=6870153f
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=1rZglRVQw-5jqNQFhJIA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <f614e1c8-91a9-4430-9d60-5aca05170b4a@ramsayjones.plus.com>
Date: Thu, 10 Jul 2025 20:32:13 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [-SPAM-] What's cooking in git.git (Jul 2025, #03; Wed, 9)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqv7o08ocn.fsf@gitster.g>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <xmqqv7o08ocn.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfPZamFRK1MXqpiVQvnvDrxHKK2du46hgM7zSLC2DLnzhuBF2yvuOBCpx5jEl1pE7e4gQCH9c91DfHiKw0CVHY1T2qxIRNUHeKQc1SbkjNAsa0kA4BrmD
 EJO8rzQN1THknzbrSMQzn0pau2/6BgrtTY9ZtXiFYf/mKTEJAb4UO4YmVn8zBKm3QVHiry3gXkBVRBpCWX5tpWP3r2wlo5p+tuM=



On 10/07/2025 09:03, Junio C Hamano wrote:
[snip]
> * ps/meson-cleanups (2025-07-08) 8 commits
>  - ci: use Meson's new `--slice` option
>  - meson: update subproject wrappers
>  - meson: fix GIT_EXEC_PATH with overridden -Dlibexecdir=
>  - meson: fix lookup of shell on MINGW64
>  - meson: clean up unnecessary variables
>  - meson: improve summary of auto-detected features
>  - meson: stop printing 'https' option twice in our summaries
>  - meson: stop discovering native version of Python
> 
>  Meson-based build update.
> 
>  Will merge to 'next'?
>  source: <20250708-b4-pks-meson-cleanups-v2-0-94ac53cd4b95@pks.im>

The patch 'meson: fix GIT_EXEC_PATH with overridden -Dlibexecdir=' (6/8)
which is part of this series, is essentially a revert of commit 837f637cf51
(meson.build: correct setting of GIT_EXEC_PATH, 2025-05-19). That commit
did introduce a regression, but I have a patch (see below) which I think
would be an improvement.

I had intended to test this patch some more before submitting it, and I
think there are some additional problems, but it may be ready soon so that
it could replace the patch in this series. (It seems silly to have to revert
the revert before the next release ;) ).

The 'additional problems' exist no matter which patch is applied, so it
can be addressed by a later patch on top. (I *think* there are additional
problems - I have yet to properly investigate; look at the setting for
GITEXECDIR_REL).

As a quick demonstration, no 'libexecdir' setting:

  $ meson setup -Dprefix=/tmp/git build
  ...
    User defined options
      prefix     : /tmp/git
  
  Found ninja-1.11.1 at /usr/bin/ninja
  $ cd build
  $ meson compile
  INFO: autodetecting backend as ninja
  INFO: calculating backend command to run: /usr/bin/ninja
  [662/662] Copying file contrib/completion/git
  $ meson install
  ninja: Entering directory `/home/ramsay/git/build'
  [1/28] Generating GIT-VERSION-FILE wit... command (wrapped by meson to set env)
  Installing git to /tmp/git/libexec/git-core
  ...
  $ ls /tmp/git
  bin/  libexec/  share/
  $ ls -l /tmp/git/bin/git
  lrwxrwxrwx 1 ramsay ramsay 23 Jul 10 18:44 /tmp/git/bin/git -> ../libexec/git-core/git*
  $ /tmp/git/bin/git --exec-path
  /tmp/git/libexec/git-core
  $ /tmp/git/bin/git daemon -h
  usage: git daemon [--verbose] [--syslog] [--export-all]
  ...
  $ 
 
Now with a relative path for 'libexecdir':
 
  $ cd ..
  $ rm -rf build

  $ meson setup -Dprefix=/tmp/git1 -Dlibexecdir=libexec-different build
  ...
    User defined options
      libexecdir : libexec-different
      prefix     : /tmp/git1
  
  Found ninja-1.11.1 at /usr/bin/ninja
  $ cd build
  $ meson compile
  INFO: autodetecting backend as ninja
  INFO: calculating backend command to run: /usr/bin/ninja
  [662/662] Copying file contrib/completion/git
  $ meson install
  ninja: Entering directory `/home/ramsay/git/build'
  [1/28] Generating GIT-VERSION-FILE wit... command (wrapped by meson to set env)
  Installing git to /tmp/git1/libexec-different
  ...
  $ ls /tmp/git1
  bin/  libexec-different/  share/
  $ ls -l /tmp/git1/bin/git
  lrwxrwxrwx 1 ramsay ramsay 24 Jul 10 18:54 /tmp/git1/bin/git -> ../libexec-different/git*
  $ /tmp/git1/bin/git --exec-path
  /tmp/git1/libexec-different
  $ /tmp/git1/bin/git daemon -h
  usage: git daemon [--verbose] [--syslog] [--export-all]
  ...
  $ 

And finally, with an absolute path for 'libexecdir':  
  
  $ cd ..
  $ rm -rf build

  $ meson setup -Dprefix=/tmp/git2 -Dlibexecdir=/tmp/somewhere/else build
  ...
    User defined options
      libexecdir : /tmp/somewhere/else
      prefix     : /tmp/git2
  
  Found ninja-1.11.1 at /usr/bin/ninja
  $ cd build
  $ meson compile
  INFO: autodetecting backend as ninja
  INFO: calculating backend command to run: /usr/bin/ninja
  [662/662] Copying file contrib/completion/git
  $ meson install
  ninja: Entering directory `/home/ramsay/git/build'
  [1/28] Generating GIT-VERSION-FILE wit... command (wrapped by meson to set env)
  Installing git to /tmp/somewhere/else
  ...
  $ ls /tmp/git2
  bin/  share/
  $ ls /tmp/somewhere
  else/
  $ ls /tmp/somewhere/else
  git*                   git-merge-octopus*   git-send-email*
  git-archimport*        git-merge-one-file*  git-shell*
  git-cvsexportcommit*   git-merge-resolve*   git-sh-i18n
  git-cvsimport*         git-mergetool*       git-sh-i18n--envsubst*
  git-cvsserver*         git-mergetool--lib   git-sh-setup
  git-daemon*            git-p4*              git-submodule*
  git-difftool--helper*  git-quiltimport*     git-svn*
  git-filter-branch*     git-receive-pack@    git-upload-archive@
  git-http-backend*      git-remote-ftp@      git-upload-pack@
  git-http-fetch*        git-remote-ftps@     git-web--browse*
  git-http-push*         git-remote-http*     mergetools/
  git-imap-send*         git-remote-https@    scalar*
  git-instaweb*          git-request-pull*
  $ ls -l /tmp/git2/bin/git
  lrwxrwxrwx 1 ramsay ramsay 34 Jul 10 19:01 /tmp/git2/bin/git -> ../../../../tmp/somewhere/else/git*
  $ /tmp/git2/bin/git --exec-path
  /tmp/somewhere/else
  $ /tmp/git2/bin/git daemon -h
  usage: git daemon [--verbose] [--syslog] [--export-all]
  ...
  $ 

I had intended to do the equivalent 'make' invocations and check with 'tree'
(by diffing the output) or similar, that the installations are the same, but
they seem to be correct (just eyeballing them).

How would you like to proceed? (yes, I haven't written the commit message
yet).

ATB,
Ramsay Jones

---- >8 ----  
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] meson: fix installation when -Dlibexexdir is set

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 meson.build | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/meson.build b/meson.build
index 7fea4a34d6..26b12c4592 100644
--- a/meson.build
+++ b/meson.build
@@ -1744,7 +1744,7 @@ git_builtin = executable('git',
   sources: builtin_sources + 'git.c',
   dependencies: [libgit_commonmain],
   install: true,
-  install_dir: get_option('libexecdir') / 'git-core',
+  install_dir: git_exec_path,
 )
 bin_wrappers += git_builtin
 
@@ -1752,35 +1752,35 @@ test_dependencies += executable('git-daemon',
   sources: 'daemon.c',
   dependencies: [libgit_commonmain],
   install: true,
-  install_dir: get_option('libexecdir') / 'git-core',
+  install_dir: git_exec_path,
 )
 
 test_dependencies += executable('git-sh-i18n--envsubst',
   sources: 'sh-i18n--envsubst.c',
   dependencies: [libgit_commonmain],
   install: true,
-  install_dir: get_option('libexecdir') / 'git-core',
+  install_dir: git_exec_path,
 )
 
 bin_wrappers += executable('git-shell',
   sources: 'shell.c',
   dependencies: [libgit_commonmain],
   install: true,
-  install_dir: get_option('libexecdir') / 'git-core',
+  install_dir: git_exec_path,
 )
 
 test_dependencies += executable('git-http-backend',
   sources: 'http-backend.c',
   dependencies: [libgit_commonmain],
   install: true,
-  install_dir: get_option('libexecdir') / 'git-core',
+  install_dir: git_exec_path,
 )
 
 bin_wrappers += executable('scalar',
   sources: 'scalar.c',
   dependencies: [libgit_commonmain],
   install: true,
-  install_dir: get_option('libexecdir') / 'git-core',
+  install_dir: git_exec_path,
 )
 
 if curl.found()
@@ -1796,14 +1796,14 @@ if curl.found()
     sources: 'remote-curl.c',
     dependencies: [libgit_curl],
     install: true,
-    install_dir: get_option('libexecdir') / 'git-core',
+    install_dir: git_exec_path,
   )
 
   test_dependencies += executable('git-http-fetch',
     sources: 'http-fetch.c',
     dependencies: [libgit_curl],
     install: true,
-    install_dir: get_option('libexecdir') / 'git-core',
+    install_dir: git_exec_path,
   )
 
   if expat.found()
@@ -1811,7 +1811,7 @@ if curl.found()
       sources: 'http-push.c',
       dependencies: [libgit_curl],
       install: true,
-      install_dir: get_option('libexecdir') / 'git-core',
+      install_dir: git_exec_path,
     )
   endif
 
@@ -1822,7 +1822,7 @@ if curl.found()
     )
 
     install_symlink(alias + executable_suffix,
-      install_dir: get_option('libexecdir') / 'git-core',
+      install_dir: git_exec_path,
       pointing_to: 'git-remote-http',
     )
   endforeach
@@ -1832,7 +1832,7 @@ test_dependencies += executable('git-imap-send',
   sources: 'imap-send.c',
   dependencies: [ use_curl_for_imap_send ? libgit_curl : libgit_commonmain ],
   install: true,
-  install_dir: get_option('libexecdir') / 'git-core',
+  install_dir: git_exec_path,
 )
 
 foreach alias : [ 'git-receive-pack', 'git-upload-archive', 'git-upload-pack' ]
@@ -1842,7 +1842,7 @@ foreach alias : [ 'git-receive-pack', 'git-upload-archive', 'git-upload-pack' ]
   )
 
   install_symlink(alias + executable_suffix,
-    install_dir: get_option('libexecdir') / 'git-core',
+    install_dir: git_exec_path,
     pointing_to: 'git',
   )
 endforeach
@@ -1856,9 +1856,9 @@ foreach symlink : [
   'scalar',
 ]
   if meson.version().version_compare('>=1.3.0')
-    pointing_to = fs.relative_to(get_option('libexecdir') / 'git-core' / symlink, get_option('bindir'))
+    pointing_to = fs.relative_to(git_exec_path / symlink, get_option('bindir'))
   else
-    pointing_to = '../libexec/git-core' / symlink
+    pointing_to = '..' / git_exec_path / symlink
   endif
 
   install_symlink(symlink,
@@ -1898,7 +1898,7 @@ foreach script : scripts_sh
       meson.project_build_root() / 'GIT-BUILD-OPTIONS',
     ],
     install: true,
-    install_dir: get_option('libexecdir') / 'git-core',
+    install_dir: git_exec_path,
   )
 endforeach
 
@@ -1931,7 +1931,7 @@ if perl_features_enabled
     input: perl_header_template,
     output: 'GIT-PERL-HEADER',
     configuration: {
-      'GITEXECDIR_REL': get_option('libexecdir') / 'git-core',
+      'GITEXECDIR_REL': git_exec_path,
       'PERLLIBDIR_REL': perllibdir,
       'LOCALEDIR_REL': get_option('datadir') / 'locale',
       'INSTLIBDIR': perllibdir,
@@ -1955,7 +1955,7 @@ if perl_features_enabled
       output: fs.stem(script),
       command: generate_perl_command,
       install: true,
-      install_dir: get_option('libexecdir') / 'git-core',
+      install_dir: git_exec_path,
       depends: [git_version_file],
     )
     test_dependencies += generated_script
@@ -1964,9 +1964,9 @@ if perl_features_enabled
       bin_wrappers += generated_script
 
       if meson.version().version_compare('>=1.3.0')
-        pointing_to = fs.relative_to(get_option('libexecdir') / 'git-core' / fs.stem(script), get_option('bindir'))
+        pointing_to = fs.relative_to(git_exec_path / fs.stem(script), get_option('bindir'))
       else
-        pointing_to = '../libexec/git-core' / fs.stem(script)
+        pointing_to = '..' / git_exec_path / fs.stem(script)
       endif
 
       install_symlink(fs.stem(script),
@@ -1996,7 +1996,7 @@ if python.found()
         '@OUTPUT@',
       ],
       install: true,
-      install_dir: get_option('libexecdir') / 'git-core',
+      install_dir: git_exec_path,
     )
     test_dependencies += generated_python
   endforeach
@@ -2030,7 +2030,7 @@ mergetools = [
 ]
 
 foreach mergetool : mergetools
-  install_data(mergetool, install_dir: get_option('libexecdir') / 'git-core' / 'mergetools')
+  install_data(mergetool, install_dir: git_exec_path / 'mergetools')
 endforeach
 
 if intl.found()
-- 
2.50.0

