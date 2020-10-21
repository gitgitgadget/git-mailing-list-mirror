Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FORGED_MUA_MOZILLA,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C81C4363A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 18:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B39BD205ED
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 18:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504106AbgJUSuF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 14:50:05 -0400
Received: from static.214.254.202.116.clients.your-server.de ([116.202.254.214]:37068
        "EHLO ciao.gmane.io" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394632AbgJUSuE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 14:50:04 -0400
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <gcvg-git-3@m.gmane-mx.org>)
        id 1kVJBR-0005ij-QH
        for git@vger.kernel.org; Wed, 21 Oct 2020 20:50:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Nikos Chantziaras <realnc@gmail.com>
Subject: git svn log: Use of uninitialized value $sha1_short
Date:   Wed, 21 Oct 2020 21:42:12 +0300
Message-ID: <rmpve5$q2s$1@ciao.gmane.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
X-Mozilla-News-Host: news://news.gmane.org:119
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Running 'git svn log' in a repository that was cloned from an SVN repo 
results in this warning:

$ git svn log > /dev/null
Use of uninitialized value $sha1_short in regexp compilation at 
/usr/lib64/perl5/vendor_perl/5.30.3/Git/SVN/Log.pm line 301, <$fh> line 6.

This doesn't appear to have any ill effects, but the warning might 
indicate a problem somewhere.


[System Info]
git version:
git version 2.29.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.4.72-gentoo #1 SMP PREEMPT Sat Oct 17 18:27:41 EEST 2020 
x86_64
compiler info: gnuc: 10.2
libc info: glibc: 2.31
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]

