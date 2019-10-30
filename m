Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A51141F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 20:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfJ3U1l (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 16:27:41 -0400
Received: from smtprelay0216.hostedemail.com ([216.40.44.216]:46720 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726527AbfJ3U1k (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 30 Oct 2019 16:27:40 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 6E8A2182CED2A;
        Wed, 30 Oct 2019 20:27:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: pies33_259d285a85926
X-Filterd-Recvd-Size: 1629
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Wed, 30 Oct 2019 20:27:38 +0000 (UTC)
Message-ID: <d56bb5bcba50f1d9adf861b985a9646e7f65bdc9.camel@perches.com>
Subject: Re: request: add git grep -o option
From:   Joe Perches <joe@perches.com>
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>
Date:   Wed, 30 Oct 2019 13:27:29 -0700
In-Reply-To: <20191030201757.GA29013@sigill.intra.peff.net>
References: <277ee7531df8dfd3249f189b9b298a5d187ec479.camel@perches.com>
         <20191030201757.GA29013@sigill.intra.peff.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2019-10-30 at 16:17 -0400, Jeff King wrote:
> On Wed, Oct 30, 2019 at 12:58:59PM -0700, Joe Perches wrote:
> 
> > Instead of duplicating a grep pattern with grep -oh after
> > git grep like
> > this:
> > 
> > $ git grep -P '(?:[a-z0-9_]+_)?for_each(?:_[a-z0-9_]+)?' -- '*.[ch]' | \
> >   grep -P -oh '(?:[a-z0-9_]+_)?for_each(?:_[a-z0-9_]+)?'
> > 
> > it could be useful to have git grep have the same '-o' option 
> > as gnu grep.
> 
> Doesn't it already?
> 
>   $ git grep -P -oh '(?:[a-z0-9_]+_)?for_each(?:_[a-z0-9_]+)?'
>   for_each
>   for_each
>   for_each_abbrev
>   for_each_builtin
>   for_each_string_list_item
>   for_each_ut
>   [etc...]
> 
> It was new in Git v2.19.

OK, nice.  I never actually tried it and I have 2.24.
My docs need updating as that option is not mentioned.


