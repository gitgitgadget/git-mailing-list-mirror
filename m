Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE7031F731
	for <e@80x24.org>; Tue,  6 Aug 2019 15:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731608AbfHFP6t (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 11:58:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:35294 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726877AbfHFP6s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 11:58:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D37C8AE82;
        Tue,  6 Aug 2019 15:58:47 +0000 (UTC)
Date:   Tue, 6 Aug 2019 17:58:47 +0200
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     Mateusz Loskot <mateusz@loskot.net>
Cc:     git@vger.kernel.org
Subject: Re: Suggestion: git clone should warn if repository has submodules
Message-ID: <20190806175847.677319bf@kitsune.suse.cz>
In-Reply-To: <CABUeae9JhQ+JcNzYRMr40T2FTCJChYEz_riUr6Q1O5YO0uEDng@mail.gmail.com>
References: <CADqa0D5wVWk2wa-raeVmCEhCqYznpba4TeUW_7UQOA0huR-RAg@mail.gmail.com>
        <CABUeae9JhQ+JcNzYRMr40T2FTCJChYEz_riUr6Q1O5YO0uEDng@mail.gmail.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 6 Aug 2019 17:54:20 +0200
Mateusz Loskot <mateusz@loskot.net> wrote:

> On Tue, 6 Aug 2019 at 16:04, Jason Sewall <jasonsewall@gmail.com> wrote:
> >
> > Submodules are great, and I used them at work. The problem is, people
> > wind up cloning my repos without --recursive and then nothing works
> > for them, because  the submodules weren't populated and those
> > ultimately are needed to build my code.  
> 
> What you need is a simple document for your team that outlines the common
> Git workflow or README.md in root directory of your repositories with
> fat heading:
> 
> ## Clone
> 
> ```
> git clone --recursive ...
> ```
> 
> 
> A team in another company may require non-recursive clones by default
> and warnings from git may be quite annoying. Given the fact there is not
> one but may valid "my way"-s available, acceptable and supported by Git,
> I think, babysitting behaviour is not quite aligned with its philosophy, is it?

It has warnings that you can disable globally or per-repository in
configuration to fit your workflow.

Thanks

Michal
