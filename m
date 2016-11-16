Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A702220451
	for <e@80x24.org>; Wed, 16 Nov 2016 21:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935773AbcKPVbJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 16:31:09 -0500
Received: from smtprelay01.ispgateway.de ([80.67.31.39]:54128 "EHLO
        smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932224AbcKPVbG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 16:31:06 -0500
Received: from [84.137.157.84] (helo=book.hvoigt.net)
        by smtprelay01.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1c77nJ-0004Qs-WB; Wed, 16 Nov 2016 22:31:02 +0100
Date:   Wed, 16 Nov 2016 22:31:00 +0100
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Jens.Lehmann@web.de, Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Subject: Re: [PATCH v4 4/4] submodule_needs_pushing() NEEDSWORK when we can
 not answer this question
Message-ID: <20161116213100.GA38510@book.hvoigt.net>
References: <cover.1479308877.git.hvoigt@hvoigt.net>
 <cover.1479308877.git.hvoigt@hvoigt.net>
 <9c95594f73625e06374f323fa5dc7d6487aa0356.1479308877.git.hvoigt@hvoigt.net>
 <xmqqoa1fp72o.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqoa1fp72o.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 16, 2016 at 11:18:07AM -0800, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
> > Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> > ---
> 
> Needs retitle ;-)  Here is what I tentatively queued.

Thanks ;-) Missed that one.

>     submodule_needs_pushing(): explain the behaviour when we cannot answer
>     
>     When we do not have commits that are involved in the update of the
>     superproject in our copy of submodule, we cannot tell if the remote
>     end needs to acquire these commits to be able to check out the
>     superproject tree.  Explain why we answer "no there is no need/point
>     in pushing from our submodule repository" in this case.
>     
>     Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>

Sound fine to me.

Cheers Heiko
