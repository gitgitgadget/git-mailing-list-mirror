Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1750A207E4
	for <e@80x24.org>; Tue,  2 May 2017 17:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751062AbdEBRne (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 13:43:34 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:36797 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbdEBRnd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 13:43:33 -0400
Received: by mail-pg0-f53.google.com with SMTP id t7so64738000pgt.3
        for <git@vger.kernel.org>; Tue, 02 May 2017 10:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=pQzWZnaJqTsBkSzcvgCqtZi+Aea4eK4MXQQ2FW1f2ew=;
        b=j+ksTC0MQyVMkU3ja191bYUvGQOF+4kbLccawLUz9i/p6EUad5HOFTyPyM5c4kZAl+
         mpkCcJdzTHMxV4Bi/wnXE8Fh5+x72RkBBJwNjzqfkMl3dGpGEgYqxUnX79I3p/CN3xtM
         xKOCd1sF4w0ecOQVXr313/qGXGIfQiuc0JCNcPIs+6i9glNya9wVyjmmqw8haV2fqImG
         gUs3mFeo0/N1UMTa/EUvJPCBdHoauwDH/Q8xkRc4wjOC6lkp+rSYks+pQ4at9PGkg2VC
         HZ5G9Ur4u7pUt5/Ea7f+2d3qa7+xFQpxEdHmcJnr296FB2Qsr/FGGvvp9QgP1GVoftGP
         Dozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pQzWZnaJqTsBkSzcvgCqtZi+Aea4eK4MXQQ2FW1f2ew=;
        b=l0BWTfL8RkZGUwwkR4I6enfGCCdqYeU7fHmpGfpgIATVqJSguROlcPcR38DNFQjI+7
         7DyHroB41uchp+X2jRT0Ejy8bNtcSuntL4u7wgm8m9beaxBrzO8GeSNymxNtD8mm8R72
         gbe6koMegcX/D7h8YeTAEPYXEy9UTsd7o4BLmAiL4L/AWFJgJouH1eGe5gt/DRfn9J/A
         OlV1hhwLVnWWC6kmr6fxAnDnWve6I3jyvJLT1J+xz/0ciVVlR7qsxEVDcNiDFmqgxzvj
         IoxwEBD6hIRVU/xkC5Pb9vE2tliNdWXUZFU/6XbRBAb9CnH8QoiZWBTqHIBVBBfRcRG5
         ioYg==
X-Gm-Message-State: AN3rC/4O1yBmXaCJY8kpToVjfJnKYXVoFFs1G8cx6IWDeZ6HmfzhgYlQ
        7ErlJrF2wB267spL
X-Received: by 10.98.72.144 with SMTP id q16mr222350pfi.152.1493747012108;
        Tue, 02 May 2017 10:43:32 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:61ee:b5d7:71fe:5285])
        by smtp.gmail.com with ESMTPSA id r2sm171431pfd.1.2017.05.02.10.43.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 02 May 2017 10:43:30 -0700 (PDT)
Date:   Tue, 2 May 2017 10:43:29 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: PCRE v2 compile error, was Re: What's cooking in git.git (May
 2017, #01; Mon, 1)
Message-ID: <20170502174329.GB181268@google.com>
References: <xmqqefw9gmvq.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1705021406510.3480@virtualbox>
 <CACBZZX5M1Pnvw01wP8id75Ja9NJ3nwVfydsX6g0Ys_QD72r6dQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX5M1Pnvw01wP8id75Ja9NJ3nwVfydsX6g0Ys_QD72r6dQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/02, Ævar Arnfjörð Bjarmason wrote:
> On Tue, May 2, 2017 at 2:09 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Hi Ævar,
> >
> > On Sun, 30 Apr 2017, Junio C Hamano wrote:
> >
> >> * ab/grep-pcre-v2 (2017-04-25) 20 commits
> >>  - SQUASH???
> >>  - Makefile & configure: make PCRE v2 the default PCRE implementation
> >>  - grep: remove support for concurrent use of both PCRE v1 & v2
> >>  - grep: add support for PCRE v2
> >>  - grep: add support for the PCRE v1 JIT API
> >>  - perf: add a performance comparison test of grep -E and -P
> >>  - grep: change the internal PCRE code & header names to be PCRE1
> >>  - grep: change the internal PCRE macro names to be PCRE1
> >>  - test-lib: rename the LIBPCRE prerequisite to PCRE
> >>  - grep: make grep.patternType=[pcre|pcre1] a synonym for "perl"
> >>  - grep & rev-list doc: stop promising libpcre for --perl-regexp
> >>  - log: add -P as a synonym for --perl-regexp
> >>  - log: add exhaustive tests for pattern style options & config
> >>  - grep: add a test for backreferences in PCRE patterns
> >>  - Makefile & configure: reword outdated comment about PCRE
> >>  - grep: remove redundant `regflags &= ~REG_EXTENDED` assignments
> >>  - grep: remove redundant regflags assignment under PCRE
> >>  - grep: submodule-related case statements should die if new fields are added
> >>  - grep: add tests for grep pattern types being passed to submodules
> >>  - grep: amend submodule recursion test in preparation for rx engine testing
> >>
> >>  PCRE2, which has an API different from and incompatible with PCRE,
> >>  can now be chosen to support "grep -P -e '<pattern>'" and friends.
> >
> > FWIW for quite a couple of recent builds, `pu` fails on Windows with a
> > variation of this error:
> >
> >             CC blob.o
> >         In file included from revision.h:5:0,
> >                          from bisect.c:4:
> >         grep.h:16:19: fatal error: pcre2.h: No such file or directory
> >          #include <pcre2.h>
> >                            ^
> >         compilation terminated.
> >
> > Maybe this can be fixed before hitting `next`?
> 
> This will be due to a combination of the build machine not having pcre
> v2 (but having v1) & my "Makefile & configure: make PCRE v2 the
> default PCRE implementation" patch, which makes v2 the default for
> USE_LIBPCRE=YesPlease.
> 
> Is it easy to install v2 on these build machines? Alternatively that
> patch could be ejected out of pu, or you could USE_LIBPCRE1=YesPlease
> to use v1, but as explained in that commit I think it makes sense to
> make v2 the default.

Shouldn't the Makefile check for the existence of PCREv2 before making
it the default?

-- 
Brandon Williams
