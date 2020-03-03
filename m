Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391C5C3F2C6
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 22:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB2F20870
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 22:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbgCCWMe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 17:12:34 -0500
Received: from cpanel7.indieserve.net ([199.212.143.8]:49193 "EHLO
        cpanel7.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbgCCWMd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 17:12:33 -0500
X-Greylist: delayed 439 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Mar 2020 17:12:33 EST
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:56250 helo=localhost.localdomain)
        by cpanel7.indieserve.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1j9FmB-00CHSJ-MZ; Tue, 03 Mar 2020 17:12:32 -0500
Date:   Tue, 3 Mar 2020 17:12:29 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Junio C Hamano <gitster@pobox.com>
cc:     Damien Robert <damien.olivier.robert@gmail.com>,
        git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: Re: [PATCH v2 4/5] doc: be more precise on
 (fetch|push).recurseSubmodules
In-Reply-To: <xmqqo8td6qmm.fsf@gitster-ct.c.googlers.com>
Message-ID: <alpine.LFD.2.21.2003031709070.10776@localhost.localdomain>
References: <20200228103558.1684937-1-damien.olivier.robert+git@gmail.com>        <20200303170740.1879432-1-damien.olivier.robert+git@gmail.com>        <20200303170740.1879432-5-damien.olivier.robert+git@gmail.com>
 <xmqqo8td6qmm.fsf@gitster-ct.c.googlers.com>
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
> > diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.txt
> > index f11940280f..8f716809f9 100644
> > --- a/Documentation/config/fetch.txt
> > +++ b/Documentation/config/fetch.txt
> > @@ -2,10 +2,12 @@ fetch.recurseSubmodules::
> >  	This option can be either set to a boolean value or to 'on-demand'.
> >  	Setting it to a boolean changes the behavior of fetch and pull to
> >  	unconditionally recurse into submodules when set to true or to not
> > -	recurse at all when set to false. When set to 'on-demand' (the default
> > -	value), fetch and pull will only recurse into a populated submodule
> > +	recurse at all when set to false. When set to 'on-demand',
> > +	fetch and pull will only recurse into a populated submodule
> >  	when its superproject retrieves a commit that updates the submodule's
> >  	reference.
> > +	If not set, it fallbacks to the value of `submodule.recurse`, and
> > +	if both are not set the default value is 'on-demand'.

  missed earlier post ... "either set" should be "set either." also,
adverbs technically *follow* what they qualify, so "unconditionally
recusrse" should be "recurse unconditionally" and so on.

  it has always been thus.

rday

p.s. avoid use of the word "it" if it's potentially unclear what it
refers to. in the above, one reads, "If not set, it falls back ..."

*what* falls back?
