Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB92D20A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 19:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbeLKTYB (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 14:24:01 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:35053 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbeLKTYB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 14:24:01 -0500
Received: by mail-io1-f66.google.com with SMTP id i1so10772532ioo.2
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 11:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Du1rggg78FLHpHrHkG0PgkYSF8yhVVSF1p063BVt4fc=;
        b=mjLSWp51TX/1E24PfNsud7MlAT30nK6KOYl7eChB4NBpXL2+qqyhIG7gl/L+XYCskE
         IXisr9WbmNmbDOPhlnyEVyyYqCDo/Yu3VsqKgypf97ykvp7dI/+KYIvshCcEjzstvIPV
         97PxF1ispxlr+QmrCsQro0+Es6GCPNies09dzZhzKwQrymaPVEUH/Ig//hxZOCMZiaGm
         lX2OvbiFnqCvP4i96Zn/tDq19X/FiBLG3W9rprVAljVgjS69iYWEbPdtxtd76LSuoOUN
         q9OYCXRtGlJMTjQqS0m721+Tp96BBQPe2yma6beyNNkoIfbi8Fr83h05W1koA+fFsa/j
         Y9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Du1rggg78FLHpHrHkG0PgkYSF8yhVVSF1p063BVt4fc=;
        b=lc9VjBETVDDws+ys70appsTAJSbnmsSLh3rsb9fDI4N+Rjjm0TGiri1dE1C2Ww5Vo4
         b9PKxmKBjYCAQxAXvJpTB2+4iirgruaAku1frGCzzUXOiIfwPsTnG15qbZElJqOO6s0s
         NTBm8Jzyr4/zSQQ4l5Evv02sFz/Kp08QtdHWPS7Ut5mKUyzDFiiWZ0Qv9vORk14L+tKL
         thPVWSgPcOx4mTNsio1DSJmOjP3g3ouuXkb5M8OQuo0MW7UGNCrNE7ktROWxAV0iFlay
         ZXIC7eGdQKO2eGAzYgb+dX/1bcdQAuekLnafoYi4sKCqLqDmJZbrgL0OxgThikfARTCq
         ofzA==
X-Gm-Message-State: AA+aEWZ0+a3b4K/qNlGnS/TDXNzj45eUj+4UU7vOduapOWkZvItmpmgE
        OwPi1+h9z2WkefTI1ZVhZB4+3TxjJ10G7/dqqlE=
X-Google-Smtp-Source: AFSGD/UnlY94VvVs/I9stYSxI+4ysql1zZujn2DuWORlkXm1niJzy6VGy11+2e0J72h9qxJgamT8fSg2soNaaTgM56I=
X-Received: by 2002:a5d:944d:: with SMTP id x13mr12174625ior.282.1544556240216;
 Tue, 11 Dec 2018 11:24:00 -0800 (PST)
MIME-Version: 1.0
References: <20181209200449.16342-1-t.gummerer@gmail.com> <20181209200449.16342-7-t.gummerer@gmail.com>
 <CACsJy8CfgJ4NAnbMjBFGhRWscZxJCgxtx0QwSMw7MTjeMT4gDw@mail.gmail.com>
 <xmqqva40lps2.fsf@gitster-ct.c.googlers.com> <CABPp-BGQwtok1T3WmY3ndBG6RjbESSOgmbZxkWiN-avqfUjDVg@mail.gmail.com>
In-Reply-To: <CABPp-BGQwtok1T3WmY3ndBG6RjbESSOgmbZxkWiN-avqfUjDVg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 11 Dec 2018 20:23:33 +0100
Message-ID: <CACsJy8AxUxYCO7bzb98EVvO5DU62ukZQNrF-sEktrdR9m6tfvg@mail.gmail.com>
Subject: Re: [PATCH 6/8] checkout: add --cached option
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 11, 2018 at 7:12 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Mon, Dec 10, 2018 at 7:13 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Duy Nguyen <pclouds@gmail.com> writes:
> >
> > > Elijah wanted another mode (and I agree) that modifies worktree but
> > > leaves the index alone. This is most useful (or least confusing) when
> > > used with <tree-ish> and would be default in restore-files. I'm not
> > > saying you have to implement it, but how do the new command line
> > > options are designed to make sense?
> >
> > I'd model it after "git apply", i.e.
> >
> >         git restore-files [--tree=<treeish>] <pathspec>
> >
> > would work only on the working tree files,
> >
> >         git restore-files --tree=<treeish> --cached <pathspec>
> >
> > would match the entries in the index that match pathspec to the
> > given treeish without touching the working tree, and
> >
> >         git restore-files --tree=<treeish> --index <pathspec>
> >
> > would be both.
> >
> > I have never been happy with the phraso, the (arbitrary) distinction
> > between --cached/--index we use, so in the very longer term (like,
> > introducing synonym at 3.0 boundary and deprecating older ones at
> > 4.0 boundary), it may not be a bad idea to rename "--index" to
> > "--index-and-working-tree" and "--cached" to "--index-only".
> >
> > But until that happens, it would be better to use these two
> > consistently.
>
> I agree that consistency is important, but trying to distinguish
> between "--cached" and "--index" is _extremely_ painful.  I still
> can't keep the distinction straight and have to look it up every time
> I want to use either.  I don't know how to possibly teach users the
> meaning.  Could we introduce synonyms earlier at least, and make the
> synonyms more prominent than the "--cached" and "--index" terms in the
> documentation?

For git-checkout I think --index and --cached fit. For restore-files,
if you come up with better names, I'll gladly use that. Otherwise I'll
just use these.
-- 
Duy
