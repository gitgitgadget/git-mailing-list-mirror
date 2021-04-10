Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1B7C433ED
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 05:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7A0E6115B
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 05:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhDJFWh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Apr 2021 01:22:37 -0400
Received: from shell1.rawbw.com ([198.144.192.42]:37275 "EHLO shell1.rawbw.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229472AbhDJFWg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Apr 2021 01:22:36 -0400
X-Greylist: delayed 1430 seconds by postgrey-1.27 at vger.kernel.org; Sat, 10 Apr 2021 01:22:36 EDT
Received: from yv.noip.me (c-73-189-35-76.hsd1.ca.comcast.net [73.189.35.76])
        (authenticated bits=0)
        by shell1.rawbw.com (8.15.1/8.15.1) with ESMTPSA id 13A4wW9B090547
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
        for <git@vger.kernel.org>; Fri, 9 Apr 2021 21:58:32 -0700 (PDT)
        (envelope-from yuri@rawbw.com)
X-Authentication-Warning: shell1.rawbw.com: Host c-73-189-35-76.hsd1.ca.comcast.net [73.189.35.76] claimed to be yv.noip.me
To:     Git Mailing List <git@vger.kernel.org>
From:   Yuri <yuri@rawbw.com>
Subject: Warning during 'git stash push'
Message-ID: <e493ca9b-c686-68ea-cd8d-c7b13766d65e@rawbw.com>
Date:   Fri, 9 Apr 2021 21:58:31 -0700
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your issue)
Tried to stash a particular subdirectory

What did you expect to happen? (Expected behavior)
Directory should be stashed, obviously,

What happened instead? (Actual behavior)
  git stash push -- x11-toolkits/fltk
Saved working directory and index state WIP on main: 4c2cc95952a6 
graphics/mesa-devel: update to 21.0.b.4390
<stdin>:83: space before tab in indent.
      LIBS="$LIBS -lX11 $X_EXTRA_LIBS"
<stdin>:84: space before tab in indent.
      CFLAGS="$CFLAGS $X_CFLAGS"
<stdin>:85: space before tab in indent.
      CXXFLAGS="$CXXFLAGS $X_CFLAGS"
<stdin>:88: space before tab in indent.
      DSOFLAGS="$X_LIBS $DSOFLAGS"
<stdin>:89: space before tab in indent.
      $as_echo "#define USE_X11 1" >>confdefs.h
warning: squelched 40 whitespace errors
warning: 45 lines add whitespace errors.


What's different between what you expected and what actually happened?
unexpected warnings

Anything else you want to add:
I did this from w/in of the FreeBSD ports directory, trying to stash 
only my work in one of subdirectories: x11-toolkits/fltk

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.31.0
cpu: amd64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: FreeBSD 12.2-STABLE FreeBSD 12.2-STABLE #0 r369528M: Mon Mar 29 
05:18:24 PDT 2021 
unknown@nohost.com:/disk-samsung/sys/usr/src/amd64.amd64/sys/GENERIC amd64
compiler info: clang: 10.0.1 (git@github.com:llvm/llvm-project.git 
llvmorg-10.0.1-0-gef32c611aa2)
libc info: no libc information available
$SHELL (typically, interactive shell): /usr/local/bin/bash


[Enabled Hooks]

