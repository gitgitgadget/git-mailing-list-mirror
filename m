Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D25C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 16:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbiGUQta (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 12:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiGUQt3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 12:49:29 -0400
Received: from shell1.rawbw.com (shell1.rawbw.com [198.144.192.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D960789E9E
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 09:49:28 -0700 (PDT)
Received: from [192.168.5.3] ([76.132.248.201])
        (authenticated bits=0)
        by shell1.rawbw.com (8.15.1/8.15.1) with ESMTPSA id 26LGnNkg041662
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 21 Jul 2022 09:49:24 -0700 (PDT)
        (envelope-from yuri@rawbw.com)
X-Authentication-Warning: shell1.rawbw.com: Host [76.132.248.201] claimed to be [192.168.5.3]
Message-ID: <98dc2e8e-58b6-80ad-65da-2bd1cc5dffc2@tsoft.com>
Date:   Thu, 21 Jul 2022 09:49:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: What is the URL of git's bug tracker?
Content-Language: en-US
To:     Konstantin Khomoutov <kostix@bswap.ru>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <a5f48218-94ad-195e-97bc-b29c4a588903@tsoft.com>
 <20220721101948.2i3nyroxrexg4voi@carbon>
From:   Yuri <yuri@rawbw.com>
In-Reply-To: <20220721101948.2i3nyroxrexg4voi@carbon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/21/22 03:19, Konstantin Khomoutov wrote:
> There is none - please read https://git-scm.com/community


On 04-09-2021 I reported to this ML the bug that git-2.31.0 printed 
stray messages during 'git stash push' command.


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


Now in git-2.37.1 this bug is still there,


Is it forgotten about? Is the fix planned? Is it fixed but not yet released?

It's impossible to say without a bug tracker.



Yuri


