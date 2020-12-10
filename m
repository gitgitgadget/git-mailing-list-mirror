Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E38C2BBCF
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 15:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8E9623B85
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 15:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391582AbgLJP2X (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 10:28:23 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:34945 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2391625AbgLJP2W (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 10:28:22 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0BAFRFnH031029
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Dec 2020 10:27:16 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 4FC70420136; Thu, 10 Dec 2020 10:27:15 -0500 (EST)
Date:   Thu, 10 Dec 2020 10:27:15 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: fc/pull-merge-rebase, was Re: What's cooking in git.git (Dec
 2020, #01; Tue, 8)
Message-ID: <20201210152715.GQ52960@mit.edu>
References: <xmqqpn3j4ved.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2012091502000.25979@tvgsbejvaqbjf.bet>
 <xmqqk0tq1xf3.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqk0tq1xf3.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 09, 2020 at 01:28:48PM -0800, Junio C Hamano wrote:
> 
> A spot check: do you have pull.rebase set to anything in your
> config?

FWIW, I haven't set pull.rebase to anything, but what I have done is
to simply added --ff-only or --rebase to my "git pull" commands.  I
type fast, though, so it's not that a big deal, and I like the fact
that the warning is making me explicitly express what it is that I
want to have happen.

It's also true that very often, I end up running "git fetch", then
look at what I got pulled down, and only then run either "git merge"
or "git merge --ff-only" or "git rebase" explicitly.

Cheers,

					- Ted
