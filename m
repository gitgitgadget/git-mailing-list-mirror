Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2BB21F51C
	for <e@80x24.org>; Tue, 22 May 2018 16:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751507AbeEVQf3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 12:35:29 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:50992 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751443AbeEVQfZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 12:35:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CUPASJzuJbYa0GT2TiPefwjS0YuXnJ5/ePH2WNDRSSs=; b=cttZZ64rKhrM6RkxBk5Er89qe
        GZ+ziwNbj7cV7XdvYhzY7sFzlglY3zPqFJH1lUPRM9Jym/U3zjUqzJ50bog18VJJe9izh5sK/ifZQ
        l+gv7V7UrcJLKkgS4NkrIOgt7C5GOvuUZA4b2THXV8mVVEDeM4D90dMHa4T1JGf4wxw5CYIp9Symp
        zP1F1m6rNLFLkx0I4Fadg1OpltsjVbykmB+IVfNOPiw4KobBwC5sJz4SzbXTeZKVHgBC6kLs+K7KA
        gNQXI/FL3XG++pcDLXAxhROHSBP44/p+hZ3KIJq4RkkATRkJ2moCvfoXtMYCE4wYogTh73l1w+hYH
        jZ+YQTMqg==;
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:32768 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fLAFu-004zpn-K0; Tue, 22 May 2018 12:35:23 -0400
Date:   Tue, 22 May 2018 12:33:50 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: should config options be treated as case-sensitive?
In-Reply-To: <87h8mz99d2.fsf@evledraar.gmail.com>
Message-ID: <alpine.LFD.2.21.1805221231480.10513@localhost.localdomain>
References: <alpine.LFD.2.21.1805220353370.989@localhost.localdomain> <87h8mz99d2.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-436048474-1527006832=:10513"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-436048474-1527006832=:10513
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 22 May 2018, Ævar Arnfjörð Bjarmason wrote:

>
> On Tue, May 22 2018, Robert P. J. Day wrote:
>
> >   in my wanderings, more oddities, such as this:
> >
> > $ grep -ir blankboundary *
> > builtin/blame.c:	if (!strcmp(var, "blame.blankboundary")) {
> > Documentation/config.txt:blame.blankBoundary::
> > Documentation/blame-options.txt:	be controlled via the `blame.blankboundary` config option.
> > Documentation/RelNotes/2.15.1.txt: * Description of blame.{showroot,blankboundary,showemail,date}
> > Documentation/RelNotes/2.16.0.txt: * Description of blame.{showroot,blankboundary,showemail,date}
> > $
> >
> > where you can see the single instance of "blankBoundary" in
> > Doc/config.txt (with the upper case 'B'), while the rest have no such
> > thing.
> >
> >   for fun, i checked another of blame's config settings, with similar
> > results:
> >
> > builtin/blame.c:	if (!strcmp(var, "blame.showemail")) {
> > Documentation/config.txt:blame.showEmail::
> > Documentation/RelNotes/2.15.1.txt: * Description of blame.{showroot,blankboundary,showemail,date}
> > Documentation/RelNotes/2.5.0.txt: * "git blame" learned blame.showEmail configuration variable.
> > Documentation/RelNotes/2.16.0.txt: * Description of blame.{showroot,blankboundary,showemail,date}
> > Documentation/git-blame.txt:	This can also be controlled via the `blame.showEmail` config
> > t/t8002-blame.sh:test_expect_success 'setup showEmail tests' '
> > t/t8002-blame.sh:test_expect_success 'blame with showemail options' '
> > t/t8002-blame.sh:test_expect_success 'blame with showEmail config false' '
> > t/t8002-blame.sh:	git config blame.showEmail false &&
> > t/t8002-blame.sh:test_expect_success 'blame with showEmail config true' '
> > t/t8002-blame.sh:	git config blame.showEmail true &&
> >
> >   thoughts?
>
> The issues you note about the docs using foo.barbaz instead of
> foo.barBaz should be fixed, but as noted in the "Syntax" section of
> "git-config" we already document that the config keys are all
> case-insensitive. We just like talking about them as foo.barBaz
> because it makes for easier reading.

  ah, got it, so really, the only example above that would merit
tweaking would be:

  blame-options.txt:  be controlled via the `blame.blankboundary` config option.

i'll collect those in my travels and submit them all at once.

rday
--8323328-436048474-1527006832=:10513--
