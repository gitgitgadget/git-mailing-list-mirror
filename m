Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F4A21F453
	for <e@80x24.org>; Fri, 22 Feb 2019 09:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfBVJdR (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 04:33:17 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:33893 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfBVJdR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 04:33:17 -0500
Received: by mail-it1-f195.google.com with SMTP id d125so11065130ith.1
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 01:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SbGc76FSOIJ66zmjSyzEL6s1Ivi1nSJ2EMB481HPzFo=;
        b=UAaQT0vR/Ut8KSvlTScU+qWI1Wc4viOA+KPBZOFPSTk6Cg3DEsU/zlIzhEoQUYOEox
         NSCV3oc20KBho+0ygvW+QjvZWvcgFlvzgTaAmfg6yMuVU4WQcZDWJvDftCCg12sa4r9n
         GfCauUSlASCFoQ4j1fjrbrzU8g24Z1EDV5GCpeKHQo+jPQAY6n2Af4C5ewWyuDy41l/z
         sjEkzZtRdk+/ZWSeZPKD/hH0K3le//5aFLGSw1feeyqunkSFkhtLATGhjgU3SeuAbsMf
         B6AhJMDe8jof3enD7WZc3Zmw7A/lhA/zy0AACiC9V9J3HmPnkdC4muKo6dwdEoC6Qqq7
         2U6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SbGc76FSOIJ66zmjSyzEL6s1Ivi1nSJ2EMB481HPzFo=;
        b=Xxngo/4uHeA22VN1+1XM4REyUsfZJDM2ZBnrMCQYeZr6tcOYfI5NqYSve06pJ2v3LZ
         mQGctnAjug8DWr5b3HnhgxngOs/fnyhI/IVwOCHcgrZRz92aMbugrHxqhwkk+LGR7+mU
         bvqTkON26h6OBa6aUgkO0cBLENpe9RaBhGl51/MVAwbtjdORVY4f/Komx7pmhniqIxBy
         KIWBgllcM9N2qStq2poinZlMI0QDX+JSKcysrDQwIuDDZBSGqtS357Cezpi6eSp08sb8
         2qcuLmjQjZhrmzzUEgZz5Cn499GL06EWz0M0cWkaUB299vj/tKWFbKTbLxvdqn5ALYYw
         Y9uA==
X-Gm-Message-State: AHQUAubAQBBOP2cTUspGtJL0iefli99zTKCb5Fl3Z7+zGZfv457OgB+v
        nqo69FpCTNehJdfePCQxVSNrolq4NBtmMsfjsvm7Jw==
X-Google-Smtp-Source: AHgI3IaRRGsDtSWlCO4RGmn3+4dC7ruknX1B0sWM+/vVp70I+tTlV8vSoltISzyDQSfK6ZOzj7BEVA6drJ4CI1u1NEc=
X-Received: by 2002:a24:7542:: with SMTP id y63mr270730itc.70.1550827996250;
 Fri, 22 Feb 2019 01:33:16 -0800 (PST)
MIME-Version: 1.0
References: <cover.1550508544.git.msuchanek@suse.de> <6f9c8775817117c2b36539eb048e2462a650ab8f.1550508544.git.msuchanek@suse.de>
 <CACsJy8AWezO7TFq8ne1a2pSAJZoc6oYqnNNxmVW_FkA9--ntbQ@mail.gmail.com>
 <20190221145056.53b98b2a@kitsune.suse.cz> <adc0f7f9-aa41-780e-6fce-94d493fac318@talktalk.net>
In-Reply-To: <adc0f7f9-aa41-780e-6fce-94d493fac318@talktalk.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 22 Feb 2019 16:32:50 +0700
Message-ID: <CACsJy8B2HRyBKQd+S7hjfU+xGFH+_y0YKcw8397znc2eGUBogQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] setup: don't fail if commondir reference is deleted.
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Marketa Calabkova <mcalabkova@suse.cz>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 22, 2019 at 12:07 AM Phillip Wood <phillip.wood@talktalk.net> w=
rote:
>
> Hi Michal/Duy
>
> On 21/02/2019 13:50, Michal Such=C3=A1nek wrote:
> > On Thu, 21 Feb 2019 17:50:38 +0700
> > Duy Nguyen <pclouds@gmail.com> wrote:
> >
> >> On Tue, Feb 19, 2019 at 12:05 AM Michal Suchanek <msuchanek@suse.de> w=
rote:
> >>>
> >>> When adding wotktrees git can die in get_common_dir_noenv while
> >>> examining existing worktrees because the commondir file does not exis=
t.
> >>> Rather than testing if the file exists before reading it handle ENOEN=
T.
> >>
> >> I don't think we could go around fixing every access to incomplete
> >> worktrees like this. If this is because of racy 'worktree add', then
> >> perhaps a better solution is make it absolutely clear it's not ready
> >> for anybody to access.
> >>
> >> For example, we can suffix the worktree directory name with ".lock"
> >> and make sure get_worktrees() ignores entries ending with ".lock".
> >> That should protect other commands while 'worktree add' is still
> >> running. Only when the worktree is complete that 'worktree add' should
> >> rename the directory to lose ".lock" and run external commands like
> >> git-checkout to populate the worktree.
> >
> > The problem is we don't forbid worktree names ending with ".lock".
> > Which means that if we start to forbid them now existing worktrees
> > might become inaccessible.
>
> I think it is also racy as the renaming breaks the use of mkdir erroring
> out if the directory already exists.

You mean the part where we see "fred" exists and decide to try the
name "fred1" instead (i.e. patch 1/2)?

I don't think it's the problem if that's the case. We mkdir
"fred.lock" _then_ check if "fred" exists. If it does, remove
fred.lock and move on to fred1.lock. Then we rename fred1.lock to
fred1 and error out if rename fails.
--=20
Duy
