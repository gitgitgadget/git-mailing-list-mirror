Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8859C20356
	for <e@80x24.org>; Tue, 18 Jul 2017 18:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751513AbdGRSBC (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jul 2017 14:01:02 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:34191 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751408AbdGRSBB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2017 14:01:01 -0400
Received: by mail-pf0-f175.google.com with SMTP id q85so14959978pfq.1
        for <git@vger.kernel.org>; Tue, 18 Jul 2017 11:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OqK+Q1Nk1mOsx5/H6ZkCIXxEb7H79JD+yCMaaAnuYZk=;
        b=KkFQBWIIUNhp/z3LoVA04a8Pjy2brY1sYij30I605CG8/r08caaS4tOy//q3aEHkoy
         oLEkViUaH+OYEiM5O0idzM7D9LCykYY3tPUBWh294LwUG6CN40ab30I4ntOkN9839ybh
         4BW4DziyY2SJYTONfge38mYBWbNCJolA0L3hYpO/4Xdxfv2sQi0SHk6HEqw9JZq47T4Y
         E0oR/3paTu6ihRwsWPmzinDwKCflGdK9VzMtTsb13BTWbjHi55ki+k/rZHDjrWO3w2c1
         r34KnwNPOA/bfuiWmBhPN1NrQuMhoV38+m31o5cQy8SmU4wYxGkVSXihrLzclunBauba
         CMyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OqK+Q1Nk1mOsx5/H6ZkCIXxEb7H79JD+yCMaaAnuYZk=;
        b=iMknEm1VBJAiWAnGPsnxvjlM1nPsCKoKOqJOGvDqwrJYjKMnml7JwkW7YQziwC5PcN
         OaFtnUywf+2hggRd+60qauy+Z1X155NHJ5wBZB9DIDKFVSkkg3mEEO+4Ta2+nCzhBysH
         zCXitkC628IKj/a8O5JNHpCUB9xRrsleZegPWFR0t2QLsz3kHYqI5o/yRsXdxp+xxO/h
         J1jbV87T9VsyK07ED+1hWtRLoJ3cs1wLAuSEahkmSQhbQT3KDeA3Uto6GCq43ANG+l3W
         8gQ2XHLRv1vLns+z66C01kHjj6XYA6i4wbSUGkHWLJB5wBICMrfvO3NlbM3ySxxNJyEO
         dGRQ==
X-Gm-Message-State: AIVw111oNVaS4pxiylRKFJXO7CRDHy+nwpuP20vP3ozaOI7LTKi246BS
        JfeZhKus+mE/SETR
X-Received: by 10.98.11.135 with SMTP id 7mr2933067pfl.45.1500400860382;
        Tue, 18 Jul 2017 11:01:00 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:dcfd:2921:5eb0:198b])
        by smtp.gmail.com with ESMTPSA id x81sm623306pfi.20.2017.07.18.11.00.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 18 Jul 2017 11:00:58 -0700 (PDT)
Date:   Tue, 18 Jul 2017 11:00:57 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Subject: Re: Fwd: New Defects reported by Coverity Scan for git
Message-ID: <20170718180057.GA22656@google.com>
References: <596ddaa620821_77f83e7330107c4@ss1435.mail>
 <CAGZ79kaPFDMn2K0f529-Crzv+vhU3XUMsSM6w3QV4RXKBv5s_g@mail.gmail.com>
 <xmqqa841fylf.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kYohev8BdBEL9qnfmZ6quMwZPDRqZ44qCKV_wMwR=Etiw@mail.gmail.com>
 <xmqqy3rleijv.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy3rleijv.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/18, Junio C Hamano wrote:
> Stefan Beller <sbeller@google.com> writes:
> 
> >> I'd be more worried about segfault we seem to be getting only on
> >> Windows from this:
> >>
> >>     git -C parent grep -e "(1|2)d(3|4)" --recurse-submodules HEAD^ > actual
> >>
> >> in https://travis-ci.org/git/git/jobs/254654195 by the way.
> >
> > Thanks for bringing that to my attention, (I do not follow the travis builds
> > as closely, as there is no yelling email in my inbox).
> >
> > Windows builds on travis seem to be flaky.
> > (sometimes they do not start), but there are also
> > successful builds, including the -rc0, which may indicate
> > bw/grep-recurse-submodules may be faulty on Windows.
> 
> I can get valgrind complaints locally from
> 
>     $ cd t && sh t7814-grep*.sh --valgrind -i -v
> 
> so this may not be Windows only.  Can repo_worktree_path() return a NULL
> in repo_read_gitmodules() to cause git_config_from_file() barf on a NULL
> gitmodule_path?

Yep that's most likely the cause.  The issue is if a repository doesn't
have a worktree then what should a worktree path look like?
repo_read_gitmodules() should check if there is a worktree before trying
to load the gitmodules file.  I actually noticed this and have it fixed locally in
another series I'm working on right now.  Looks like I may have to get
that change in first though.  Thanks for finding this.

> 
> ==20383== Syscall param open(filename) points to unaddressable byte(s)
> ==20383==    at 0x5153140: __open_nocancel (/build/eglibc-SvCtMH/eglibc-2.19/io/../sysdeps/unix/syscall-template.S:81)
> ==20383==    by 0x50DDED7: _IO_file_fopen@@GLIBC_2.2.5 (/build/eglibc-SvCtMH/eglibc-2.19/libio/fileops.c:228)
> ==20383==    by 0x50D23D3: __fopen_internal (/build/eglibc-SvCtMH/eglibc-2.19/libio/iofopen.c:90)
> ==20383==    by 0x569107: git_fopen (/home/gitster/git.git/compat/fopen.c:22)
> ==20383==    by 0x55B1ED: fopen_or_warn (/home/gitster/git.git/wrapper.c:439)
> ==20383==    by 0x4A2A32: git_config_from_file (/home/gitster/git.git/config.c:1442)
> ==20383==    by 0x540317: repo_read_gitmodules (/home/gitster/git.git/submodule.c:269)
> ==20383==    by 0x434389: grep_submodule (/home/gitster/git.git/builtin/grep.c:422)
> ==20383==    by 0x4348C8: grep_tree (/home/gitster/git.git/builtin/grep.c:580)
> ==20383==    by 0x434867: grep_tree (/home/gitster/git.git/builtin/grep.c:576)
> ==20383==    by 0x436034: cmd_grep (/home/gitster/git.git/builtin/grep.c:622)
> ==20383==    by 0x4063DC: handle_builtin (/home/gitster/git.git/git.c:330)
> ==20383==  Address 0x0 is not stack'd, malloc'd or (recently) free'd
> 
> 

-- 
Brandon Williams
