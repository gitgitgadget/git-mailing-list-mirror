Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1A2B1F453
	for <e@80x24.org>; Fri,  8 Feb 2019 07:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfBHHCZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 02:02:25 -0500
Received: from gproxy1-pub.mail.unifiedlayer.com ([69.89.25.95]:46993 "EHLO
        gproxy1-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726004AbfBHHCY (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 Feb 2019 02:02:24 -0500
X-Greylist: delayed 1840 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Feb 2019 02:02:24 EST
Received: from cmgw14.unifiedlayer.com (unknown [10.9.0.14])
        by gproxy1.mail.unifiedlayer.com (Postfix) with ESMTP id 0B09079670AA5
        for <git@vger.kernel.org>; Thu,  7 Feb 2019 23:13:09 -0700 (MST)
Received: from host200.hostmonster.com ([74.220.207.200])
        by cmsmtp with ESMTP
        id rzPQgginJXFO5rzPQgS6U7; Thu, 07 Feb 2019 23:13:09 -0700
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=whamtech.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:To:Subject:From:Reply-To:Sender:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Zp10/4Cl17NR77OH4EDRtOKBFBxzaZizrD6+AlK/MMs=; b=WYbyv4Y8Mea3Z3FrelO0y1CPqd
        9YbmWzO02kobeJHY+6hlZo3W2Qd1dhTZ1xMRwNWA99glMMjzdfp0xIksbyVHvKRLPnwvRwBfFtYm9
        rdz9PmUDFNvLqb1VCUUhjW29K;
Received: from [147.75.195.120] (port=56306 helo=Douglas-Godfrey-2s-Mac-Pro.local)
        by host200.hostmonster.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <douglas.godfrey@whamtech.com>)
        id 1grzPQ-001Fdg-90
        for git@vger.kernel.org; Thu, 07 Feb 2019 23:13:08 -0700
Reply-To: douglas.godfrey@whamtech.com
From:   Douglas Godfrey <douglas.godfrey@whamtech.com>
Subject: undefined symbols building GIT source from githu
Organization: WhamTech, Inc.
To:     git@vger.kernel.org
Message-ID: <1a9f02ca-3bc3-f00f-6923-1bbf050e84ca@whamtech.com>
Date:   Fri, 8 Feb 2019 01:13:04 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:45.0)
 Gecko/20100101 Thunderbird/45.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host200.hostmonster.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - whamtech.com
X-BWhitelist: no
X-Source-IP: 147.75.195.120
X-Source-L: No
X-Exim-ID: 1grzPQ-001Fdg-90
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (Douglas-Godfrey-2s-Mac-Pro.local) [147.75.195.120]:56306
X-Source-Auth: douglas.godfrey@whamtech.com
X-Email-Count: 1
X-Source-Cap: d2hhbXRlY2g7d2hhbXRlY2g7aG9zdDIwMC5ob3N0bW9uc3Rlci5jb20=
X-Local-Domain: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

MacOS X Snow Leopard
openssl-1.1.1a installed

Building git-master downloaded from github on 2/7/2019
The same error occurs building git-2.9.5

What is missing in this project?

git-master did not have a configure script so I ran autoconf to generate one.
git-master did not have a config-guess or config-sub.

Compile with GCC 6.2

./configure --with-libpcre2 --with-openssl --with-curl

configure: Setting lib to 'lib' (the default)
configure: Will try -pthread then -lpthread to enable POSIX Threads.
configure: CHECKS for site configuration
checking for gcc... /usr/local/Cellar/gcc6/6.2.0/bin/gcc-6
checking for C compiler default output file name... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... no
checking for suffix of executables...
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether /usr/local/Cellar/gcc6/6.2.0/bin/gcc-6 accepts -g... yes
checking for /usr/local/Cellar/gcc6/6.2.0/bin/gcc-6 option to accept ISO C89... none needed
checking how to run the C preprocessor... /usr/local/Cellar/gcc6/6.2.0/bin/cpp-6
checking for grep that handles long lines and -e... /usr/bin/grep
checking for egrep... /usr/bin/grep -E
checking for ANSI C header files... yes
checking for sys/types.h... yes
checking for sys/stat.h... yes
checking for stdlib.h... yes
checking for string.h... yes
checking for memory.h... yes
checking for strings.h... yes
checking for inttypes.h... yes
checking for stdint.h... yes
checking for unistd.h... yes
checking for working alloca.h... yes
checking for alloca... yes
configure: CHECKS for programs
checking whether we are using the GNU C compiler... (cached) yes
checking whether /usr/local/Cellar/gcc6/6.2.0/bin/gcc-6 accepts -g... (cached) yes
checking for /usr/local/Cellar/gcc6/6.2.0/bin/gcc-6 option to accept ISO C89... (cached) none needed
checking for inline... inline
checking if linker supports -R... no
checking if linker supports -Wl,-rpath,... yes
checking for gar... gar
checking for gtar... no
checking for tar... tar
checking for gnudiff... no
checking for gdiff... no
checking for diff... diff
checking for asciidoc... asciidoc
checking for asciidoc version... asciidoc 8.6.9
Using 'grep -a' for sane_grep
configure: CHECKS for libraries
checking for SHA1_Init in -lcrypto... yes
checking for pcre2_config_8 in -lpcre2-8... yes
checking for curl_global_init in -lcurl... yes
checking for curl-config... curl-config
configure: Setting CURL_LDFLAGS to '-lcurl'
checking for XML_ParserCreate in -lexpat... yes
checking for iconv in -lc... no
checking for iconv in -liconv... yes
checking for deflateBound in -lz... yes
checking for socket in -lc... yes
checking for inet_ntop... yes
checking for inet_pton... yes
checking for hstrerror... yes
checking for basename in -lc... yes
checking for gettext in -lc... no
checking libintl.h usability... no
checking libintl.h presence... no
checking for libintl.h... no
configure: CHECKS for header files
checking sys/select.h usability... yes
checking sys/select.h presence... yes
checking for sys/select.h... yes
checking poll.h usability... yes
checking poll.h presence... yes
checking for poll.h... yes
checking sys/poll.h usability... yes
checking sys/poll.h presence... yes
checking for sys/poll.h... yes
checking for inttypes.h... (cached) yes
checking for old iconv()... no
configure: CHECKS for typedefs, structures, and compiler characteristics
checking for socklen_t... yes
checking for struct itimerval... yes
checking for struct stat.st_mtimespec.tv_nsec... yes
checking for struct stat.st_mtim.tv_nsec... no
checking for struct dirent.d_type... yes
checking for struct passwd.pw_gecos... yes
checking for struct sockaddr_storage... yes
checking for struct addrinfo... yes
checking for getaddrinfo... yes
checking for library containing getaddrinfo... none required
checking whether the platform regex supports REG_STARTEND... yes
checking whether system succeeds to read fopen'ed directory... yes
checking whether snprintf() and/or vsnprintf() return bogus value... no
checking whether the platform uses typical file type bits... yes
configure: CHECKS for library functions
checking libgen.h usability... yes
checking libgen.h presence... yes
checking for libgen.h... yes
checking paths.h usability... yes
checking paths.h presence... yes
checking for paths.h... yes
checking libcharset.h usability... yes
checking libcharset.h presence... yes
checking for libcharset.h... yes
checking for strings.h... (cached) yes
checking for locale_charset in -liconv... yes
checking for clock_gettime... no
checking for CLOCK_MONOTONIC... no
checking for setitimer... yes
checking for library containing setitimer... none required
checking for strcasestr... yes
checking for library containing strcasestr... none required
checking for memmem... no
checking for strlcpy... yes
checking for library containing strlcpy... none required
checking for uintmax_t... yes
checking for strtoumax... yes
checking for library containing strtoumax... none required
checking for setenv... yes
checking for library containing setenv... none required
checking for unsetenv... yes
checking for library containing unsetenv... none required
checking for mkdtemp... yes
checking for library containing mkdtemp... none required
checking for initgroups... yes
checking for library containing initgroups... none required
checking for getdelim... no
checking for BSD sysctl... yes
checking for POSIX Threads with ''... yes
configure: creating ./config.status
config.status: creating config.mak.autogen
config.status: executing config.mak.autogen commands

make

ld: warning: in libgit.a, file was built for unsupported file format which is not the architecture being linked (x86_64)
ld: warning: in xdiff/lib.a, file was built for unsupported file format which is not the architecture being linked (x86_64)
Undefined symbols:
   "_strbuf_addstr_urlencode", referenced from:
       _store_credential_file in credential-store.o
       _store_credential_file in credential-store.o
       _store_credential_file in credential-store.o
       _store_credential_file in credential-store.o
   "_attr_start", referenced from:
       _main in common-main.o
   "_strbuf_release", referenced from:
       _parse_credential_file in credential-store.o
       _store_credential_file in credential-store.o
   "_string_list_append", referenced from:
       _cmd_main in credential-store.o
   "_credential_clear", referenced from:
       _parse_credential_file in credential-store.o
   "_initialize_the_repository", referenced from:
       _main in common-main.o
   "_strbuf_getline_lf", referenced from:
       _parse_credential_file in credential-store.o
       _parse_credential_file in credential-store.o
   "_usage_with_options", referenced from:
       _cmd_main in credential-store.o
   "_credential_from_url", referenced from:
       _parse_credential_file in credential-store.o
   "_credential_read", referenced from:
       _cmd_main in credential-store.o
   "_commit_lock_file", referenced from:
       _rewrite_credential_file in credential-store.o
   "_die_errno", referenced from:
       _parse_credential_file in credential-store.o
       _rewrite_credential_file in credential-store.o
       _rewrite_credential_file in credential-store.o
   "_credential_match", referenced from:
       _parse_credential_file in credential-store.o
   "_string_list_clear", referenced from:
       _cmd_main in credential-store.o
   "_git_fopen", referenced from:
       _parse_credential_file in credential-store.o
   "_hold_lock_file_for_update_timeout", referenced from:
       _rewrite_credential_file in credential-store.o
   "_strbuf_slopbuf", referenced from:
       _parse_credential_file in credential-store.o
       _store_credential_file in credential-store.o
   "_use_gettext_poison", referenced from:
       _main in common-main.o
   "_expand_user_path", referenced from:
       _cmd_main in credential-store.o
   "_parse_options", referenced from:
       _cmd_main in credential-store.o
   "_git_resolve_executable_dir", referenced from:
       _main in common-main.o
   "_write_or_die", referenced from:
       _print_line in credential-store.o
   "_die", referenced from:
       _cmd_main in credential-store.o
       _cmd_main in credential-store.o
   "_string_list_append_nodup", referenced from:
       _cmd_main in credential-store.o
       _cmd_main in credential-store.o
   "_strbuf_addf", referenced from:
       _store_credential_file in credential-store.o
   "_get_tempfile_fd", referenced from:
       _print_line in credential-store.o
   "_sanitize_stdfds", referenced from:
       _main in common-main.o
   "_strbuf_grow", referenced from:
       _print_line in credential-store.o
       _store_credential_file in credential-store.o
       _store_credential_file in credential-store.o
       _store_credential_file in credential-store.o
   "_xdg_config_home", referenced from:
       _cmd_main in credential-store.o
ld: symbol(s) not found
collect2: error: ld returned 1 exit status
make: *** [git-credential-store] Error 1
Douglas-Godfrey-2s-Mac-Pro:git-master dgodfrey$











