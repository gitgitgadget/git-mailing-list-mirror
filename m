Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF6DC1F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 20:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753154AbcIAU7u (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 16:59:50 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38038 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755315AbcIAU7u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 16:59:50 -0400
Received: by mail-wm0-f51.google.com with SMTP id 1so2408601wmz.1
        for <git@vger.kernel.org>; Thu, 01 Sep 2016 13:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wdqlKodO774Y6qVTrms95IZ4cQCDRuEVSL9mw8UCss0=;
        b=dqv5AOkeHqrpfylir7ZqpZjKYrO8Qp24nTf6o6/W9ZYvzaqZi6G9cuuh2mxe/NdYnq
         c1MhSbP/LZw3OyFNTsVwK4v0fDIsPJG91YsmKo96uv6tRMnbL40GWO+niQA4MQTIeGLu
         AUEr5QCZwhEiVOszVFsJAUh8nUORsVuXvOVK5wh9OgiSOQSj12R38y+z3Hm7fHaCJ3P4
         +212dy+UzTI47AlhIvtMnm/0bzDhFBeThY1ATVwkhtLadyDiWglcZbCTiDeOgKZnxuL4
         DTPL4TEJRoIF9x3BawZFsTPAvGY71+wOKw2AhfZCCHDu0ISwvrdLI3oeVqIVfB6BKoFi
         Oyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wdqlKodO774Y6qVTrms95IZ4cQCDRuEVSL9mw8UCss0=;
        b=LopQoMwlQhcZ+W1fOce5E3yLhtoGIp1v8LeHSfc5grMoNfVWkp7dK+V/yKJ+/BnAA9
         ki9B63H2GDP4BG6S61FyUW2PxffhBcjNHme814+s5Bm+HgwQxQWm/r854kT+f/BBNFiQ
         jHTp93epBxhrV/l425eR2t6dV95AXis/4HHG5l+uxszqunJOXvwVkZ4IVTb6Y2iO9L7g
         syataxJWB9aY+SSXHtWvQAGUq1X259LimfEKDALWa9zL3jcdcRPqVh1ysFFkIn6k3w93
         CJpzAEMFpdSiETjpREnRcyeHMDn3VRV43ZTUCzGacrvuxGcWrY2N5qcUZt4IDIhWAqkd
         eKYQ==
X-Gm-Message-State: AE9vXwMjKKECRm1Hppv+mtD2PVLry+eOICZzpKHursmVy50hBiErqTyLSfpeMsiLZ2Qp0w==
X-Received: by 10.194.97.17 with SMTP id dw17mr15932592wjb.8.1472760419471;
        Thu, 01 Sep 2016 13:06:59 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id i3sm6888265wjd.31.2016.09.01.13.06.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Sep 2016 13:06:57 -0700 (PDT)
Date:   Thu, 1 Sep 2016 21:07:00 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Jan Keromnes <janx@linux.com>
Cc:     git@vger.kernel.org,
        Ingo =?iso-8859-1?Q?Br=FCckl?= <ib@wupperonline.de>,
        Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: `make profile-install` fails in 2.9.3
Message-ID: <20160901200700.GA8254@hank>
References: <CAA6PgK7C18F1WGyZMTEUAWEVsUWqiZND5Ne_0SH-rUEm8u5dNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA6PgK7C18F1WGyZMTEUAWEVsUWqiZND5Ne_0SH-rUEm8u5dNg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[+cc Edward Thomson, Ingo Brückl]

Hi,

On 09/01, Jan Keromnes wrote:

[.. snip the parts others are more qualified to answer ..]
> 
> Related problem: `t3700-add.sh` currently fails in 2.9.3. I can
> provide more debug information if you don't already know this problem.

I noticed this problem as well, when I'm compiling with USE_NSEC = 1
in my config.mak.

Tracking this problem down a bit, it happens because the --chmod=[+-]x
option introduced in 4e55ed32 ("add: add --chmod=+x / --chmod=-x
options") only works if the file on disk is modified.  When the test
was changed to work on one single file, instead of doing chmod=+x on
one file and chmod=-x on another file in b38ab197c ("t3700: merge two
tests into one"), this test started breaking when the mtime of the
file and the index file weren't the same (in other words, if the file
was not racily clean and thus was not smudged).

When the file is racily clean, git detects that the contents changed,
and everything is happy, but if it isn't, git incorectly thinks the
file wasn't modified (which it wasn't, but from gits view it should be
viewed as modified because the mode does not match up anymore).

One possible fix for the test is to smudge the entry as showed below,
though I'm not sure it's the right fix.  The other way I can think of
is to change the file in the index regardless of whether the file was
changed in some other way before issuing the git add command, as that
might fit the user expectation better.  Thoughts?

diff --git a/read-cache.c b/read-cache.c
index 491e52d..f2e7986 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -656,11 +656,13 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 	else
 		ce->ce_flags |= CE_INTENT_TO_ADD;
 
-	if (S_ISREG(st_mode) && force_mode)
+	if (S_ISREG(st_mode) && force_mode) {
 		ce->ce_mode = create_ce_mode(force_mode);
-	else if (trust_executable_bit && has_symlinks)
+		ce->ce_stat_data.sd_size = 0;
+	} else if (trust_executable_bit && has_symlinks) {
 		ce->ce_mode = create_ce_mode(st_mode);
-	else {
+	} else {
 		/* If there is an existing entry, pick the mode bits and type
 		 * from it, otherwise assume unexecutable regular file.
 		 */

								           



> Thanks,
> Jan Keromnes
> 
> ---
> 
> Steps to reproduce:
> 
>     curl https://www.kernel.org/pub/software/scm/git/git-2.9.3.tar.xz | tar xJ \
>      && cd git-2.9.3 \
>      && make prefix=/usr profile-install install-man -j18
> 
> Expected result:
> 
>     - runs all tests to get a profile (ignoring occasional failures)
>     - rebuilds Git with the profile
>     - installs Git
> 
> Actual result:
> 
>     - runs all tests to get a profile
>     - at least one test fails, interrupting the whole process
>     - Git is not installed
> 
> Failure log:
> 
>     # failed 1 among 40 test(s)
>     1..40
>     Makefile:43: recipe for target 't3700-add.sh' failed
>     make[3]: *** [t3700-add.sh] Error 1
>     make[3]: Leaving directory '/tmp/git/git-2.9.3/t'
>     Makefile:36: recipe for target 'test' failed
>     make[2]: Leaving directory '/tmp/git/git-2.9.3/t'
>     make[2]: *** [test] Error 2
>     Makefile:2221: recipe for target 'test' failed
>     make[1]: *** [test] Error 2
>     make[1]: Leaving directory '/tmp/git/git-2.9.3'
>     Makefile:1633: recipe for target 'profile' failed
>     make: *** [profile] Error 2
>     The command '/bin/sh -c mkdir /tmp/git  && cd /tmp/git  && curl
> https://www.kernel.org/pub/software/scm/git/git-2.9.3.tar.xz | tar xJ
> && cd git-2.9.3  && make prefix=/usr profile-install install-man -j18
> && rm -rf /tmp/git' returned a non-zero code: 2

-- 
Thomas
