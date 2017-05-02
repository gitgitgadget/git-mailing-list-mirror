Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55D661F790
	for <e@80x24.org>; Tue,  2 May 2017 12:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751081AbdEBM1b (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 08:27:31 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:35386 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750886AbdEBM13 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 08:27:29 -0400
Received: by mail-it0-f53.google.com with SMTP id c15so36123856ith.0
        for <git@vger.kernel.org>; Tue, 02 May 2017 05:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MpD72X/pV9Ymszh0WvT+Ga9/0BZGvF5xH6A+ZQfCuuA=;
        b=oHNFymoKFCLtoieIabsByQCfn9Tmga/PtLjYuFbuyBsgG1U5ZxkhryE3csG2hPhyox
         mxPJ0TxNU2R4w08IjgPVYz3C/5KfNw/S59WDlMqEfNwlc2SyYvLk+sCOEaHS0gBc26uV
         adA/mYd3q6lR25UX7NAFKdAyBx1XZRgf5SbAv/7rYzR1fXvnpPojAnhpnzkiI1FQZKWb
         4dsPdHdD2ssRNCd1zcr0Hvdmua+zemeUsz92cw9HG4tmXQKFnjDVaqirajY1lWDCuQDs
         O96nda733tijMXqK/4Gaj5sYJpEXmZOCYzqnAnv6+3LyqBvw47JQaT8mI2F4Uo5Ckh/5
         TUDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MpD72X/pV9Ymszh0WvT+Ga9/0BZGvF5xH6A+ZQfCuuA=;
        b=dxdeC8E5Tc9hfQfzcijvGQgX/md/fh8q/2XJhIZkIzhxel7yu6QUXQBXVznSAkP9PI
         X5Hyk4g1qhOlMDsUucRWq+vT5MOV/mSk247vAzig80ywNH40HEmaAxOOzMzrkkfE4d+T
         7DLRVPdBaC0gdSSyAWKzZ2352oiz1uyq/TcFIFLMEpY4EUHf/HpHuBXo6pM5pE3W40b2
         nFTNo9W1lV2OZ1yyBJNyrmNDTmHSpb0nzzbSmHM5/YXYWU9HQ9oNe4L9liys3cFtq//G
         YdsAoJl4qu9RMvUAegUvSzDOPIv7wJq4NBD4lwKIA3fBLoIq4CJvjTz7htfZvOB9aD2R
         hYtw==
X-Gm-Message-State: AN3rC/4BN1eIvlsJFh8U1sHtt12/DHfXQZBDRg+FfPMr7mU4kmt6N4O0
        doQBRto/98vwdK04JmvnpT4rm9bQYg==
X-Received: by 10.36.83.144 with SMTP id n138mr2756512itb.71.1493728049067;
 Tue, 02 May 2017 05:27:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Tue, 2 May 2017 05:27:08 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1705021406510.3480@virtualbox>
References: <xmqqefw9gmvq.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1705021406510.3480@virtualbox>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 2 May 2017 14:27:08 +0200
Message-ID: <CACBZZX5M1Pnvw01wP8id75Ja9NJ3nwVfydsX6g0Ys_QD72r6dQ@mail.gmail.com>
Subject: Re: PCRE v2 compile error, was Re: What's cooking in git.git (May
 2017, #01; Mon, 1)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 2, 2017 at 2:09 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi =C3=86var,
>
> On Sun, 30 Apr 2017, Junio C Hamano wrote:
>
>> * ab/grep-pcre-v2 (2017-04-25) 20 commits
>>  - SQUASH???
>>  - Makefile & configure: make PCRE v2 the default PCRE implementation
>>  - grep: remove support for concurrent use of both PCRE v1 & v2
>>  - grep: add support for PCRE v2
>>  - grep: add support for the PCRE v1 JIT API
>>  - perf: add a performance comparison test of grep -E and -P
>>  - grep: change the internal PCRE code & header names to be PCRE1
>>  - grep: change the internal PCRE macro names to be PCRE1
>>  - test-lib: rename the LIBPCRE prerequisite to PCRE
>>  - grep: make grep.patternType=3D[pcre|pcre1] a synonym for "perl"
>>  - grep & rev-list doc: stop promising libpcre for --perl-regexp
>>  - log: add -P as a synonym for --perl-regexp
>>  - log: add exhaustive tests for pattern style options & config
>>  - grep: add a test for backreferences in PCRE patterns
>>  - Makefile & configure: reword outdated comment about PCRE
>>  - grep: remove redundant `regflags &=3D ~REG_EXTENDED` assignments
>>  - grep: remove redundant regflags assignment under PCRE
>>  - grep: submodule-related case statements should die if new fields are =
added
>>  - grep: add tests for grep pattern types being passed to submodules
>>  - grep: amend submodule recursion test in preparation for rx engine tes=
ting
>>
>>  PCRE2, which has an API different from and incompatible with PCRE,
>>  can now be chosen to support "grep -P -e '<pattern>'" and friends.
>
> FWIW for quite a couple of recent builds, `pu` fails on Windows with a
> variation of this error:
>
>             CC blob.o
>         In file included from revision.h:5:0,
>                          from bisect.c:4:
>         grep.h:16:19: fatal error: pcre2.h: No such file or directory
>          #include <pcre2.h>
>                            ^
>         compilation terminated.
>
> Maybe this can be fixed before hitting `next`?

This will be due to a combination of the build machine not having pcre
v2 (but having v1) & my "Makefile & configure: make PCRE v2 the
default PCRE implementation" patch, which makes v2 the default for
USE_LIBPCRE=3DYesPlease.

Is it easy to install v2 on these build machines? Alternatively that
patch could be ejected out of pu, or you could USE_LIBPCRE1=3DYesPlease
to use v1, but as explained in that commit I think it makes sense to
make v2 the default.
