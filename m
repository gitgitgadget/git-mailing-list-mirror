Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF0E71F461
	for <e@80x24.org>; Tue, 27 Aug 2019 13:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbfH0NqT (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 09:46:19 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41333 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfH0NqT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 09:46:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id j16so18859893wrr.8
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 06:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wZVtg5Hfm6eEVTb5At3al/1Uo+VHxoFwk95CXnYF6Yg=;
        b=NM0LTCAEoDugrY1/5HrSHRzy5CMUZlIwspHFfyAfngwGBQQBBRRJHt3nLutsQRv3BN
         RIFGgJ76NFSeIA3C0kJ9/Wwl5c9nhIrDfpsdZ7VTSw+bcI3GWVSPR7MVc+2mwqm9jtKs
         jxXY7NiV7smRpw1meidyGpILd+vhcwNhOQYeD5pgVpTNaU0Qp6hT8U/yLGAAU/neQfZP
         DNQY3LznXYKzEXeHfAGnZID8H+K3vAZedU6Li+m+Y6TCSK+r6E2VS4jbDN5jlq/7KzXa
         GdwBBAg0PLKYb1YzxvMfMVmdG0h8d6NsZVh7apaHrn2ED7VMyAcNQRZJIGqKJC5KAgaM
         HIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wZVtg5Hfm6eEVTb5At3al/1Uo+VHxoFwk95CXnYF6Yg=;
        b=rmzTvix1ibZdhuahLNQysVzAG0n7XlIfYvuCi6KOyN+F/x47OPiIWG69Cmh0ChUT9T
         ilz4yj8hdQU3fFiZljMpEVkAQdvfe3UYLITTVC7lBDsN/jmp+ml8xoSiZva4LBB68Vc9
         qMDsYBB1M/hL4+R6jhPj9rKHzy65pH8JU66tWQhBOi+C+6b9l3IWNhhv6oc/cXfc1Sy6
         DbRO7CE0H20p+XmBIefGniwwwrLijwJIPG5ImpJ5lP6kwls+V7SHJUCl50bPKTPUCKPR
         4tl1nWJXezURw+SU1bO9AhKp9/CjsMyWOTJGO3eX+pIBYA7s7tS6soqnWeXSqJN55p1+
         RoDA==
X-Gm-Message-State: APjAAAXzaN+cDcNjy64kXUgODR1WDty+EdZkpkpBAg9h4kWYS6lC84y0
        rXEVIig13SuT3hD/TiIg5chNCSjWnHo=
X-Google-Smtp-Source: APXvYqxpReFJI/oxDHMRat1uKO8lSRu8AsZmTSmTAzl7jYOENtfWkw8JVwZdW641uePLG/2hjAjMDw==
X-Received: by 2002:a5d:4446:: with SMTP id x6mr29223751wrr.11.1566913576784;
        Tue, 27 Aug 2019 06:46:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i5sm20001101wrn.48.2019.08.27.06.46.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 06:46:16 -0700 (PDT)
Date:   Tue, 27 Aug 2019 06:46:16 -0700 (PDT)
X-Google-Original-Date: Tue, 27 Aug 2019 13:46:12 GMT
Message-Id: <pull.305.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.305.git.gitgitgadget@gmail.com>
References: <pull.305.git.gitgitgadget@gmail.com>
From:   "KADOTA, Kyohei via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/3] Port git to Plan 9
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes from v1
===============

 * Use gmake
 * Use sh
 * Remove dependencies to Plan 9 tools; rc and mk

What I did
==========

I ported git, and git subcommands with gmake to Plan 9. This pull request
contains patches for existing codes, and new files to build git in Plan 9.

I added three new options into Makefile.

 * USER_GITCONFIG - default ~/.gitconfig
 * USER_GITCREDENTIALS - default ~/.git-credentials
 * USER_GITCREDENTIAL_CACHE - default ~/.git-credential-cache
 * USE_EXEC_WRAPPER - default empty

In Plan 9, user configuration files are stored at $home/lib, instead of
dotfiles.
http://xahlee.info/UnixResource_dir/writ/unix_origin_of_dot_filename.html

And Plan 9 haven't hard link and symbolic link. Thus I added exec-wrapper to
want to shrink disk usage.
http://doc.cat-v.org/plan_9/4th_edition/papers/lexnames

Installation
============

# ANSI/POSIX commands are installed at /bin only in current namespace.
% bind -a /bin/ape /bin

# Plan 9 C compiler can't initialize struct fields that is bit field so remove bit fields from all C files.
% ./remove-bitfields.sh

# build Git toolchain with /n/sources/contrib/andrey/make-3.81.tgz
% gmake 'prefix=' 'gitexecdir=bin/git-core' 'sysconfdir=sys/lib/git' 'template_dir=sys/lib/git/templates' install

lufia (3):
  Change HOME, PATH, and .gitconfig paths to be customizable
  Fix C syntactic errors for the Plan 9 C compiler
  Support Plan 9 dialect

 GIT-VERSION-GEN               |  2 +-
 Makefile                      | 81 +++++++++++++++++++++++-----
 builtin/config.c              |  2 +-
 compat/plan9/openssl/crypto.h |  5 ++
 compat/regex/regex_internal.h |  3 ++
 config.c                      |  5 +-
 config.mak.uname              | 99 +++++++++++++++++++++++++++++++++++
 credential-cache.c            |  2 +-
 credential-store.c            |  2 +-
 exec-cmd.c                    |  4 +-
 exec-wrapper.c                | 16 ++++++
 generate-cmdlist.sh           | 24 ++++++---
 git-compat-util.h             | 17 +++++-
 help.c                        |  2 +-
 parse-options.h               | 18 +++----
 path.c                        |  6 +--
 remove-bitfields.sh           | 17 ++++++
 run-command.c                 |  4 +-
 sequencer.c                   |  2 +-
 shell.c                       |  2 +-
 t/chainlint.sed               | 66 +++++++++++------------
 templates/Makefile            | 12 ++++-
 22 files changed, 311 insertions(+), 80 deletions(-)
 create mode 100644 compat/plan9/openssl/crypto.h
 create mode 100644 exec-wrapper.c
 create mode 100755 remove-bitfields.sh


base-commit: 745f6812895b31c02b29bdfe4ae8e5498f776c26
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-305%2Flufia%2Fplan9-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-305/lufia/plan9-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/305

Range-diff vs v1:

 1:  fa539c75b2 ! 1:  63e7e7794e Change HOME, PATH, and .gitconfig paths to be customizable
     @@ -10,12 +10,26 @@
       --- a/Makefile
       +++ b/Makefile
      @@
     + localedir = $(sharedir)/locale
     + template_dir = share/git-core/templates
       htmldir = $(prefix)/share/doc/git-doc
     - ETC_GITCONFIG = $(sysconfdir)/gitconfig
     - ETC_GITATTRIBUTES = $(sysconfdir)/gitattributes
     -+USER_GITCONFIG = ~/.gitconfig
     -+USER_GITCREDENTIALS = ~/.git-credentials
     -+USER_GITCREDENTIAL_CACHE = ~/.git-credential-cache
     +-ETC_GITCONFIG = $(sysconfdir)/gitconfig
     +-ETC_GITATTRIBUTES = $(sysconfdir)/gitattributes
     ++ifndef ETC_GITCONFIG
     ++	ETC_GITCONFIG = $(sysconfdir)/gitconfig
     ++endif
     ++ifndef ETC_GITATTRIBUTES
     ++	ETC_GITATTRIBUTES = $(sysconfdir)/gitattributes
     ++endif
     ++ifndef USER_GITCONFIG
     ++	USER_GITCONFIG = ~/.gitconfig
     ++endif
     ++ifndef USER_GITCREDENTIALS
     ++	USER_GITCREDENTIALS = ~/.git-credentials
     ++endif
     ++ifndef USER_GITCREDENTIAL_CACHE
     ++	USER_GITCREDENTIAL_CACHE = ~/.git-credential-cache
     ++endif
       lib = lib
       # DESTDIR =
       pathsep = :
 2:  301a796de9 ! 2:  7abbd36e1d Fix C syntactic errors for the Plan 9 C compiler
     @@ -114,22 +114,25 @@
        * It's okay for the caller to consume argv/argc in the usual way.
        * Other fields of that structure are private to parse-options and should not
      
     - diff --git a/remove-bitfields.rc b/remove-bitfields.rc
     - new file mode 100644
     + diff --git a/remove-bitfields.sh b/remove-bitfields.sh
     + new file mode 100755
       --- /dev/null
     - +++ b/remove-bitfields.rc
     + +++ b/remove-bitfields.sh
      @@
     -+#!/bin/rc
     ++#!/bin/ape/sh
      +# Plan 9 C compiler rejects initialization a structure including bit field.
     -+# usage: remove-bitfields.rc [dir ...]
     ++# usage: remove-bitfields.sh [dir ...]
     ++
     ++if ! echo abc | sed 's/(ab)c/\1/' >/dev/null 2>&1
     ++then
     ++	alias sed='sed -E'
     ++fi
      +
     -+fn sigexit sighup sigint sigquit sigterm {
     -+	rm -f /tmp/remove-bitfields.$pid
     -+	exit
     -+}
     ++trap 'rm -f /tmp/remove-bitfields.$pid; exit 1' 1 2 3 15 EXIT
      +
     -+files=`{du -a $* | awk '/\.[ch]$/ { print $2 }'}
     -+for(i in $files){
     ++files=$(du -a $* | awk '/\.[ch]$/ { print $2 }')
     ++for i in $files
     ++do
      +	sed '/(^[ 	]*\*|\?)/!s/([a-z]+[a-z0-9]*) *: *[0-9]+([,;])/\1\2/g' $i >/tmp/remove-bitfields.$pid
      +	cp /tmp/remove-bitfields.$pid $i
     -+}
     ++done
 3:  df67a7e1d3 < -:  ---------- GIT-VERSION-GEN: Use sed instead of expr
 4:  d25bcb43e1 < -:  ---------- Port generate-cmdline.sh to rc
 5:  d00bbdce0d < -:  ---------- Add plan9/wrap.c
 6:  0494971306 < -:  ---------- Add mkfile to build git and subcommands for Plan 9
 -:  ---------- > 3:  7505e85fc5 Support Plan 9 dialect

-- 
gitgitgadget
