Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68DCE20133
	for <e@80x24.org>; Mon,  6 Mar 2017 16:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754282AbdCFQlO (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 11:41:14 -0500
Received: from smtpo.poczta.interia.pl ([217.74.65.207]:60504 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752986AbdCFQYd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 11:24:33 -0500
X-Greylist: delayed 652 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Mar 2017 11:24:32 EST
Date:   Mon, 06 Mar 2017 17:10:49 +0100
From:   Zenobiusz Kunegunda <zenobiusz.kunegunda@interia.pl>
Subject: fatal: Could not get current working directory: Permission denied |
 affected 2.10,2.11,2.12, but not 1.9.5 |
To:     git@vger.kernel.org
X-Mailer: interia.pl/pf09
X-Originating-IP: 89.64.255.37
Message-Id: <elvahoiwfqayelbskykd@qjih>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=interia.pl;
        s=biztos; t=1488816649;
        bh=vhSzJMJRgRCasSxNvizp1nbJxb3XBU+sByymwZ54Rq4=;
        h=Date:From:Subject:To:X-Mailer:X-Originating-IP:Message-Id:
         MIME-Version:Content-Type:Content-Transfer-Encoding;
        b=AgYbaWiRxF1SUf/U8PnfvhevvIs7RagFstFg2Y+NtF21M56o7gBGJdck0ieeRYTZp
         /J1LjnQqstahP3rJgZ1fDHyD9T0OVp8gveNwdHvTcJssKnYfG6cFSEUoWxUvprwXBa
         Lp1N0fbWFr0CuRj9uiDkTUI4DZeEpLr4IhVjUjdw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

OS: FreeBSD 10.3-STABLE

Story:
I was trying to install openproject using this manual
https://www.openproject.org/open-source/download/manual-installation-guide/

Everything was fine till command
$ bundle install --deployment --without postgres sqlite development test therubyracer docker

works witg git version: 
1.9.5 ( branch from repo )
does not work with git version: 
2.10 ( branch from from repo ) 
2.11 ( both from FreeBSD and from git repository) 
2.12 ( branch from repo )

On another server that passed but there was npm problem.

This is error for 
$ bundle install --deployment --without postgres sqlite development test therubyracer docker

=== output begin ===
Error message (this is from git 2.11; 2.10 and 2.12 report same error):
$ bundle install --deployment --without postgres sqlite development test therubyracer docker 
The git source `git://github.com/oliverguenther/omniauth.git` uses the `git` protocol, which transmits data without encryption. Disable this warning with `bundle config git.allow_insecure true`, or switch to the `https` protocol to keep your data secure.
The git source `git://github.com/finnlabs/awesome_nested_set.git` uses the `git` protocol, which transmits data without encryption. Disable this warning with `bundle config git.allow_insecure true`, or switch to the `https` protocol to keep your data secure.
The git source `git://github.com/why-el/svg-graph.git` uses the `git` protocol, which transmits data without encryption. Disable this warning with `bundle config git.allow_insecure true`, or switch to the `https` protocol to keep your data secure.
The git source `git://github.com/opf/rails-angular-xss.git` uses the `git` protocol, which transmits data without encryption. Disable this warning with `bundle config git.allow_insecure true`, or switch to the `https` protocol to keep your data secure.
The git source `git://github.com/goodwill/capybara-select2.git` uses the `git` protocol, which transmits data without encryption. Disable this warning with `bundle config git.allow_insecure true`, or switch to the `https` protocol to keep your data secure.
The git source `git://github.com/omniauth/omniauth-saml.git` uses the `git` protocol, which transmits data without encryption. Disable this warning with `bundle config git.allow_insecure true`, or switch to the `https` protocol to keep your data secure.
Fetching gem metadata from https://rubygems.org/.......
Fetching version metadata from https://rubygems.org/..
Fetching dependency metadata from https://rubygems.org/.
fatal: Could not get current working directory: Permission denied

Retrying `git fetch --force --quiet --tags "/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/cache/bundler/git/awesome_nested_set-209215f38dc7f6765d32201897f8688e973f4de7"` due to error (2/4): Bundler::Source::Git::GitCommandError Git error: command `git fetch --force --quiet --tags "/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/cache/bundler/git/awesome_nested_set-209215f38dc7f6765d32201897f8688e973f4de7"` in directory /usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/bundler/gems/awesome_nested_set-7bd473e845e2 has failed.
If this error persists you could try removing the cache directory '/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/cache/bundler/git/awesome_nested_set-209215f38dc7f6765d32201897f8688e973f4de7'fatal: Could not get current working directory: Permission denied

Retrying `git fetch --force --quiet --tags "/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/cache/bundler/git/awesome_nested_set-209215f38dc7f6765d32201897f8688e973f4de7"` due to error (3/4): Bundler::Source::Git::GitCommandError Git error: command `git fetch --force --quiet --tags "/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/cache/bundler/git/awesome_nested_set-209215f38dc7f6765d32201897f8688e973f4de7"` in directory /usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/bundler/gems/awesome_nested_set-7bd473e845e2 has failed.
If this error persists you could try removing the cache directory '/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/cache/bundler/git/awesome_nested_set-209215f38dc7f6765d32201897f8688e973f4de7'fatal: Could not get current working directory: Permission denied

Retrying `git fetch --force --quiet --tags "/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/cache/bundler/git/awesome_nested_set-209215f38dc7f6765d32201897f8688e973f4de7"` due to error (4/4): Bundler::Source::Git::GitCommandError Git error: command `git fetch --force --quiet --tags "/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/cache/bundler/git/awesome_nested_set-209215f38dc7f6765d32201897f8688e973f4de7"` in directory /usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/bundler/gems/awesome_nested_set-7bd473e845e2 has failed.
If this error persists you could try removing the cache directory '/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/cache/bundler/git/awesome_nested_set-209215f38dc7f6765d32201897f8688e973f4de7'fatal: Could not get current working directory: Permission denied

Git error: command `git fetch --force --quiet --tags
"/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/cache/bundler/git/awesome_nested_set-209215f38dc7f6765d32201897f8688e973f4de7"`
in directory /usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/bundler/gems/awesome_nested_set-7bd473e845e2 has
failed.
If this error persists you could try removing the cache directory
'/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/cache/bundler/git/awesome_nested_set-209215f38dc7f6765d32201897f8688e973f4de7'
=== output end ===

removing cache directory did not help

My own debuging( git 2.12 ):

diff --git a/Makefile b/Makefile
index 9ec6065cc..391d765e7 100644
--- a/Makefile
+++ b/Makefile
@@ -405,7 +405,7 @@ DEVELOPER_CFLAGS = -Werror \
        -Wstrict-prototypes \
        -Wunused \
        -Wvla
-LDFLAGS =
+LDFLAGS = -lexecinfo
 ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
 STRIP ?= strip
@@ -1437,6 +1437,7 @@ ifdef RUNTIME_PREFIX
        COMPAT_CFLAGS += -DRUNTIME_PREFIX
 endif
 
+#define NO_PTHREADS 1
 ifdef NO_PTHREADS
        BASIC_CFLAGS += -DNO_PTHREADS
 else
diff --git a/setup.c b/setup.c
index 967f289f1..0879b755f 100644
--- a/setup.c
+++ b/setup.c
@@ -848,6 +848,7 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
        if (nongit_ok)
                *nongit_ok = 0;
 
+       fprintf(stderr,"*** DBG ***\n");
        if (strbuf_getcwd(&cwd))
                die_errno(_("Unable to read current working directory"));
        offset = cwd.len;
diff --git a/strbuf.c b/strbuf.c
index 8fec6579f..bd598e440 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -442,13 +442,25 @@ int strbuf_getcwd(struct strbuf *sb)
 {
        size_t oldalloc = sb->alloc;
        size_t guessed_len = 128;
+char *USER_diag;
+int USER_i=0;
+
+       struct timespec spec;
+
+       clock_gettime(CLOCK_REALTIME, &spec);
+
+
+       fprintf(stderr,"PID:%d DBG[strbuf_getcwd()]\n",getpid());
 
        for (;; guessed_len *= 2) {
                strbuf_grow(sb, guessed_len);
-               if (getcwd(sb->buf, sb->alloc)) {
+               fprintf(stderr,"PID:%d TIME:%ld DBG<BEFORE getcwd()> sb->buf[%s]length(%lu) sb->alloc[%lu]\n",getpid(),spec.tv_nsec,sb->buf,strlen(sb->buf),sb->alloc);
...skipping...
diff --git a/Makefile b/Makefile
diff --git a/Makefile b/Makefile
index 9ec6065cc..391d765e7 100644
--- a/Makefile
+++ b/Makefile
@@ -405,7 +405,7 @@ DEVELOPER_CFLAGS = -Werror \
        -Wstrict-prototypes \
        -Wunused \
        -Wvla
-LDFLAGS =
+LDFLAGS = -lexecinfo
 ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
 STRIP ?= strip
@@ -1437,6 +1437,7 @@ ifdef RUNTIME_PREFIX
        COMPAT_CFLAGS += -DRUNTIME_PREFIX
 endif
 
+#define NO_PTHREADS 1
 ifdef NO_PTHREADS
        BASIC_CFLAGS += -DNO_PTHREADS
 else
diff --git a/setup.c b/setup.c
index 967f289f1..0879b755f 100644
--- a/setup.c
+++ b/setup.c
@@ -848,6 +848,7 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
        if (nongit_ok)
                *nongit_ok = 0;
 
+       fprintf(stderr,"*** DBG ***\n");
        if (strbuf_getcwd(&cwd))
                die_errno(_("Unable to read current working directory"));
        offset = cwd.len;
diff --git a/strbuf.c b/strbuf.c
index 8fec6579f..bd598e440 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -442,13 +442,25 @@ int strbuf_getcwd(struct strbuf *sb)
 {
        size_t oldalloc = sb->alloc;
        size_t guessed_len = 128;
+char *USER_diag;
+int USER_i=0;
+
+       struct timespec spec;
+
+       clock_gettime(CLOCK_REALTIME, &spec);
+
+
+       fprintf(stderr,"PID:%d DBG[strbuf_getcwd()]\n",getpid());
 
        for (;; guessed_len *= 2) {
                strbuf_grow(sb, guessed_len);
-               if (getcwd(sb->buf, sb->alloc)) {
+               fprintf(stderr,"PID:%d TIME:%ld DBG<BEFORE getcwd()> sb->buf[%s]length(%lu) sb->alloc[%lu]\n",getpid(),spec.tv_nsec,sb->buf,strlen(sb->buf),sb->alloc);
+               if (USER_diag=getcwd(sb->buf, sb->alloc)) {
+                       USER_i++;
+                       fprintf(stderr,"PID:%d getcwd success? Result [%s] loop step number %d\n",getpid(),USER_diag,USER_i);
                        strbuf_setlen(sb, strlen(sb->buf));
                        return 0;
-               }
+               }else{fprintf(stderr,"PID: %d >>DBG<< not expected value!\n",getpid());}
                if (errno != ERANGE)
                        break;
        }
diff --git a/usage.c b/usage.c
index ad6d2910f..989403829 100644
--- a/usage.c
+++ b/usage.c
@@ -6,6 +6,8 @@
 #include "git-compat-util.h"
 #include "cache.h"
 
+#include <execinfo.h>
+
 static FILE *error_handle;
 
 void vreportf(const char *prefix, const char *err, va_list params)
@@ -30,7 +32,21 @@ static NORETURN void usage_builtin(const char *err, va_list params)
 
 static NORETURN void die_builtin(const char *err, va_list params)
 {
-       vreportf("fatal: ", err, params);
+       void *btlist[30];
+       size_t size, i;
+       char **strings;
+               
+       size=backtrace(btlist,30);
+       strings=backtrace_symbols(btlist,size);
+
+       fprintf(stderr,"\n-----[DBG] PID:%d -----\n",getpid());
+         for (i = 0; i < size; i++)
+                      fprintf (stderr,"%s\n", strings[i]);
+
+           free (strings);
+
+       vreportf("DBG fatal: ", err, params);
+       fprintf(stderr,"\n----------------\n");
        exit(128);
 }

After installation of altered git:

$bundle install --deployment --without postgres sqlite development test therubyracer docker 
=== DEBUG OUTPUT BEGIN ===
The git source `git://github.com/oliverguenther/omniauth.git` uses the `git` protocol, which transmits data without encryption. Disable this warning with `bundle config git.allow_insecure true`, or switch to the `https` protocol to keep your data secure.
The git source `git://github.com/finnlabs/awesome_nested_set.git` uses the `git` protocol, which transmits data without encryption. Disable this warning with `bundle config git.allow_insecure true`, or switch to the `https` protocol to keep your data secure.
The git source `git://github.com/why-el/svg-graph.git` uses the `git` protocol, which transmits data without encryption. Disable this warning with `bundle config git.allow_insecure true`, or switch to the `https` protocol to keep your data secure.
The git source `git://github.com/opf/rails-angular-xss.git` uses the `git` protocol, which transmits data without encryption. Disable this warning with `bundle config git.allow_insecure true`, or switch to the `https` protocol to keep your data secure.
The git source `git://github.com/goodwill/capybara-select2.git` uses the `git` protocol, which transmits data without encryption. Disable this warning with `bundle config git.allow_insecure true`, or switch to the `https` protocol to keep your data secure.
The git source `git://github.com/omniauth/omniauth-saml.git` uses the `git` protocol, which transmits data without encryption. Disable this warning with `bundle config git.allow_insecure true`, or switch to the `https` protocol to keep your data secure.
Fetching gem metadata from https://rubygems.org/.......
Fetching version metadata from https://rubygems.org/..
Fetching dependency metadata from https://rubygems.org/.
*** DBG ***
PID:94818 DBG[strbuf_getcwd()]
PID:94818 TIME:319762826 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[129]
PID: 94818 >>DBG<< not expected value!
PID:94818 TIME:319762826 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[257]
PID:94818 getcwd success? Result [/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/cache/bundler/git/awesome_nested_set-209215f38dc7f6765d32201897f8688e973f4de7] loop step number 1
PID:94818 DBG[strbuf_getcwd()]
PID:94818 TIME:323757205 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[129]
PID: 94818 >>DBG<< not expected value!
PID:94818 TIME:323757205 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[257]
PID:94818 getcwd success? Result [/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/cache/bundler/git/awesome_nested_set-209215f38dc7f6765d32201897f8688e973f4de7] loop step number 1
*** DBG ***
PID:94819 DBG[strbuf_getcwd()]
PID:94819 TIME:335244142 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[129]
PID: 94819 >>DBG<< not expected value!
PID:94819 TIME:335244142 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[257]
PID:94819 getcwd success? Result [/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/bundler/gems/awesome_nested_set-7bd473e845e2] loop step number 1
PID:94819 DBG[strbuf_getcwd()]
PID:94819 TIME:338873233 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[129]
PID: 94819 >>DBG<< not expected value!
PID:94819 TIME:338873233 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[257]
PID:94819 getcwd success? Result [/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/bundler/gems/awesome_nested_set-7bd473e845e2] loop step number 1
PID:94819 DBG[strbuf_getcwd()]
PID:94819 TIME:343362594 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[129]
PID: 94819 >>DBG<< not expected value!
PID:94819 TIME:343362594 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[257]
PID:94819 getcwd success? Result [/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/bundler/gems/awesome_nested_set-7bd473e845e2] loop step number 1
PID:94820 DBG[strbuf_getcwd()]
PID:94820 TIME:353434903 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[129]
PID: 94820 >>DBG<< not expected value!
PID:94820 TIME:353434903 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[257]
PID:94820 getcwd success? Result [/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/cache/bundler/git/awesome_nested_set-209215f38dc7f6765d32201897f8688e973f4de7] loop step number 1
*** DBG ***
PID:94822 DBG[strbuf_getcwd()]
PID:94822 TIME:371149025 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[129]
PID: 94822 >>DBG<< not expected value!
PID:94822 TIME:371149025 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[257]
PID:94822 getcwd success? Result [/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/bundler/gems/awesome_nested_set-7bd473e845e2] loop step number 1
PID:94822 DBG[strbuf_getcwd()]
PID:94822 TIME:374747601 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[129]
PID: 94822 >>DBG<< not expected value!
PID:94822 TIME:374747601 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[257]
PID:94822 getcwd success? Result [/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/bundler/gems/awesome_nested_set-7bd473e845e2] loop step number 1
PID:94822 DBG[strbuf_getcwd()]
PID:94822 TIME:378719206 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[129]
PID: 94822 >>DBG<< not expected value!
PID:94822 TIME:378719206 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[257]
PID:94822 getcwd success? Result [/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/bundler/gems/awesome_nested_set-7bd473e845e2] loop step number 1
*** DBG ***
PID:94823 DBG[strbuf_getcwd()]
PID:94823 TIME:389423303 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[129]
PID: 94823 >>DBG<< not expected value!
PID:94823 TIME:389423303 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[257]
PID:94823 getcwd success? Result [/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/bundler/gems/awesome_nested_set-7bd473e845e2] loop step number 1
PID:94823 DBG[strbuf_getcwd()]
PID:94823 TIME:392901921 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[129]
PID: 94823 >>DBG<< not expected value!
PID:94823 TIME:392901921 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[257]
PID:94823 getcwd success? Result [/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/bundler/gems/awesome_nested_set-7bd473e845e2] loop step number 1
PID:94823 DBG[strbuf_getcwd()]
PID:94823 TIME:396779140 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[129]
PID: 94823 >>DBG<< not expected value!
PID:94823 TIME:396779140 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[257]
PID:94823 getcwd success? Result [/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/bundler/gems/awesome_nested_set-7bd473e845e2] loop step number 1
*** DBG ***
PID:94824 DBG[strbuf_getcwd()]
PID:94824 TIME:405767954 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[129]
PID: 94824 >>DBG<< not expected value!
PID:94824 TIME:405767954 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[257]
PID:94824 getcwd success? Result [/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/bundler/gems/awesome_nested_set-7bd473e845e2] loop step number 1
PID:94824 DBG[strbuf_getcwd()]
PID:94824 TIME:409104219 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[129]
PID: 94824 >>DBG<< not expected value!
PID:94824 TIME:409104219 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[257]
PID:94824 getcwd success? Result [/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/bundler/gems/awesome_nested_set-7bd473e845e2] loop step number 1
PID:94824 DBG[strbuf_getcwd()]
PID:94824 TIME:413360941 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[129]
PID: 94824 >>DBG<< not expected value!
PID:94824 TIME:413360941 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[257]
PID:94824 getcwd success? Result [/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/bundler/gems/awesome_nested_set-7bd473e845e2] loop step number 1
PID:94824 DBG[strbuf_getcwd()]
PID:94824 TIME:416863094 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[129]
PID: 94824 >>DBG<< not expected value!
PID:94824 TIME:416863094 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[257]
PID:94824 getcwd success? Result [/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/bundler/gems/awesome_nested_set-7bd473e845e2] loop step number 1
PID:94824 DBG[strbuf_getcwd()]
PID:94824 TIME:420124766 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[129]
PID: 94824 >>DBG<< not expected value!
PID:94824 TIME:420124766 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[257]
PID:94824 getcwd success? Result [/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/bundler/gems/awesome_nested_set-7bd473e845e2] loop step number 1
PID:94824 DBG[strbuf_getcwd()]
PID:94824 TIME:425145306 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[129]
PID: 94824 >>DBG<< not expected value!
PID:94824 TIME:425145306 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[257]
PID:94824 getcwd success? Result [/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/bundler/gems/awesome_nested_set-7bd473e845e2] loop step number 1
PID:94824 DBG[strbuf_getcwd()]
PID:94824 TIME:428797180 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[129]
PID: 94824 >>DBG<< not expected value!
PID:94824 TIME:428797180 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[257]
PID:94824 getcwd success? Result [/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/bundler/gems/awesome_nested_set-7bd473e845e2] loop step number 1
PID:94824 DBG[strbuf_getcwd()]
PID:94824 TIME:432288523 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[129]
PID: 94824 >>DBG<< not expected value!
PID:94824 TIME:432288523 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[257]
PID:94824 getcwd success? Result [/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/bundler/gems/awesome_nested_set-7bd473e845e2] loop step number 1
*** DBG ***
PID:94841 DBG[strbuf_getcwd()]
PID:94841 TIME:473033293 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[129]
PID: 94841 >>DBG<< not expected value!
PID:94841 TIME:473033293 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[257]
PID:94841 getcwd success? Result [/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/bundler/gems/awesome_nested_set-7bd473e845e2] loop step number 1
PID:94841 DBG[strbuf_getcwd()]
PID:94841 TIME:476443996 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[129]
PID: 94841 >>DBG<< not expected value!
PID:94841 TIME:476443996 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[257]
PID:94841 getcwd success? Result [/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/bundler/gems/awesome_nested_set-7bd473e845e2] loop step number 1
*** DBG ***
PID:94843 DBG[strbuf_getcwd()]
PID:94843 TIME:483572829 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[129]
PID: 94843 >>DBG<< not expected value!
PID:94843 TIME:483572829 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[257]
PID:94843 getcwd success? Result [/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/bundler/gems/awesome_nested_set-7bd473e845e2] loop step number 1
PID:94843 DBG[strbuf_getcwd()]
PID:94843 TIME:487028828 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[129]
PID: 94843 >>DBG<< not expected value!
PID:94843 TIME:487028828 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[257]
PID:94843 getcwd success? Result [/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/bundler/gems/awesome_nested_set-7bd473e845e2] loop step number 1
*** DBG ***
PID:94844 DBG[strbuf_getcwd()]
PID:94844 TIME:493903306 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[129]
PID: 94844 >>DBG<< not expected value!
PID:94844 TIME:493903306 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[257]
PID:94844 getcwd success? Result [/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/bundler/gems/awesome_nested_set-7bd473e845e2] loop step number 1
PID:94844 DBG[strbuf_getcwd()]
PID:94844 TIME:497394735 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[129]
PID: 94844 >>DBG<< not expected value!
PID:94844 TIME:497394735 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[257]
PID:94844 getcwd success? Result [/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/bundler/gems/awesome_nested_set-7bd473e845e2] loop step number 1
*** DBG ***
PID:94846 DBG[strbuf_getcwd()]
PID:94846 TIME:509674151 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[129]
PID: 94846 >>DBG<< not expected value!
PID:94846 TIME:509674151 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[257]
PID:94846 getcwd success? Result [/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/bundler/gems/awesome_nested_set-7bd473e845e2] loop step number 1
PID:94846 DBG[strbuf_getcwd()]
PID:94846 TIME:512716769 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[129]
PID: 94846 >>DBG<< not expected value!
PID:94846 TIME:512716769 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[257]
PID:94846 getcwd success? Result [/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/bundler/gems/awesome_nested_set-7bd473e845e2] loop step number 1
*** DBG ***
PID:94847 DBG[strbuf_getcwd()]
PID:94847 TIME:520195459 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[129]
PID: 94847 >>DBG<< not expected value!
PID:94847 TIME:520195459 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[257]
PID:94847 getcwd success? Result [/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/bundler/gems/awesome_nested_set-7bd473e845e2] loop step number 1
PID:94847 DBG[strbuf_getcwd()]
PID:94847 TIME:523205769 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[129]
PID: 94847 >>DBG<< not expected value!
PID:94847 TIME:523205769 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[257]
PID:94847 getcwd success? Result [/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/bundler/gems/awesome_nested_set-7bd473e845e2] loop step number 1
*** DBG ***
PID:94850 DBG[strbuf_getcwd()]
PID:94850 TIME:531746240 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[129]
PID: 94850 >>DBG<< not expected value!
PID:94850 TIME:531746240 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[257]
PID:94850 getcwd success? Result [/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/bundler/gems/awesome_nested_set-7bd473e845e2] loop step number 1
PID:94850 DBG[strbuf_getcwd()]
PID:94850 TIME:534777909 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[129]
PID: 94850 >>DBG<< not expected value!
PID:94850 TIME:534777909 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[257]
PID:94850 getcwd success? Result [/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/bundler/gems/awesome_nested_set-7bd473e845e2] loop step number 1
*** DBG ***
PID:94853 DBG[strbuf_getcwd()]
PID:94853 TIME:584052480 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[129]
PID: 94853 >>DBG<< not expected value!
PID:94853 TIME:584052480 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[257]
PID:94853 getcwd success? Result [/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/cache/bundler/git/omniauth-9b858eeaf5d57cfe59f1c1084cdc9eb1ee6989b2] loop step number 1
PID:94853 DBG[strbuf_getcwd()]
PID:94853 TIME:587643433 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[129]
PID: 94853 >>DBG<< not expected value!
PID:94853 TIME:587643433 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[257]
PID:94853 getcwd success? Result [/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/cache/bundler/git/omniauth-9b858eeaf5d57cfe59f1c1084cdc9eb1ee6989b2] loop step number 1
*** DBG ***
PID:94854 DBG[strbuf_getcwd()]
PID:94854 TIME:598012950 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[129]
PID: 94854 >>DBG<< not expected value!

-----[DBG] PID:94854 -----
0x550612 <die_builtin+0x32> at /home/USER/bin/git
0x5500d9 <die_errno+0xc9> at /home/USER/bin/git
0x526f67 <setup_git_directory_gently+0x677> at /home/USER/bin/git
0x405635 <handle_builtin+0x145> at /home/USER/bin/git
0x404fcd <cmd_main+0xfd> at /home/USER/bin/git
0x47f779 <main+0x69> at /home/USER/bin/git
0x404d8f <_start+0x16f> at /home/USER/bin/git
DBG fatal: Unable to read current working directory: Permission denied

----------------

Retrying `git fetch --force --quiet --tags "/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/cache/bundler/git/omniauth-9b858eeaf5d57cfe59f1c1084cdc9eb1ee6989b2"` due to error (2/4): Bundler::Source::Git::GitCommandError Git error: command `git fetch --force --quiet --tags "/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/cache/bundler/git/omniauth-9b858eeaf5d57cfe59f1c1084cdc9eb1ee6989b2"` in directory /usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/bundler/gems/omniauth-8385bc0da47e has failed.
If this error persists you could try removing the cache directory '/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/cache/bundler/git/omniauth-9b858eeaf5d57cfe59f1c1084cdc9eb1ee6989b2'*** DBG ***
PID:94855 DBG[strbuf_getcwd()]
PID:94855 TIME:617961661 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[129]
PID: 94855 >>DBG<< not expected value!

-----[DBG] PID:94855 -----
0x550612 <die_builtin+0x32> at /home/USER/bin/git
0x5500d9 <die_errno+0xc9> at /home/USER/bin/git
0x526f67 <setup_git_directory_gently+0x677> at /home/USER/bin/git
0x405635 <handle_builtin+0x145> at /home/USER/bin/git
0x404fcd <cmd_main+0xfd> at /home/USER/bin/git
0x47f779 <main+0x69> at /home/USER/bin/git
0x404d8f <_start+0x16f> at /home/USER/bin/git
DBG fatal: Unable to read current working directory: Permission denied

----------------

Retrying `git fetch --force --quiet --tags "/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/cache/bundler/git/omniauth-9b858eeaf5d57cfe59f1c1084cdc9eb1ee6989b2"` due to error (3/4): Bundler::Source::Git::GitCommandError Git error: command `git fetch --force --quiet --tags "/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/cache/bundler/git/omniauth-9b858eeaf5d57cfe59f1c1084cdc9eb1ee6989b2"` in directory /usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/bundler/gems/omniauth-8385bc0da47e has failed.
If this error persists you could try removing the cache directory '/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/cache/bundler/git/omniauth-9b858eeaf5d57cfe59f1c1084cdc9eb1ee6989b2'*** DBG ***
PID:94856 DBG[strbuf_getcwd()]
PID:94856 TIME:649649505 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[129]
PID: 94856 >>DBG<< not expected value!

-----[DBG] PID:94856 -----
0x550612 <die_builtin+0x32> at /home/USER/bin/git
0x5500d9 <die_errno+0xc9> at /home/USER/bin/git
0x526f67 <setup_git_directory_gently+0x677> at /home/USER/bin/git
0x405635 <handle_builtin+0x145> at /home/USER/bin/git
0x404fcd <cmd_main+0xfd> at /home/USER/bin/git
0x47f779 <main+0x69> at /home/USER/bin/git
0x404d8f <_start+0x16f> at /home/USER/bin/git
DBG fatal: Unable to read current working directory: Permission denied

----------------

Retrying `git fetch --force --quiet --tags "/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/cache/bundler/git/omniauth-9b858eeaf5d57cfe59f1c1084cdc9eb1ee6989b2"` due to error (4/4): Bundler::Source::Git::GitCommandError Git error: command `git fetch --force --quiet --tags "/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/cache/bundler/git/omniauth-9b858eeaf5d57cfe59f1c1084cdc9eb1ee6989b2"` in directory /usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/bundler/gems/omniauth-8385bc0da47e has failed.
If this error persists you could try removing the cache directory '/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/cache/bundler/git/omniauth-9b858eeaf5d57cfe59f1c1084cdc9eb1ee6989b2'*** DBG ***
PID:94859 DBG[strbuf_getcwd()]
PID:94859 TIME:672228216 DBG<BEFORE getcwd()> sb->buf[]length(0) sb->alloc[129]
PID: 94859 >>DBG<< not expected value!

-----[DBG] PID:94859 -----
0x550612 <die_builtin+0x32> at /home/USER/bin/git
0x5500d9 <die_errno+0xc9> at /home/USER/bin/git
0x526f67 <setup_git_directory_gently+0x677> at /home/USER/bin/git
0x405635 <handle_builtin+0x145> at /home/USER/bin/git
0x404fcd <cmd_main+0xfd> at /home/USER/bin/git
0x47f779 <main+0x69> at /home/USER/bin/git
0x404d8f <_start+0x16f> at /home/USER/bin/git
DBG fatal: Unable to read current working directory: Permission denied

----------------

Git error: command `git fetch --force --quiet --tags
"/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/cache/bundler/git/omniauth-9b858eeaf5d57cfe59f1c1084cdc9eb1ee6989b2"`
in directory /usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/bundler/gems/omniauth-8385bc0da47e has failed.
If this error persists you could try removing the cache directory
'/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/cache/bundler/git/omniauth-9b858eeaf5d57cfe59f1c1084cdc9eb1ee6989b2'

=== DEBUG OUTPUT END ===

Debug meassages have time stamps with time in nanoseconds and PIDs printed.



On another server with same OS configuration there was problem with:

$ npm install

> openproject@0.1.0 postinstall /usr/home/USER/openproject
> cd frontend && npm install

npm ERR! git clone --template=/home/USER/.npm/_git-remotes/_templates --mirror git://github.com/opf/angular-context-menu.git /home/USER/.npm/_git-remotes/git-github-com-opf-angular-context-menu-git-a908eccaec323cd66973d58af4965694bdff16a1-d8746dcc: Cloning into bare repository '/home/USER/.npm/_git-remotes/git-github-com-opf-angular-context-menu-git-a908eccaec323cd66973d58af4965694bdff16a1-d8746dcc'...
npm ERR! git clone --template=/home/USER/.npm/_git-remotes/_templates --mirror git://github.com/opf/angular-context-menu.git /home/USER/.npm/_git-remotes/git-github-com-opf-angular-context-menu-git-a908eccaec323cd66973d58af4965694bdff16a1-d8746dcc: fatal: Could not get current working directory: Permission denied
npm ERR! git clone --template=/home/USER/.npm/_git-remotes/_templates --mirror git://github.com/finnlabs/angular-modal.git /home/USER/.npm/_git-remotes/git-github-com-finnlabs-angular-modal-git-d45eb9ceb720b8785613ba89ba0f14f8ab197569-619b970d: Cloning into bare repository '/home/USER/.npm/_git-remotes/git-github-com-finnlabs-angular-modal-git-d45eb9ceb720b8785613ba89ba0f14f8ab197569-619b970d'...
npm ERR! git clone --template=/home/USER/.npm/_git-remotes/_templates --mirror git://github.com/finnlabs/angular-modal.git /home/USER/.npm/_git-remotes/git-github-com-finnlabs-angular-modal-git-d45eb9ceb720b8785613ba89ba0f14f8ab197569-619b970d: fatal: Could not get current working directory: Permission denied
npm ERR! git clone --template=/home/USER/.npm/_git-remotes/_templates --mirror git://github.com/sparkalow/angular-truncate.git /home/USER/.npm/_git-remotes/git-github-com-sparkalow-angular-truncate-git-fdf60fda265042d12e9414b5354b2cc52f1419de-3ed663f6: Cloning into bare repository '/home/USER/.npm/_git-remotes/git-github-com-sparkalow-angular-truncate-git-fdf60fda265042d12e9414b5354b2cc52f1419de-3ed663f6'...
npm ERR! git clone --template=/home/USER/.npm/_git-remotes/_templates --mirror git://github.com/sparkalow/angular-truncate.git /home/USER/.npm/_git-remotes/git-github-com-sparkalow-angular-truncate-git-fdf60fda265042d12e9414b5354b2cc52f1419de-3ed663f6: fatal: Could not get current working directory: Permission denied
npm ERR! FreeBSD 10.3-STABLE
npm ERR! argv "/usr/local/bin/node" "/usr/local/bin/npm" "install"
npm ERR! node v4.7.2
npm ERR! npm  v4.0.5
npm ERR! code 128

npm ERR! Command failed: git clone --template=/home/USER/.npm/_git-remotes/_templates --mirror git://github.com/opf/angular-context-menu.git /home/USER/.npm/_git-remotes/git-github-com-opf-angular-context-menu-git-a908eccaec323cd66973d58af4965694bdff16a1-d8746dcc
npm ERR! Cloning into bare repository '/home/USER/.npm/_git-remotes/git-github-com-opf-angular-context-menu-git-a908eccaec323cd66973d58af4965694bdff16a1-d8746dcc'...
npm ERR! fatal: Could not get current working directory: Permission denied
npm ERR! 
npm ERR! 
npm ERR! If you need help, you may report this error at:
npm ERR!     <https://github.com/npm/npm/issues>

npm ERR! Please include the following file with any support request:
npm ERR!     /usr/home/USER/openproject/frontend/npm-debug.log

npm ERR! FreeBSD 10.3-STABLE
npm ERR! argv "/usr/local/bin/node" "/usr/local/bin/npm" "install"
npm ERR! node v4.7.2
npm ERR! npm  v4.0.5
npm ERR! code ELIFECYCLE
npm ERR! openproject@0.1.0 postinstall: `cd frontend && npm install`
npm ERR! Exit status 1
npm ERR! 
npm ERR! Failed at the openproject@0.1.0 postinstall script 'cd frontend && npm install'.
npm ERR! Make sure you have the latest version of node.js and npm installed.
npm ERR! If you do, this is most likely a problem with the openproject package,
npm ERR! not with npm itself.
npm ERR! Tell the author that this fails on your system:
npm ERR!     cd frontend && npm install
npm ERR! You can get information on how to open an issue for this project with:
npm ERR!     npm bugs openproject
npm ERR! Or if that isn't available, you can get their info via:
npm ERR!     npm owner ls openproject
npm ERR! There is likely additional logging output above.

npm ERR! Please include the following file with any support request:
npm ERR!     /usr/home/USER/openproject/npm-debug.log

