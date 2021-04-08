Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD76C433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 17:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B19F0610CC
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 17:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbhDHRRB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 13:17:01 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:38608 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231676AbhDHRQ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 13:16:59 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 797161F4B4;
        Thu,  8 Apr 2021 17:16:48 +0000 (UTC)
Date:   Thu, 8 Apr 2021 17:16:48 +0000
From:   Eric Wong <e@80x24.org>
To:     Georgios Kontaxis <geko1702+commits@99rst.org>
Cc:     Georgios Kontaxis via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7AgQmphcm1hc29uIg==?= 
        <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v5] gitweb: redacted e-mail addresses feature.
Message-ID: <20210408171648.GA7133@dcvr>
References: <pull.910.v4.git.1616396267010.gitgitgadget@gmail.com>
 <pull.910.v5.git.1616817387441.gitgitgadget@gmail.com>
 <20210329014744.GA2813@dcvr>
 <8330ef0d7195de461f961d72f90998fa.squirrel@mail.kodaksys.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8330ef0d7195de461f961d72f90998fa.squirrel@mail.kodaksys.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Georgios Kontaxis <geko1702+commits@99rst.org> wrote:
> > Georgios Kontaxis via GitGitGadget <gitgitgadget@gmail.com> wrote:
> >> Introduce an 'email-privacy' feature which redacts e-mail addresses
> >> from the generated HTML content
> >
> Eric Wong wrote:
> > A general reply to the topic: have you considered munging
> > addresses in a way that is still human readable, but obviously
> > obfuscated?
> >
> > On some other project, I settled on HTML "&#8226;" as a replacement
> > for '.' for admins who enable that option.  The $USER@$NO_DOT
> > remains as-is for easy identification+recognition of hosts.
> >
> Thanks for the suggestion.
> 
> People have been trying to hinder address harvesting for a while now.
> Replacing '@' with "at", the dot with "dot", adding spaces, etc.
> was pretty common at some point. May still be.
> I would expect crawlers to have caught up and this includes
> all sorts of character encodings and unicode look-alike substitutions.

I figure the crawlers hit a combinatorial explosion and
give up since they'd be wasting time with false-positives.

> > I also considered Unicode homographs which can look identical
> > to replacement characters, too; but rejected that idea since
> > it would cause grief for legitimate users who would not notice
> > the homograph when pasting into their mail client.

As a data point, none of the homograph@ candidates I posted here
on Mar 29 have attracted any attempts on my mail server.
