Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F00CC3F2C6
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 22:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E39C3206E6
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 22:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgCCW4x (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 17:56:53 -0500
Received: from cpanel7.indieserve.net ([199.212.143.8]:32832 "EHLO
        cpanel7.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbgCCW4x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 17:56:53 -0500
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:56228 helo=localhost.localdomain)
        by cpanel7.indieserve.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1j9Ff7-00CGPS-B1; Tue, 03 Mar 2020 17:05:13 -0500
Date:   Tue, 3 Mar 2020 17:05:10 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Junio C Hamano <gitster@pobox.com>
cc:     Damien Robert <damien.olivier.robert@gmail.com>,
        git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: Re: [PATCH v2 3/5] doc: explain how to deactivate recurse.submodule
 completely
In-Reply-To: <xmqqsgip6r0d.fsf@gitster-ct.c.googlers.com>
Message-ID: <alpine.LFD.2.21.2003031703030.10381@localhost.localdomain>
References: <20200228103558.1684937-1-damien.olivier.robert+git@gmail.com>        <20200303170740.1879432-1-damien.olivier.robert+git@gmail.com>        <20200303170740.1879432-4-damien.olivier.robert+git@gmail.com>
 <xmqqsgip6r0d.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel7.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel7.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel7.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 3 Mar 2020, Junio C Hamano wrote:

> Damien Robert <damien.olivier.robert@gmail.com> writes:
>
> > Signed-off-by: Damien Robert <damien.olivier.robert+git@gmail.com>
> > ---
> >  Documentation/config/submodule.txt | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/Documentation/config/submodule.txt b/Documentation/config/submodule.txt
> > index 5962f41ead..74e691a487 100644
> > --- a/Documentation/config/submodule.txt
> > +++ b/Documentation/config/submodule.txt
> > @@ -63,6 +63,13 @@ submodule.recurse::
> >  	(`checkout`, `fetch`, `grep`, `pull`, `push`, `read-tree`, `reset`,
> >  	`restore` and `switch`) except `clone` and `ls-files`.
> >  	Defaults to false.
> > +	When set to true, it can be deactivated by calling
> > +	`--no-recurse-submodules`. Note that some Git commands without this
>
> You do not "call" an option [*1*].  Perhaps "... can be overriden by
> passing the `--no-recurse-submodules` option from the command line."

  nooooooo ... my biggest gripe with documentation is the unnecessary
use of superfluous words. :-)

  simply, "can be deactivated via the '--no-recurse-submodules'
option." no one here's getting paid by the word.

rday
