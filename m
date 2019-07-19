Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 029121F461
	for <e@80x24.org>; Fri, 19 Jul 2019 14:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbfGSOTA (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jul 2019 10:19:00 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:36063 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729262AbfGSOS6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jul 2019 10:18:58 -0400
Received: by mail-wm1-f42.google.com with SMTP id g67so25094730wme.1
        for <git@vger.kernel.org>; Fri, 19 Jul 2019 07:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nFfS+FMO6Lz4UlCkzBsPq1/l5kD4jnxVHyshCW/tNhs=;
        b=msCKf8Xt6eKlu/4hO9EftU2vZdIJSIa2q4K4gpuREtrFSC9nrfnKD4NzDW8Sdkx1L2
         Kl2Khph0KaiYcIXNwpUN8Ln7It7nJGHbFTW7ziRpNiv7P0XaO2U8E0/GH/celpr3hbWV
         7/09EhIDwqDCtr2vzGQNVcufQVdyJrZ8zREVPobKr7GITAG9EswcUoPXc65XQcFt/Zry
         bPh6jx860yIhkjazee8m0LHVfzYU1ru8YlDIwhffXBFJ7Ckz/zmBduhPYpQsRfDZb4r+
         CFAlBhUPheFg8cuiqCrH66zHbKl7p3RYRqGGSKa8V8K1JsTYRcsnvO75c6+LMtSa4Da1
         F1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nFfS+FMO6Lz4UlCkzBsPq1/l5kD4jnxVHyshCW/tNhs=;
        b=TcSN//bwv6ekGx3O5uU4K0bTEWFYjdY8TtI5HRL7fgQkC3FS9KG8nh0Xw5u4pZNm7h
         Y0ozj+TBpqNAufju9KOCE1Yhd/FEL0ApiLxMSomhtxLdqx+H64sB6z7hAer7hgqHuzkB
         IUt1x4fLbEDFcoP7QKDZ4BnzBd/dKCzasHZsnr5fqXysTXICnJkpnytV3wlNjTwbhCBG
         lhn6fMQUuCdHPi3ZtU9QC8AAw2Ksy3j3DjHSc1MJcZxIPe2hxaJobPa2cki7wJ9XwPNa
         b9Byfat0YRUQt5QvveW2a06Z5Z/NNM3MDwlObbFFDZM7zqnXkFemm8QqIPfrIZusKMIx
         LbLg==
X-Gm-Message-State: APjAAAV74Z2salNcULXtPtUipTihu0o/qWnD7wKpbooNoI+4T1iq6/4o
        8VsMXxhsM756EnLEd9vogzUpouXe
X-Google-Smtp-Source: APXvYqxITjOP9O28ddOU2ynVSLfFrqTmR5SOIjdM9GHp6qhz9Al445BSbu8H30UzgmE6NmBzO/BFyA==
X-Received: by 2002:a1c:d107:: with SMTP id i7mr51064107wmg.92.1563545935735;
        Fri, 19 Jul 2019 07:18:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k124sm47222547wmk.47.2019.07.19.07.18.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jul 2019 07:18:55 -0700 (PDT)
Date:   Fri, 19 Jul 2019 07:18:55 -0700 (PDT)
X-Google-Original-Date: Fri, 19 Jul 2019 14:18:53 GMT
Message-Id: <ad1fdb86ae42378d10584deb58115adf11de8ef7.1563545933.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.290.git.gitgitgadget@gmail.com>
References: <pull.290.git.gitgitgadget@gmail.com>
From:   "cclauss via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] Travis CI: Lint for Python syntax errors and undefined
 names
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, cclauss <cclauss@me.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: cclauss <cclauss@me.com>

Several things were changed between Python 2 and Python 3.
There are a few Python 3 incompatibilities to work on.
Here we are making changes to make the code run on both Py2 and Py3.
We are doing this because the end of life of Python 2 is in 167 days.
We are using print() function because legacy print statements are syntax
errors on Py3.
reduce() was moved in Python 3 and raw_input() was removed so we make
changes to avoid NameErrors being raised at runtime.
We are also putting flake8 lint tests in place on Travis CI to avoid
any backsliding on future pull requests.

Signed-off-by: cclauss <cclauss@me.com>
---
 .travis.yml                        |  4 +++
 contrib/fast-import/import-zips.py |  3 +-
 contrib/hg-to-git/hg-to-git.py     | 47 +++++++++++++++---------------
 git-p4.py                          |  3 ++
 4 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index ffb1bc46f2..62557dc8fd 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -39,6 +39,10 @@ matrix:
       compiler:
       script: ci/test-documentation.sh
       after_failure:
+    - env: jobname=LintPython
+      language: python
+      before_install: pip install flake8
+      script: flake8 . --count --select=E9,F63,F72,F82 --show-source --statistics
 
 before_install: ci/install-dependencies.sh
 script: ci/run-build-and-tests.sh
diff --git a/contrib/fast-import/import-zips.py b/contrib/fast-import/import-zips.py
index d12c296223..138194475c 100755
--- a/contrib/fast-import/import-zips.py
+++ b/contrib/fast-import/import-zips.py
@@ -8,6 +8,7 @@
 ##  python import-zips.py *.zip
 ##  git log --stat import-zips
 
+from __future__ import print_function
 from os import popen, path
 from sys import argv, exit, hexversion, stderr
 from time import mktime
@@ -19,7 +20,7 @@
     exit(1)
 
 if len(argv) < 2:
-    print 'usage:', argv[0], '<zipfile>...'
+    print('usage:', argv[0], '<zipfile>...')
     exit(1)
 
 branch_ref = 'refs/heads/import-zips'
diff --git a/contrib/hg-to-git/hg-to-git.py b/contrib/hg-to-git/hg-to-git.py
index de3f81667e..1d5e5156a4 100755
--- a/contrib/hg-to-git/hg-to-git.py
+++ b/contrib/hg-to-git/hg-to-git.py
@@ -18,6 +18,7 @@
     along with this program; if not, see <http://www.gnu.org/licenses/>.
 """
 
+from __future__ import print_function
 import os, os.path, sys
 import tempfile, pickle, getopt
 import re
@@ -42,7 +43,7 @@
 
 def usage():
 
-        print """\
+        print("""\
 %s: [OPTIONS] <hgprj>
 
 options:
@@ -54,7 +55,7 @@ def usage():
 
 required:
     hgprj:  name of the HG project to import (directory)
-""" % sys.argv[0]
+""" % sys.argv[0])
 
 #------------------------------------------------------------------------------
 
@@ -104,22 +105,22 @@ def getgitenv(user, date):
 if state:
     if os.path.exists(state):
         if verbose:
-            print 'State does exist, reading'
+            print('State does exist, reading')
         f = open(state, 'r')
         hgvers = pickle.load(f)
     else:
-        print 'State does not exist, first run'
+        print('State does not exist, first run')
 
 sock = os.popen('hg tip --template "{rev}"')
 tip = sock.read()
 if sock.close():
     sys.exit(1)
 if verbose:
-    print 'tip is', tip
+    print('tip is', tip)
 
 # Calculate the branches
 if verbose:
-    print 'analysing the branches...'
+    print('analysing the branches...')
 hgchildren["0"] = ()
 hgparents["0"] = (None, None)
 hgbranch["0"] = "master"
@@ -155,7 +156,7 @@ def getgitenv(user, date):
             hgbranch[str(cset)] = "branch-" + str(cset)
 
 if not hgvers.has_key("0"):
-    print 'creating repository'
+    print('creating repository')
     os.system('git init')
 
 # loop through every hg changeset
@@ -180,27 +181,27 @@ def getgitenv(user, date):
     os.write(fdcomment, csetcomment)
     os.close(fdcomment)
 
-    print '-----------------------------------------'
-    print 'cset:', cset
-    print 'branch:', hgbranch[str(cset)]
-    print 'user:', user
-    print 'date:', date
-    print 'comment:', csetcomment
+    print('-----------------------------------------')
+    print('cset:', cset)
+    print('branch:', hgbranch[str(cset)])
+    print('user:', user)
+    print('date:', date)
+    print('comment:', csetcomment)
     if parent:
-	print 'parent:', parent
+	    print('parent:', parent)
     if mparent:
-        print 'mparent:', mparent
+        print('mparent:', mparent)
     if tag:
-        print 'tag:', tag
-    print '-----------------------------------------'
+        print('tag:', tag)
+    print('-----------------------------------------')
 
     # checkout the parent if necessary
     if cset != 0:
         if hgbranch[str(cset)] == "branch-" + str(cset):
-            print 'creating new branch', hgbranch[str(cset)]
+            print('creating new branch', hgbranch[str(cset)])
             os.system('git checkout -b %s %s' % (hgbranch[str(cset)], hgvers[parent]))
         else:
-            print 'checking out branch', hgbranch[str(cset)]
+            print('checking out branch', hgbranch[str(cset)])
             os.system('git checkout %s' % hgbranch[str(cset)])
 
     # merge
@@ -209,7 +210,7 @@ def getgitenv(user, date):
             otherbranch = hgbranch[mparent]
         else:
             otherbranch = hgbranch[parent]
-        print 'merging', otherbranch, 'into', hgbranch[str(cset)]
+        print('merging', otherbranch, 'into', hgbranch[str(cset)])
         os.system(getgitenv(user, date) + 'git merge --no-commit -s ours "" %s %s' % (hgbranch[str(cset)], otherbranch))
 
     # remove everything except .git and .hg directories
@@ -233,12 +234,12 @@ def getgitenv(user, date):
 
     # delete branch if not used anymore...
     if mparent and len(hgchildren[str(cset)]):
-        print "Deleting unused branch:", otherbranch
+        print("Deleting unused branch:", otherbranch)
         os.system('git branch -d %s' % otherbranch)
 
     # retrieve and record the version
     vvv = os.popen('git show --quiet --pretty=format:%H').read()
-    print 'record', cset, '->', vvv
+    print('record', cset, '->', vvv)
     hgvers[str(cset)] = vvv
 
 if hgnewcsets >= opt_nrepack and opt_nrepack != -1:
@@ -247,7 +248,7 @@ def getgitenv(user, date):
 # write the state for incrementals
 if state:
     if verbose:
-        print 'Writing state'
+        print('Writing state')
     f = open(state, 'w')
     pickle.dump(hgvers, f)
 
diff --git a/git-p4.py b/git-p4.py
index 3991e7d1a7..9faee25db2 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -36,6 +36,8 @@
     unicode = str
     bytes = bytes
     basestring = (str,bytes)
+    raw_input = input
+    from functools import reduce
 else:
     # 'unicode' exists, must be Python 2
     str = str
@@ -3968,6 +3970,7 @@ def renameBranch(self, branch_name):
                 break
 
         if not found:
+            sync = P4Sync()
             sys.exit("gave up trying to rename existing branch {0}".format(sync.branch))
 
     def findLastP4Revision(self, starting_point):
-- 
gitgitgadget
