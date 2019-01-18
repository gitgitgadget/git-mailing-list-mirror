Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A61651F453
	for <e@80x24.org>; Fri, 18 Jan 2019 12:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfARMzq (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 07:55:46 -0500
Received: from mout.gmx.net ([212.227.17.22]:41647 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbfARMzq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 07:55:46 -0500
Received: from [10.49.182.9] ([95.208.59.217]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MGFz9-1gz6Pp0jlX-00FCob; Fri, 18
 Jan 2019 13:55:34 +0100
Date:   Fri, 18 Jan 2019 13:55:17 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v3 1/1] abspath_part_inside_repo: respect core.fileMode
In-Reply-To: <xmqqa7kuat8j.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1901181351250.41@tvgsbejvaqbjf.bet>
References: <pull.104.v2.git.gitgitgadget@gmail.com> <pull.104.v3.git.gitgitgadget@gmail.com> <b935e11d21fc2a34953d1fc651ea09f1a4c1a769.1545692162.git.gitgitgadget@gmail.com> <xmqqftumb8zv.fsf@gitster-ct.c.googlers.com>
 <xmqqa7kuat8j.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:8U1GMPt/Wfw5h/C9p6ZxygIOJj+jiBlUJqPFDAAob2WQDMKIpZV
 yEXCgIomvLP0sJvBxZIciGZUi9Uz8lBmzmr/iRcT5A7y5P9SFIsix4uYeG+LxK6BddfdIg4
 KcMqxIwg9o+gb+Jg9RYsH7bOIvjB7/6EEEe1RzzEkt5AzCfbRfoWoHpa6khVNZuBlUcSOWx
 8+PsilGoKgG9999gH4ALg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DMBBOUApfRw=:mNo3EGf4i3YRLaKNu0pkto
 xsDxO5M5gqE4rafu+XQRcVQpeUryHzVLCLtm99Dd0nPF38WDKCKbEHrkpQxqU7m56jyZIoD11
 QsKFPvKsGWlF7YiTyDTg7Q0+34HLpAT043CyD/QpwlG6UJUuqzQITk7Fb/0rkjqNPLmAuxQGW
 Sk1TN9cUd28V9EHsYB/n30hIIgWd4+bAwvZnttyrMzhYlKYo+Jzs4Be+oJ19oC/wdlD3C2afp
 4Msznxw1C5yxbJFEBbs2q6S56OXdEC+YcxcDIGx6lKXtGe5HUgSrOS0jOuE2gIeMpQw+enrnf
 F2i2Ej9GypDd0CPBycWuK/LzHMtKEWVd25ueIjFFdW2gHBi80KzBMGzAnmjJU07L3SiQoybRB
 mZP+zE9hYaFGqeA+rgARcMa/QjERghy5dwSIhCLI2PyjceSPQonkMGefaeSVQ9V/6VvN7vPlU
 tZctC2oV8mFydcaCl+BKdWuMgXbajnTEvjnrrX+Y2iKqxJyrbYHS3bFv96KOYzDDG43KC5i2W
 ZNhFVntUE9t7SLouXez1VRoRHUzhCB0gG6GwjKPZ9C+DUmRo0nEN6hxonVjqoqmHCcR8NppID
 w0IEn839L8gyu//T0j89/v5AWFsbDKf/kCHoTdNcMGu80AJx/J4WPyepEAnIIHjvyuQoplA65
 8UoY36/748NQGkJLWZyKc5TN8Zv+9hKKAl/q6FOMtL/OPjPeLi8Ahg43CFUpIu+WsWVoO5zlh
 oYykij/CKPQmEcIjAHBZ1sSD+eQtAMQxWZZwsSs/b28wFVvlR785DTdHtrB2yGMlhe7WnKZMx
 xsnN8QqEhoiZbeU36lFA1wOOB/eRZudDiyBaIJdM3YpUKsRAtms7wC/51otLRvcT0lLNGLo9N
 UhcCoB0ZaQ67FZkxfZWgTIJ6H4z+GRrNzMKEF5606D3bXrNBM0jmK0dboqBhxsn+obBA236jt
 nQW6AZ1nBtw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

first of all, my apologies for the incorrect commit message (you missed
it, too, though): it is not about respecting core.fileMode, but about
core.ignoreCase.

On Tue, 25 Dec 2018, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > the resulting index entry is "blub" or "BLUB".  Shouldn't we verify
> > that "git add" adds an expected path to the index, instead of
> > blindly trusting that it says "Yeah, I did as I was told" with its
> > exit status?  Would we be adding 'blub' as that is what we told
> > 'git' to add, or would it be 'BLUB' as that is what exists on the
> > filesystem that is case insensitive but case preserving?
> 
> Needless to say, the last part of the above is a mere thetorical
> question, and I am not questioning the established behaviour or
> suggesting to "improve" it.  On a case insensitive filesystem, we
> trust what readdir() gave us (but match them with pathspec case
> insensitively) for a new path that is not in the index.  When we
> update the contents of a path that is already in the index, we
> preserve the case in the index, even when readdir() reports the same
> path in different case (iow, we trust the case in the index more
> than what readdir() gives us)..
> 
> What I am wondering in the above is if we should document that in
> the test, perhaps with a simple
> 
> 	git ls-files blub >actual &&
> 	echo BLUB >expect &&
> 	test_cmp expect actual
> 
> or something like that.

Actually, I would interpret the description in our documentation to mean
that Git does not want to trust what readdir() gave us but heed what the
user said, i.e. when `BLUB` is added as `git add blub`, Git really should
think that it is `blub`, not `BLUB` (i.e. the exact opposite of what you
suggest). From Documentation/config/core.txt's section about
`core.ignoreCase`:

	For example, if a directory listing finds "makefile" when Git
	expects "Makefile", Git will assume it is really the same file,
	and continue to remember it as "Makefile".

Ciao,
Dscho
