Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C2741F404
	for <e@80x24.org>; Fri,  7 Sep 2018 18:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbeIGXB7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 19:01:59 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36748 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbeIGXB7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 19:01:59 -0400
Received: by mail-pf1-f194.google.com with SMTP id b11-v6so7401253pfo.3
        for <git@vger.kernel.org>; Fri, 07 Sep 2018 11:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=GViT9ljz7gubSBi1I8Q9/RqM9bEUDwRuISWXi77R3oQ=;
        b=a3ocBC0Zn7tole1zEzfGruLHdxKsTRYmvLHwCqQ/2zYEnG9C/a4+MdPEO/TRbuh/l5
         ZIajMTnaekPh05GdnMBIQT1igVrW2IVnvdPs622Ew8E77bVaOvnZ0KP5kh9apACnnIhY
         Vi1k5pMykMTOBV84uiUMpI3MCbeHQ7vq994s//a7dhdj7FfkKslnBzBgRnerViANtE0q
         31Th9qXGcTmY8lg3mXybD3m+0mJqTIGMhPImTjXdUbvVGsLghVXGjTLlppIbw1A4a2GJ
         4l5jTUHFiIkKaIqANJNkTt39h+0JF4p+Bu8/jmo4fDOcgj6xoPlJ2B+PpKiGJlrWzlSH
         E+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GViT9ljz7gubSBi1I8Q9/RqM9bEUDwRuISWXi77R3oQ=;
        b=IeCml2XdOhqT/rur+8TQR/IydzvagrbxBiDmPzKcgR9rdM1kk1zfLJdmvP+fDy839b
         T2Pt3EsKD0sDxS0Icdh2M1NXq8Mdl1T3rLp8ewcgcezs1DuPn26sTv/XtgaCCM/0+b+P
         SxdG5tQjlXOkZozJHpO+3kSu+ixgI48tTDT4zigopG/ZVFOGMlQfsVRr5xrupvRYhd/P
         lTVtBDauw34d8rfGHTowede13rt/H8IJk/Yz68o8qZ17Eqh4pm7oNEJRrAz28apLHxSS
         Uwg5VrHExDwcH0YX/Es/yxmRcsi2UXtSDva/aBuQwqKJA2/rD2rwOvStWpSFJQCum6fR
         vkKA==
X-Gm-Message-State: APzg51BSQnyjIAhJeRZ+L8nrf8Z/eTvNkACLNgs20PH3lcD80ajINptV
        grUpOUtZLv3Fe3rJLkJf1xwZnsIp
X-Google-Smtp-Source: ANB0VdZjKnx02xUtrCmG/rrFW3tJ+vEDlz7xx6ih2OnuEFdmpOyylyU4Hh0K340G3MhncO+7r8HYtw==
X-Received: by 2002:a63:4106:: with SMTP id o6-v6mr9635939pga.80.1536344390400;
        Fri, 07 Sep 2018 11:19:50 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id g20-v6sm11757883pfo.94.2018.09.07.11.19.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 11:19:49 -0700 (PDT)
Date:   Fri, 07 Sep 2018 11:19:49 -0700 (PDT)
X-Google-Original-Date: Fri, 07 Sep 2018 18:19:44 GMT
Message-Id: <pull.35.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/2] Fixup for js/mingw-o-append
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
 compat/mingw.c                     |  2 +-
 t/helper/test-tool.c               |  3 ++
 t/helper/test-tool.h               |  3 ++
 t/helper/test-windows-named-pipe.c | 72 ++++++++++++++++++++++++++++++
 t/t0051-windows-named-pipe.sh      | 17 +++++++
 6 files changed, 97 insertions(+), 1 deletion(-)
 create mode 100644 t/helper/test-windows-named-pipe.c
 create mode 100755 t/t0051-windows-named-pipe.sh


base-commit: d641097589160eb795127d8dbcb14c877c217b60
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-35%2Fjeffhostetler%2Ffixup-mingw-o-append-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-35/jeffhostetler/fixup-mingw-o-append-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/35
-- 
gitgitgadget
