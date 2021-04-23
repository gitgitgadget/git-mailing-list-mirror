Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E60C433ED
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 12:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C04BE6145A
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 12:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbhDWMJJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 08:09:09 -0400
Received: from mout.gmx.net ([212.227.17.21]:58427 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229479AbhDWMJI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 08:09:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1619179710;
        bh=ZsW5e70oJQjvEk4URK9Yisov+yrPYLgxoewSDXyuM44=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=NOYtyxFv5JWJ32WqMbrweQH2Zyi2FixAyK1p3+CkxtySJQdI/cOshpIOtQzILZDz7
         TGqptempIWUUlhbesQm/vt3lSWwOkjeN6jD47noJO+75SZoh1+3750tWBhezev69mD
         OTye+J4ecMXxeL/V8fQSU720Co2/zUBP/nEAtJD8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.111.181] ([89.1.213.207]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MdvmY-1l18Ho2vNW-00b6sd; Fri, 23
 Apr 2021 14:08:30 +0200
Date:   Fri, 23 Apr 2021 14:08:29 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Emily Shaffer <emilyshaffer@google.com>
cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH v2 4/4] config: add 'config.superproject' file
In-Reply-To: <20210423001539.4059524-5-emilyshaffer@google.com>
Message-ID: <nycvar.QRO.7.76.6.2104231405210.54@tvgsbejvaqbjf.bet>
References: <20210423001539.4059524-1-emilyshaffer@google.com> <20210423001539.4059524-5-emilyshaffer@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:47GO/dsjyO5pYt7YGtjBT+hle35x1OJQfbOfJvkd1EXEcBtSPKB
 0fCAzXQNEnJEt7D422kNa25VDvZ3UGarMWS3QP+GDIPMCNMY0brMgr01ynyvvulHnhwiMrh
 wmgasTQqop6i5Gzm0FVp+Wzgt3fbOIoFdxp84zM4mvB35mnATyHIdAb+8dv8z4hzaiM9k2j
 pr5T9RurRSSVAVqeZr27g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:O0yW1S241jg=:ajM4Kwx0iISOwPCF7SCyXh
 JtNOkPW1KOGHJQ4BnLBP4dSuz9QiOt3ko8ZFE9Od0fMSKHeT3fcSYVVlBvJ0g42HQNLYeP9yo
 L4HYQX6HnXga+o3CjmDt2jofTCT12iNFReQ6veQ3i81yUCheXbb5TQiMdXEMepQgo2jiGoxYp
 oSdtH48ilx8l6zGQD9z1MHBXyhn/HXIpU7LcBIHr9HYlsN7T9QoU2TYUEWpEFhKRwYOlGH73w
 AOvwydpVIbiMv2INvOVVtlYngukxY5b4VyO853L8YZHmWZ02Cx1r7FWSRsg52E9HHmrlULQdO
 NKy3bNTX3DY1D7lAr5ZCY4W5s1VqFiApMfTsyWU3pM9TJkH5IQdlohBU62bunmp/zrqgiFUPa
 7tIRallCfxFPpq19ZJJWkXdUsmm1UkmuCTrXBOxpNroI4G9DWPje09+ahqxaozM8M60qa6uws
 OIaizpbu0rmJqSLchzwpuas0PGzwErhRCYMIZoKN1rQ2Sy6q/wuAPn8xvh0xkDLRrNscotA4h
 zT76WGtb+qMK0Ri2R6LqltTU5gKQwm7hUoGvB8Fvhm62K1G73ZWtDPt5L77kwjl3vdh7HHA13
 AB0Htye1/KjDZtwtpqXqBWAey+Bm/OQ4XAPa3wGadK5mmTNiRM1bwUsB+1x2gZw1lqNKnnbUd
 sx9wPrREniwgbX+E1bsaJFjWxZnWKx4BEIQT7Acw/zw0Ht4ALY65os+iGCInC6j6EeDINlicz
 Wu3nsJs1HN/M9av6d/Hbs9FGcs1gqlqyhTef+e+GL0qzQOkEoTA1i64m+V7aFMar3aXPLD3sA
 labsolXriK1xAB8lWGFg0RDXHBVrVbNE7TQt2ljBNQwuu5iARZykrjYMCAADOn3TK6W/YHcL/
 JYQAambygdaU5hmzzOS5Ts3/hjzG9AOKyNM6T8OiIMMaHqKHVM+3A58sOoK0k6z0EYRR6SMRm
 TQuSOxyXDmYdgUSvgrWuePObzOYVo4eDffCQC0WGiHLhPWQ1qOzAvrMwOvJ6M97zOEh+iokm8
 99/kaJZZ6ff9iom9KmNzsZlwFw8yO2ncwJkTqe08tjXd+77a9FjPWpDM5zgMt+T4iz57ZuFMj
 BflPOlZRYht1CkIBeAokVcy6y1v5jo+l7PhITtJj+aRDXWP8OsSljXzEhew+Ddp92lE8lX+P9
 ZhUuhHEowO3oIlPrY8X/SMlV1MEOOi/946w5MKfN4HolJ+g4sgBp4xN8+dhuI4qC9kLS1KSyS
 MZ8m4FoFoJdmMngXp
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Thu, 22 Apr 2021, Emily Shaffer wrote:

> Some configs, such as wrapper directives like gerrit.createChangeId, or
> forthcoming hook configs, should apply to a superproject as well as all
> its submodules. It may not be appropriate to apply them globally - for
> example, if the user also contributes to many projects which do not use
> the configs necessary for one project-with-submodules - and it may be
> burdensome to apply them locally to the superproject and each of its
> submodules. Even if the user runs 'git submodule foreach "git config
> --local foo.bar', if a new submodule is added later on, that config is
> not applied to the new submodule.
>
> It is also inappropriate to share the entire superproject config, since
> some items - like remote URLs or partial-clone filters - would not apply
> to a submodule.
>
> To make life easier for projects with many submodules, then, create a
> new "config.superproject" config scope, which is included in the config
> parse for the superproject as well as for all the submodules of that
> superproject.
>
> For the superproject, this new config file is equally local to the local
> config; for the submodule, the new config file is less local than the
> local config. So let's include it directly before the local config
> during the config parse.
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>
> Notes:
>     Since v1:
>
>     - Used test_when_finished liberally in tests instead of bare cleanup=
 steps
>     - Fixed some nits regarding xstrdup instead of strbuf_detach.
>
>     One thing that I thought about but did not implement: rather than fi=
nding the
>     path to the superproject's gitdir, you could imagine gathering the c=
onfig by
>     making a call out to 'git -C ../ config' - but on second thought, it=
 seems like
>     that will make it harder to edit. However, if we don't want to be ab=
le to edit
>     superproject config from a submodule, that might be okay... (This ap=
proach could
>     make 'git config --show-origin' harder to implement, though, I think=
.) So I did
>     not make any changes about that.

Hmm. Have you thought about worktrees of subprojects that happen to be
outside the superproject's directory tree?

I also wonder whether it is necessary to change Git at all, as a
well-crafted `[includeIf "gitdir:/path/to/superproject/**"]` should do the
trick, but without complicating the config code even further.

Ciao,
Johannes
