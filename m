From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Move test-* to t/helper/ subdirectory
Date: Sun, 1 May 2016 07:28:52 +0700
Message-ID: <20160501002852.GA3963@lanh>
References: <1460553762-12419-1-git-send-email-pclouds@gmail.com>
 <xmqqwpnkc9ca.fsf@gitster.mtv.corp.google.com>
 <CACsJy8A8vbp4-LrxoNX510Nme97EKfu0hBBs-LDRap1Z5=v3rA@mail.gmail.com>
 <20160427101833.GA5536@lanh>
 <xmqqy47z9geq.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 01 02:29:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awfG1-0001ZV-M8
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 02:29:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634AbcEAA3B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Apr 2016 20:29:01 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34673 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257AbcEAA27 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Apr 2016 20:28:59 -0400
Received: by mail-pf0-f196.google.com with SMTP id 145so15638652pfz.1
        for <git@vger.kernel.org>; Sat, 30 Apr 2016 17:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XADlOzrhr4vOQ4Yz/LHMNzAPRZw3/PAOs+Scc64TWWc=;
        b=gOs6pPTQdiz5tDpxr7nMreWwpaT30HUD++d9vbHBzhYn9LVbj2wWJ5Zw3w1tMHyDpD
         s/lOrLc93CeEWzilRbu2aFcZfNXIK/o0PLN+LDJo6XPN2O3dWYnc/p7LqHRVGB5Jjmmd
         3Bite/x3kSrtUxskoqr4fSgu5RwH+jeKatbHS49C3lOj77rQeAgGaftK2Na6I7VQCRNQ
         Z32yqynhnttX997g9GrVUdfwt6lUmuT++EAkk1ltcbiUlSVn/g0DLM5W3iSHW53VkzSC
         PrsISkXhYb5ZjsaoAtozpHcHCoEBjrxPCuWrQS5BOq/E536EeNKkNf/v9cplR/XXrasb
         Y6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XADlOzrhr4vOQ4Yz/LHMNzAPRZw3/PAOs+Scc64TWWc=;
        b=W6yEEiU9raAWHmJ57b62d9cK6a5LiOoWQlmXvKee7adHAmOgBq815VE2kWaWSlx+jG
         dw2E5ADn2/B6dw12lNh0Xxj9vMkEUgAw2xEQqTGXY/Njo6mz+a1nEcFokvqLYiRi7PVv
         iGleyJ9XdF+857rlYNkfILoc5nhrVLTo/5f5ExRqpN2+tOgLKxBqkbdpSWEqz/pP5vFk
         hlR5Tab5gUtvOzuiAaP7+RZKzO3ZgBCm5y3ZAekeDLFYmM8n2IhYshhM4TPJq8yHXvFz
         mweIj+dlzCsE4KoIafmtdTER1V4uklTzpUJhawe7O6DtRBb5mh0qHDXD7yXyqsuB1sAa
         x97A==
X-Gm-Message-State: AOPr4FWaqqu0MyKncrWsFH0EDvzol9QPfJ0prNN1difq7tJpJ4ekWdC+Xgc4Q43PDdUf6A==
X-Received: by 10.98.64.79 with SMTP id n76mr40461030pfa.149.1462062538985;
        Sat, 30 Apr 2016 17:28:58 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id hk7sm34441265pad.25.2016.04.30.17.28.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Apr 2016 17:28:57 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 01 May 2016 07:28:52 +0700
Content-Disposition: inline
In-Reply-To: <xmqqy47z9geq.fsf@gitster.mtv.corp.google.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293135>

On Wed, Apr 27, 2016 at 09:15:41AM -0700, Junio C Hamano wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
> 
> > This patch forces bin-wrappers regeneration every time a test program
> > is updated. A bit wasteful, but I don't see a better option (which is
> > also why I limit this to test programs only).
> 
> In other words, when we update the location where the programs that
> would be eventually installed are created, we'd see the same
> problem.
> 
> I actually wonder if it is a better overall structure to move
> t/helper/test-foo back to test-foo, while keeping the source file
> that contains main() for test-foo at t/helper/test-foo.c.  Then we
> do not have to have many copies that are slightly different in
> bin-wrappers, but they can all be
> 
> 	exec "${GIT_EXEC_PATH}/$0" "$@"
> 
> instead of "bin-wrappers/git-bar" being
> 
> 	exec "${GIT_EXEC_PATH}/git-bar" "$@"
> 
> and "bin-wrappers/test-foo" being
> 
> 	exec "${GIT_EXEC_PATH}/t/helper/test-foo" "$@"
> 

It's not a perfect solution (rebuild bin-wrappers when the real binary
moves) but I think it's the best option so far. We can move test-*
binaries back with this patch.

-- 8< --
diff --git a/.gitignore b/.gitignore
index 05cb58a..5087ce1 100644
--- a/.gitignore
+++ b/.gitignore
@@ -179,6 +179,39 @@
 /gitweb/gitweb.cgi
 /gitweb/static/gitweb.js
 /gitweb/static/gitweb.min.*
+/test-chmtime
+/test-ctype
+/test-config
+/test-date
+/test-delta
+/test-dump-cache-tree
+/test-dump-split-index
+/test-dump-untracked-cache
+/test-fake-ssh
+/test-scrap-cache-tree
+/test-genrandom
+/test-hashmap
+/test-index-version
+/test-line-buffer
+/test-match-trees
+/test-mergesort
+/test-mktemp
+/test-parse-options
+/test-path-utils
+/test-prio-queue
+/test-read-cache
+/test-regex
+/test-revision-walking
+/test-run-command
+/test-sha1
+/test-sha1-array
+/test-sigchain
+/test-string-list
+/test-submodule-config
+/test-subprocess
+/test-svn-fe
+/test-urlmatch-normalization
+/test-wildmatch
 /common-cmds.h
 *.tar.gz
 *.dsc
diff --git a/Makefile b/Makefile
index dd178ee..7a1c973 100644
--- a/Makefile
+++ b/Makefile
@@ -620,7 +620,7 @@ TEST_PROGRAMS_NEED_X += test-svn-fe
 TEST_PROGRAMS_NEED_X += test-urlmatch-normalization
 TEST_PROGRAMS_NEED_X += test-wildmatch
 
-TEST_PROGRAMS = $(patsubst %,t/helper/%$X,$(TEST_PROGRAMS_NEED_X))
+TEST_PROGRAMS = $(patsubst %,%$X,$(TEST_PROGRAMS_NEED_X))
 
 # List built-in command $C whose implementation cmd_$C() is not in
 # builtin/$C.o but is linked in as part of some other command.
@@ -1897,7 +1897,7 @@ VCSSVN_OBJS += vcs-svn/fast_export.o
 VCSSVN_OBJS += vcs-svn/svndiff.o
 VCSSVN_OBJS += vcs-svn/svndump.o
 
-TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS))
+TEST_OBJS := $(patsubst %,t/helper/%.o,$(TEST_PROGRAMS_NEED_X))
 OBJECTS := $(LIB_OBJS) $(BUILTIN_OBJS) $(PROGRAM_OBJS) $(TEST_OBJS) \
 	$(XDIFF_OBJS) \
 	$(VCSSVN_OBJS) \
@@ -2204,7 +2204,7 @@ bin-wrappers/%: wrap-for-bin.sh
 	@mkdir -p bin-wrappers
 	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	     -e 's|@@BUILD_DIR@@|$(shell pwd)|' \
-	     -e 's|@@PROG@@|$(patsubst test-%,t/helper/test-%,$(@F))|' < $< > $@ && \
+	     -e 's|@@PROG@@|$(@F)|'< $< > $@ && \
 	chmod +x $@
 
 # GNU make supports exporting all variables by "export" without parameters.
@@ -2224,24 +2224,24 @@ perf: all
 
 .PHONY: test perf
 
-t/helper/test-ctype$X: ctype.o
+test-ctype$X: ctype.o
 
-t/helper/test-date$X: date.o ctype.o
+test-date$X: date.o ctype.o
 
-t/helper/test-delta$X: diff-delta.o patch-delta.o
+test-delta$X: diff-delta.o patch-delta.o
 
-t/helper/test-line-buffer$X: vcs-svn/lib.a
+test-line-buffer$X: vcs-svn/lib.a
 
-t/helper/test-parse-options$X: parse-options.o parse-options-cb.o
+test-parse-options$X: parse-options.o parse-options-cb.o
 
-t/helper/test-svn-fe$X: vcs-svn/lib.a
+test-svn-fe$X: vcs-svn/lib.a
 
 .PRECIOUS: $(TEST_OBJS)
 
-t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS)
+test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(filter %.a,$^) $(LIBS)
 
-check-sha1:: t/helper/test-sha1$X
+check-sha1:: test-sha1$X
 	t/helper/test-sha1.sh
 
 SP_OBJ = $(patsubst %.o,%.sp,$(C_OBJ))
diff --git a/t/helper/test-sha1.sh b/t/helper/test-sha1.sh
index 750b95a..cef4bcc 100755
--- a/t/helper/test-sha1.sh
+++ b/t/helper/test-sha1.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 dd if=/dev/zero bs=1048576 count=100 2>/dev/null |
-/usr/bin/time t/helper/test-sha1 >/dev/null
+/usr/bin/time ./test-sha1 >/dev/null
 
 while read expect cnt pfx
 do
@@ -11,7 +11,7 @@ do
 			test -z "$pfx" || echo "$pfx"
 			dd if=/dev/zero bs=1048576 count=$cnt 2>/dev/null |
 			perl -pe 'y/\000/g/'
-		} | ./t/helper/test-sha1 $cnt
+		} | ./test-sha1 $cnt
 	)
 	if test "$expect" = "$actual"
 	then
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 150aeaf..c1efb8e 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -308,7 +308,7 @@ test_expect_success 'clone checking out a tag' '
 
 setup_ssh_wrapper () {
 	test_expect_success 'setup ssh wrapper' '
-		cp "$GIT_BUILD_DIR/t/helper/test-fake-ssh$X" \
+		cp "$GIT_BUILD_DIR/test-fake-ssh$X" \
 			"$TRASH_DIRECTORY/ssh-wrapper$X" &&
 		GIT_SSH="$TRASH_DIRECTORY/ssh-wrapper$X" &&
 		export GIT_SSH &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index cd0ecd4..0b47eb6 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -854,10 +854,10 @@ test -d "$GIT_BUILD_DIR"/templates/blt || {
 	error "You haven't built things yet, have you?"
 }
 
-if ! test -x "$GIT_BUILD_DIR"/t/helper/test-chmtime
+if ! test -x "$GIT_BUILD_DIR"/test-chmtime
 then
 	echo >&2 'You need to build test-chmtime:'
-	echo >&2 'Run "make t/helper/test-chmtime" in the source (toplevel) directory'
+	echo >&2 'Run "make test-chmtime" in the source (toplevel) directory'
 	exit 1
 fi
-- 8< --
 
