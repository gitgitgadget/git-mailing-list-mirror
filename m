Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F7991F97F
	for <e@80x24.org>; Fri, 12 Oct 2018 23:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbeJMHMG (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Oct 2018 03:12:06 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:33735 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbeJMHMG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Oct 2018 03:12:06 -0400
Received: by mail-ed1-f42.google.com with SMTP id l14-v6so3907772edq.0
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 16:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jAbahl44oElWV9nOSOPEylIdPp8+Zn6hi27ISv/QyYA=;
        b=alfq90rPjR8EtZYZx8Hvc3dVCE4pY0P7B1PXxQ9XKkrPF/38qJTOUKs0VX8STAEGrG
         5yLxdVQqI2YYllV7BuBrXImXEo2u7w9ehI8a5gpEJgMAbzTB7+CWALMy7myHrBWRi1/l
         O334qkcghiinIAmsQ70VwRHJF9tvY4SU8g5nIp8i2a7dmy4WOKb8vMXwwt6jeYoOlPoZ
         CVwx6VZYQ66FFCTADXbE9u40ecv3GXNifKCSmhuNZP3bTXAyhOhke+W5emqdQa0FwzPo
         ub96QvppCcy7bRHJDwU8peZAyGzLhTXcWNWeQUTHKte38nve0JeZi4Mqk5eubxiTDJq6
         eu4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jAbahl44oElWV9nOSOPEylIdPp8+Zn6hi27ISv/QyYA=;
        b=GyCHGOFRfxbVVC0MT+XMdCpMnO+i8S2sef34aH6CHQGJTg0Y4yPmohN5nUs7wqySWp
         J57dX1jp0uJZcfV5CTVXGDckj113IHgocZtIVBMXU27CTRmR1AtP26XD2WdvhNfSSB6b
         KnmfdwC1flC7ioNfYPEngreCvWDCY3O4M8us86CWdFzy8MgWd7pmqCcZ5YBQsV0KGnDR
         vUPdNSn5KcAm5h3k+nTlL/I9V0S9esqWSH1OMwu0YHwmCd4qY5fhhfIQLcW88z04KGu4
         JRg5SJgHn+UL1EaAfkz+6SbstAbjJoM9CmpnpQzRmWpfB//tXY8cqF+Cjho4SOvs2CiL
         gv1g==
X-Gm-Message-State: ABuFfog2dmISMCFOPUEk3uLUTUMpIhlQy8iVZmsbaz1DBxlmLtzPNYQH
        n2sPGlRC8yl0rFGyku3MUJhOD8Kxvkq2Yu+RLOn2DQ==
X-Google-Smtp-Source: ACcGV63x/wWZUoBP+Wc53E9H/IDoYtrvMeTL3s8bFCXlnq152RAgbgVigS2Gtkpk5FlmQi/isDgegjriaWfi8o5aEks=
X-Received: by 2002:aa7:d709:: with SMTP id t9-v6mr11685292edq.231.1539387440158;
 Fri, 12 Oct 2018 16:37:20 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqh8hr9pxb.fsf@gitster-ct.c.googlers.com> <CAGZ79kZGEMWpr7aqeqXbC4bkmsCCiW+1pxbEV4T0vfsYG+_3iA@mail.gmail.com>
In-Reply-To: <CAGZ79kZGEMWpr7aqeqXbC4bkmsCCiW+1pxbEV4T0vfsYG+_3iA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 12 Oct 2018 16:37:09 -0700
Message-ID: <CAGZ79kavEzEJwYBtKSrEnraqZbYmYzQk9Nsaj+agPKzDZOjafA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Oct 2018, #02; Sat, 13)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 12, 2018 at 12:44 PM Stefan Beller <sbeller@google.com> wrote:

> > * sb/submodule-recursive-fetch-gets-the-tip (2018-10-11) 9 commits
> >  . builtin/fetch: check for submodule updates for non branch fetches
> >  . fetch: retry fetching submodules if needed objects were not fetched
> >  . submodule: fetch in submodules git directory instead of in worktree
> >  . repository: repo_submodule_init to take a submodule struct
> >  . submodule.c: do not copy around submodule list
> >  . submodule.c: move global changed_submodule_names into fetch submodule struct
> >  . submodule.c: sort changed_submodule_names before searching it
> >  . submodule.c: fix indentation
> >  . sha1-array: provide oid_array_filter
> >
> >  "git fetch --recurse-submodules" may not fetch the necessary commit
> >  that is bound to the superproject, which is getting corrected.
> >
> >  Ejected for now, as it has fallouts in places like t/helper/.
>
> This is the first time I hear about that, I'll look into that.

I looked into that, and merging with origin/next only
had one merge conflict in submodule.c, easy to resolve.
It builds and tests cleanly after that.

What fallouts did you observe?

> The tipmost commit there is also shoddy, I'll redo that.

I confused this series with sb/submodule-update-in-C
which got merged already, I may send a fixup commit there.

So it seems to me that this series is still good.

Thanks,
Stefan
