Return-Path: <SRS0=C4D3=4R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C97DC3F2D1
	for <git@archiver.kernel.org>; Sat, 29 Feb 2020 03:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30ED5246A2
	for <git@archiver.kernel.org>; Sat, 29 Feb 2020 03:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgB2DEA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Feb 2020 22:04:00 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:48986 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726046AbgB2DEA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Feb 2020 22:04:00 -0500
Received: from callcc.thunk.org (guestnat-104-133-8-109.corp.google.com [104.133.8.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01T33jbl006374
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Feb 2020 22:03:46 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id B440D42045B; Fri, 28 Feb 2020 22:03:44 -0500 (EST)
Date:   Fri, 28 Feb 2020 22:03:44 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        rcdailey.lists@gmail.com, newren@gmail.com, rsbecker@nexbridge.com,
        annulen@yandex.ru
Subject: Re: [PATCH] pull: warn if the user didn't say whether to rebase or
 to merge
Message-ID: <20200229030344.GG101220@mit.edu>
References: <20200228215833.319691-1-alexhenrie24@gmail.com>
 <xmqqeeuecngu.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqeeuecngu.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 28, 2020 at 03:16:01PM -0800, Junio C Hamano wrote:
> > To
> > avoid that situation, Git should require users to explicitly specify
> > whether their primary workflow is a contributor/rebasing workflow or a
> > maintainer/merging workflow.
> 
> There is nothing Git "should" do.  There are things we wish Git did,
> and we give orders to the codebase to do so in our proposed log
> message.  Perhaps like:

I'd also note that there are some workflows that assume that --rebase
is *never* a good thing, even for contributors.  We can decide whether
we want to bias the git man page in favor of one workflow as opposed
to another, for the sake of new git users, but I don't think it's
accurate to say (or even imply) that there are only two workflows:
contributor/rebasing and maintainer/merging.

							- Ted
