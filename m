From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 5/5] autoconf: Quote AC_CACHE_CHECK arguments
Date: Tue, 5 Sep 2006 00:58:25 +0200
Message-ID: <200609050058.25748.jnareb@gmail.com>
References: <200609050054.24279.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Sep 05 00:58:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKNOw-0007fJ-2h
	for gcvg-git@gmane.org; Tue, 05 Sep 2006 00:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbWIDW6i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 18:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbWIDW6i
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 18:58:38 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:46615 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751425AbWIDW6e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Sep 2006 18:58:34 -0400
Received: by nf-out-0910.google.com with SMTP id o25so1112916nfa
        for <git@vger.kernel.org>; Mon, 04 Sep 2006 15:58:33 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=SsMkH6TNO3jzpRYwHY1FGD+0ZFvBZ/6hxrM7QaIn+uCf/zy0453v241apodPjlBFz0tyUIjbHB/NZJwfNmbXdFDji/pa3ihCwRb/DIKIUZPhv3zenKD5V3qTZIXlJfwTSbe9yUYcXLyxpIOmnbhTSKjvYAk2sE6ZLskPOpGpOTA=
Received: by 10.49.8.4 with SMTP id l4mr7148142nfi;
        Mon, 04 Sep 2006 15:58:33 -0700 (PDT)
Received: from host-81-190-21-28.torun.mm.pl ( [81.190.21.28])
        by mx.gmail.com with ESMTP id l38sm10135925nfc.2006.09.04.15.58.32;
        Mon, 04 Sep 2006 15:58:33 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200609050054.24279.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26446>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Just in case.

 configure.ac |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index 67a7aa9..85317a3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -205,8 +205,8 @@ # Define NO_C99_FORMAT if your formatted
 # do not support the 'size specifiers' introduced by C99, namely ll, hh,
 # j, z, t. (representing long long int, char, intmax_t, size_t, ptrdiff_t).
 # some C compilers supported these specifiers prior to C99 as an extension.
-AC_CACHE_CHECK(whether formatted IO functions support C99 size specifiers,
- ac_cv_c_c99_format,
+AC_CACHE_CHECK([whether formatted IO functions support C99 size specifiers],
+ [ac_cv_c_c99_format],
 [# Actually git uses only %z (%zu) in alloc.c, and %t (%td) in mktag.c
 AC_RUN_IFELSE(
 	[AC_LANG_PROGRAM([AC_INCLUDES_DEFAULT],
@@ -268,8 +268,8 @@ # Define NO_SYMLINK_HEAD if you never wa
 # Enable it on Windows.  By default, symrefs are still used.
 #
 # Define WITH_OWN_SUBPROCESS_PY if you want to use with python 2.3.
-AC_CACHE_CHECK(for subprocess.py,
- ac_cv_python_has_subprocess_py,
+AC_CACHE_CHECK([for subprocess.py],
+ [ac_cv_python_has_subprocess_py],
 [if $PYTHON_PATH -c 'import subprocess' 2>/dev/null; then
 	ac_cv_python_has_subprocess_py=yes
 else
-- 
1.4.1.1
