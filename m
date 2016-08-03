Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C45FE1F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 17:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757775AbcHCR3A (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 13:29:00 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:35673 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755690AbcHCR24 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 13:28:56 -0400
Received: by mail-qk0-f176.google.com with SMTP id x185so16364367qkc.2
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 10:28:50 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DL9KzZtuZCjYc8bs7jIfRRMnzpu2HtM3FWD0oq4q/ig=;
        b=G6zx8EpC6Y3js0+Crye6O1vje3Gj9prQCA/+J1BX9qHuXVj/1L4lV5rvIyep/iHWYg
         Hc0A4O5j/8IOoPqNx15R2rUZ6G1to55WAQD8SY3ogcIJ0bpfw03xNtkHhAQ1vYmMZKaw
         t/bNFXjM6JXCD/UQUafRRJ6tXR0LcM5g5h18Wbh8DPt0t/u5XFDn0xXgxkN342qpWU+j
         8/MuUWxEDd3kBamo2yLoHrxw+vnFqhFBzNZw31ciuqF9zmTZcctB1BBqrzdi3eNG1Kb4
         y3PYbqCrEUgPXMUmPx5J9xVuInCq74m+h0CcodXl8O++iOpjHe8G5VoelGGKHkNFBtNX
         mQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DL9KzZtuZCjYc8bs7jIfRRMnzpu2HtM3FWD0oq4q/ig=;
        b=BVgCfBN7H/Lge5K+uWXHlb5mPAlzmG64wAFjv+Xow90eKeB9vfodjUfmS20Qf3wake
         n7Lo3+lLev3Funt7aViCWVYe2aEqGfpUbucH1beottAvLLtox0Y32RsQ7CsjtCPgL82J
         w64pwLkiYgMm4t2gw45pMSEbhniz2kO1CaGgVNutkL+WErWjzdvdVbPJ3EuoNguvchQc
         RCOPfhcyoi5UDoU8df2YbMc6nd4wzIspyPzT4gYiDS7yJvEnCpOKhjw8iUPuNyqeLYxj
         hpEW3RfSpumyr9BJPDoZc5VDqhiQPA2SBDwCQ6Z9ccxI8IvypI9larZhKnm79Ek/1fxV
         oOog==
X-Gm-Message-State: AEkoouskDXqFst0yZSc4XNrC53xL2bHrrkac2qZ2+u49fukNK0V3JKnMNifKXH6KAUAEZ4tU
X-Received: by 10.55.107.130 with SMTP id g124mr1095084qkc.61.1470244964619;
        Wed, 03 Aug 2016 10:22:44 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-01.NATPOOL.NYU.EDU. [216.165.95.72])
        by smtp.gmail.com with ESMTPSA id j188sm1651619qke.22.2016.08.03.10.22.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Aug 2016 10:22:43 -0700 (PDT)
Date:	Wed, 3 Aug 2016 13:22:43 -0400
From:	Santiago Torres <santiago@nyu.edu>
To:	Stefan Beller <sbeller@google.com>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git <git@vger.kernel.org>
Subject: Re: [OT] USENIX paper on Git
Message-ID: <20160803172242.5jrd4saq7sga6iql@LykOS.localdomain>
References: <20160801224043.4qmf56pmv27riq4i@LykOS.localdomain>
 <20160803145830.uwssj4uhqfemhr4o@LykOS.localdomain>
 <alpine.DEB.2.20.1608031721430.107993@virtualbox>
 <20160803152510.pgcd2edareqdxnmh@LykOS.localdomain>
 <CAGZ79kZPPvi2jpFgu1MZ97gZm=QqBBiZ-XcXUJphm3UzNRP-FQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZPPvi2jpFgu1MZ97gZm=QqBBiZ-XcXUJphm3UzNRP-FQ@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 03, 2016 at 10:14:21AM -0700, Stefan Beller wrote:
> On Wed, Aug 3, 2016 at 8:25 AM, Santiago Torres <santiago@nyu.edu> wrote:
> >  > share things before they are published. Thankfully, this is OK in
> >> > USENIX's book. Here's the link:
> >> > http://i2.cdn.turner.com/cnnnext/dam/assets/160730192650-14new-week-in-politics-super-169.jpg
> >>
> >> While I had a good laugh, I am wondering whether this is the correct link?
> >
> > Oh my god, sorry, I meant to p, not to ctrl + v. My head is all over the
> > place as of late.
> >
> > Here's the correct link:
> >
> > http://isis.poly.edu/~jcappos/papers/torres_toto_usenixsec-2016.pdf
> 
> In 4.1 you write:
> > Finally, Git submodules are also vulnerable, as they automatically track
> > a tag (or branch). If a build dependency is included in a project as a part
> > of the submodule, a package might be vulnerable via an underlying library.
> 
> Submodules actually track commits, not tags or branches.
> 
> This is confusing for some users, e.g. the user intended to track
> a library at version 1.1, but it tracks 1234abcd instead (which is what
> 1.1 points at).

I'm assuming that git submodule update does update where the ref points
to, does it not?

let me dig into this and try to take the necessary measures to correct
this

Thanks for the feedback!

-Santiago.
