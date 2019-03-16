Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1BBD20248
	for <e@80x24.org>; Sat, 16 Mar 2019 13:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfCPNsG (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Mar 2019 09:48:06 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:37486 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbfCPNsG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Mar 2019 09:48:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ydz1J0LybaPZ+zQ8i4DWWoBq7uK/cEQdrFrmFERSPXk=; b=GRmyNFSEMmv4Q5xPafcnv6Faw
        Yrr7W71yx6VlWG08Qk0g9/p1bnNHAlw7kyXjBKaYLDsRHrtTvqXwDeXzLaveJl/X/JbTzWKDEPLqI
        eiuD3qjnzbHldQp7aKAqohtpNwt2Jh45xyQ2uDOGGpDYK8Q5sOckvEf6YZgT1lbhXFMKc2OALoSFB
        2hJ5ztvxsmEmI7M1iFIVBblrbM7sbrZ5jREBAie1nC0na1+q/01v0vAvhAyQZSDOl21SjvS/k+YFl
        edIHa+kUMXoXQnFnc4QW/F+OC51BVzhDhJkEmWig+MehFoAgmjYwcyz+oi0eCkTOd7Qhmz4Eik/Rr
        36JfIBsCw==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:45968 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1h59fO-00BCyw-NJ; Sat, 16 Mar 2019 09:48:03 -0400
Date:   Sat, 16 Mar 2019 09:48:01 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: "man gitattributes" doesn't explain comma-separated attribute
 values
In-Reply-To: <87r2b79d3p.fsf@evledraar.gmail.com>
Message-ID: <alpine.LFD.2.21.1903160947430.12393@localhost.localdomain>
References: <alpine.LFD.2.21.1903160816410.10724@localhost.localdomain> <87r2b79d3p.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1030896118-1552744083=:12393"
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

--8323328-1030896118-1552744083=:12393
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Sat, 16 Mar 2019, Ævar Arnfjörð Bjarmason wrote:

>
> On Sat, Mar 16 2019, Robert P. J. Day wrote:
>
> >   more nitpicking, but i'm working my way through the intricacies of
> > attributes and putting together some (allegedly) simple examples for a
> > class i'm giving on monday, and i noted a couple possible shortcomings
> > in "man gitattributes".
> >
> >   as a working example, i looked at the top-level .gitattributes file
> > in the git source code itself, which opens with:
> >
> >   * whitespace=!indent,trail,space
> >   *.[ch] whitespace=indent,trail,space diff=cpp
> >   *.sh whitespace=indent,trail,space eol=lf
> >   ... snip ...
> >
> > first observation is that i see nothing in the man page that explains
> > the notion of a comma-separated list of attribute values. maybe i
> > missed it or maybe it's supposed to be intuitively obvious, but
> > there's nothing i can see that mentions the possibility.
> >
> >   related to that is that there is no explanation as to how to
> > interpret:
> >
> >   * whitespace=!indent,trail,space
> >
> > does the "!" apply to "indent" or to the entire list? the man page
> > doesn't say.
> >
> >   just being pedantic again.
> >
> > rday
>
> It's documented in gitglossary, search for "attr". That's not an excuse
> or a statement that that doesn't suck, just a pointer for anyone
> interested in fixing the docs.

  ah, gotcha. thenk you kindly.

rday

--8323328-1030896118-1552744083=:12393--
