Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C3EC208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 16:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751850AbdHRQUm (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 12:20:42 -0400
Received: from smtprelay04.ispgateway.de ([80.67.29.8]:33710 "EHLO
        smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750846AbdHRQUl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 12:20:41 -0400
X-Greylist: delayed 834 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Aug 2017 12:20:40 EDT
Received: from [89.15.237.222] (helo=book.hvoigt.net)
        by smtprelay04.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1dijnG-0002vi-0P; Fri, 18 Aug 2017 18:06:42 +0200
Date:   Fri, 18 Aug 2017 18:06:40 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC PATCH 2/2] submodule: simplify decision tree whether to or
 not to fetch
Message-ID: <20170818160640.GC69414@book.hvoigt.net>
References: <20170817105349.GC52233@book.hvoigt.net>
 <20170817110013.GD52233@book.hvoigt.net>
 <CAGZ79kZ2oOK_=jdKa9EMMUO8pi+v+f6tn83sSvafO1Jg5YOjew@mail.gmail.com>
 <20170817175007.GA109680@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170817175007.GA109680@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 17, 2017 at 10:50:07AM -0700, Brandon Williams wrote:
> On 08/17, Stefan Beller wrote:
> > On Thu, Aug 17, 2017 at 4:00 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> > > To make extending this logic later easier.
> > >
> > > Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> > > ---
> > > I am quite sure I replicated the same logic but a few more eyes would be
> > > appreciated.
> > 
> > A code cleanup is appreciated!
> > 
> > I thought Brandon had a series in flight doing a very similar cleanup here,
> > but in master..pu there is nothing to be found.
> 
> Yeah there are 2 series in flight which will probably conflict here.
> bw/grep-recurse-submodules and bw/submodule-config-cleanup

Ok then I will wait until those are in and then see if I can base the
cleanup on top. I think it is only necessary as a preparation for the
fully fledged fetch configuration logic mess we will get into once we
get to the full recursive submodule fetch implementation. Not
necessarily needed for the moved submodules.

> > 
> > The code looks good to me.

Thanks.

Cheers Heiko
