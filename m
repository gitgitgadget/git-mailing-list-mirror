Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39F671F42D
	for <e@80x24.org>; Thu, 24 May 2018 20:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968625AbeEXUJC (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 16:09:02 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:42106 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967240AbeEXUJB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 16:09:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kmnbJEznnvZ+g7bmj7+y645QeC4XbMjn8z8Wd+8oHGo=; b=X/lAwmaTm1ERFU7luejyKibDn
        BaDDcgb1tSVEzqb0P2BnXSbGr3I5ZejdaY5IyQ7g+hIDTEy1KQdnzinPMmBHSsaUjLeutAr6pdtIs
        nNH/uTcdQEu6+n7snZR81sf0VHZ2CzXu2ud5FAhnTtGka4NAB09V3sK0l9wbbxjHF7C2+0kb7wOKb
        J/rqNCr+9D7m6tp4mFYkxKrbhhtHTnPb91yAL1y3M71wtdXXaX4NC3l4RXRtCYF9Vx02Li8QrrM43
        Notg7T8aZG9IKs4qNYfQt1NTih9NXppy41rg8N+88oWwt+Z2X8kgYhbWxEnSnxncmdbNlUZF4uUpm
        kVCv8cZhA==;
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:46676 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fLwXj-001I6A-8G; Thu, 24 May 2018 16:08:59 -0400
Date:   Thu, 24 May 2018 16:07:18 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] Use proper syntax for replaceables in command docs
In-Reply-To: <CAPig+cR91cEj1EdA4JvQQED0HJ2Db-LyrWCB_8VdC6uwT47KbA@mail.gmail.com>
Message-ID: <alpine.LFD.2.21.1805241606310.7010@localhost.localdomain>
References: <alpine.LFD.2.21.1805241552080.6217@localhost.localdomain> <CAPig+cR91cEj1EdA4JvQQED0HJ2Db-LyrWCB_8VdC6uwT47KbA@mail.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 24 May 2018, Eric Sunshine wrote:

> On Thu, May 24, 2018 at 3:54 PM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> > The standard for command documentation synopses appears to be:
> >
> >   [...] means optional
> >   <...> means replaceable
> >   [<...>] means both optional and replaceable
> >
> > So fix a number of doc pages that use incorrect variations of the
> > above.
> >
> > Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
> > ---
> > diff --git a/Documentation/git-check-attr.txt b/Documentation/git-check-attr.txt
> > @@ -9,7 +9,7 @@ git-check-attr - Display gitattributes information
> > -'git check-attr' [-a | --all | attr...] [--] pathname...
> > +'git check-attr' [-a | --all | attr...] [--] <pathname>...
> >  'git check-attr' --stdin [-z] [-a | --all | attr...]
>
> Don't you also want "<attr>"?
>
> > diff --git a/Documentation/git-check-ignore.txt b/Documentation/git-check-ignore.txt
> > @@ -9,8 +9,8 @@ git-check-ignore - Debug gitignore / exclude files
> > -'git check-ignore' [options] pathname...
> > +'git check-ignore' [<options>] <paths>...
>
> Earlier in the patch, you changed "pathname" to "<pathname>", but here
> you change "pathname" to "<paths>", which is inconsistent.
>
> It's also inconsistent and odd to say "<paths>..." (with the "...").
> Seems better just to say "<pathname>..." to match existing practice.

  points taken. note that this is not even close to a comprehensive
fix; i just did the stuff i ran across. there is almost certainly much
more, but i'll fix the above.

rday
