Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84EEA202DD
	for <e@80x24.org>; Tue, 24 Oct 2017 06:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751349AbdJXG6I (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 02:58:08 -0400
Received: from ikke.info ([178.21.113.177]:60266 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750886AbdJXG6H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 02:58:07 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 9284B44039C; Tue, 24 Oct 2017 08:58:06 +0200 (CEST)
Date:   Tue, 24 Oct 2017 08:58:06 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org,
        Rafael =?iso-8859-1?Q?Ascens=E3o?= <rafa.almas@gmail.com>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2] column: show auto columns when pager is active
Message-ID: <20171024065806.GA7987@alpha.vpn.ikke.info>
References: <20171011172310.2932-1-me@ikke.info>
 <20171016183511.12528-1-me@ikke.info>
 <20171023215246.r3xevx5jey5pyuuz@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171023215246.r3xevx5jey5pyuuz@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 23, 2017 at 02:52:46PM -0700, Jonathan Nieder wrote:
> Hi,
> 
> Kevin Daudt wrote:
> 
> > --- a/column.c
> > +++ b/column.c
> > @@ -5,6 +5,7 @@
> >  #include "parse-options.h"
> >  #include "run-command.h"
> >  #include "utf8.h"
> > +#include "pager.c"
> 
> Should this be pager.h?
> 
> Thanks,
> Jonathan

Thanks for catching this.
