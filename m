Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF9BD1F404
	for <e@80x24.org>; Tue, 11 Sep 2018 20:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbeILBGy (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 21:06:54 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35628 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbeILBGy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 21:06:54 -0400
Received: by mail-pg1-f193.google.com with SMTP id 7-v6so12808998pgf.2
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 13:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vsM7TAqbtlX5WNk9qrmAQ/zbqpvbWycTg+fe/TAj4CY=;
        b=kgdAkzSf56l0ePk+GmYx/cbp3oSVS5mCBMF5fr8Atf5MK0hIKWf/1CpY1zc85LRBLJ
         gTpAZLXN//rJgueGD0q1zTI2YfSsyCuaIDf88PjOgE0bE2I6M0tbzK589h4TIVzE94hf
         pCypgXVzrZO3N9e6vqLM8OEe/5EPZ7hPg7hoqmlVFyN0IlnhF+TU2Ic+YjvKAbvyIlO+
         Jsc/rn6enMPNI82i7Z9ALLa80QChJwvaJUu9jh8KfbG+3w73akv2gOHHShHaHG3ASEbp
         vZDQgIiB2NzeA7SN8Xx1oDINPOKeFNrwXY/LrKqiGVWWNmjgtQFJRRE09cbveG03GrAr
         Wc8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vsM7TAqbtlX5WNk9qrmAQ/zbqpvbWycTg+fe/TAj4CY=;
        b=o/4SBM6BJfCMYiKAUmLP1DxmPmiI4P7sG/TBqYaETWMoxMvEUHeCyN0mIc3PwehSko
         rQUkbqEn1H09/5ZoRsdzssMUc/XPSDXATJu+SFXpoRvN6HEHA1gLM5RUzAwmIyf/D669
         ipYnVBBkXcYyAHDJSFLW0XRzhNEkpiLPjcbvAHylDWmnZbbg5QEd9j8kiD3giYt2c5qk
         ejvBX8JJ47/IfxzEzC5xg2yAVUBRPu3uNZAGl4D3cHHo+2E1MCfOjloo9MUGHp/vwjNv
         PnSRVlUI+9stOqPJhQaR4NxXKGpNY+qiMevGl22bjRLLIWHuNFn6fDQld1BEs8KJbN+e
         aazg==
X-Gm-Message-State: APzg51A8uWKRwPwyQH+Ga4+rmVSL4dRcUwvLYKLhoC2UVc8AuwyXccZ7
        c45xEeMfzCfKv5K5ejgx5JItjuaF
X-Google-Smtp-Source: ANB0Vdaejh0VPDR7QnrWLXUFPmeZO+zFYe25verdzlyVbUh/LzOWpJBO3up7OMJbqkPOYTjawogH9Q==
X-Received: by 2002:a63:6949:: with SMTP id e70-v6mr30094749pgc.119.1536696360657;
        Tue, 11 Sep 2018 13:06:00 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id n80-v6sm31504691pfb.95.2018.09.11.13.05.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 13:05:59 -0700 (PDT)
Date:   Tue, 11 Sep 2018 13:05:59 -0700 (PDT)
X-Google-Original-Date: Tue, 11 Sep 2018 20:05:55 GMT
Message-Id: <pull.35.v3.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.35.v2.git.gitgitgadget@gmail.com>
References: <pull.35.v2.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 0/2] Fixup for js/mingw-o-append
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The recent change mingw O_APPEND change breaks writing to named pipes on
Windows. The first commit adds a new test to confirm the breakage and the
second commit fixes the problem. These could be squashed together or we can
just keep the fix and omit the test if that would be better.

d641097589 (js/mingw-o-append) mingw: enable atomic O_APPEND

The new mingw_open_append() routine successfully opens the client side of
the named pipe, but the first write() to it fails with EBADF. Adding the
FILE_WRITE_DATA corrects the problem.

 Signed-off-by: Jeff Hostetler jeffhost@microsoft.com
[jeffhost@microsoft.com]

Cc: j6t@kdbg.orgCc: johannes.schindelin@gmx.deCc: gitster@pobox.comCc: 
peff@peff.net

Jeff Hostetler (2):
  t0051: test GIT_TRACE to a windows named pipe
  mingw: fix mingw_open_append to work with named pipes

 Makefile                           |  1 +
 compat/mingw.c                     | 36 +++++++++++++--
 t/helper/test-tool.c               |  3 ++
 t/helper/test-tool.h               |  3 ++
 t/helper/test-windows-named-pipe.c | 72 ++++++++++++++++++++++++++++++
 t/t0051-windows-named-pipe.sh      | 17 +++++++
 6 files changed, 129 insertions(+), 3 deletions(-)
 create mode 100644 t/helper/test-windows-named-pipe.c
 create mode 100755 t/t0051-windows-named-pipe.sh


base-commit: d641097589160eb795127d8dbcb14c877c217b60
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-35%2Fjeffhostetler%2Ffixup-mingw-o-append-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-35/jeffhostetler/fixup-mingw-o-append-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/35

Range-diff vs v2:

 1:  ecb30eb47c = 1:  ecb30eb47c t0051: test GIT_TRACE to a windows named pipe
 2:  f0361dd306 ! 2:  5592300ca5 mingw: fix mingw_open_append to work with named pipes
     @@ -46,22 +46,20 @@
       	return fd;
       }
       
     -+#define IS_SBS(ch) (((ch) == '/') || ((ch) == '\\'))
      +/*
      + * Does the pathname map to the local named pipe filesystem?
      + * That is, does it have a "//./pipe/" prefix?
      + */
     -+static int mingw_is_local_named_pipe_path(const char *filename)
     ++static int is_local_named_pipe_path(const char *filename)
      +{
     -+	return (IS_SBS(filename[0]) &&
     -+		IS_SBS(filename[1]) &&
     ++	return (is_dir_sep(filename[0]) &&
     ++		is_dir_sep(filename[1]) &&
      +		filename[2] == '.'  &&
     -+		IS_SBS(filename[3]) &&
     ++		is_dir_sep(filename[3]) &&
      +		!strncasecmp(filename+4, "pipe", 4) &&
     -+		IS_SBS(filename[8]) &&
     ++		is_dir_sep(filename[8]) &&
      +		filename[9]);
      +}
     -+#undef IS_SBS
      +
       int mingw_open (const char *filename, int oflags, ...)
       {
     @@ -71,7 +69,7 @@
       		filename = "nul";
       
      -	if (oflags & O_APPEND)
     -+	if ((oflags & O_APPEND) && !mingw_is_local_named_pipe_path(filename))
     ++	if ((oflags & O_APPEND) && !is_local_named_pipe_path(filename))
       		open_fn = mingw_open_append;
       	else
       		open_fn = _wopen;

-- 
gitgitgadget
