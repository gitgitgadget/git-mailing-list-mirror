Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE0B61F453
	for <e@80x24.org>; Fri, 18 Jan 2019 16:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbfARQ54 (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 11:57:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:41050 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727491AbfARQ54 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 11:57:56 -0500
Received: (qmail 7829 invoked by uid 109); 18 Jan 2019 16:57:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 18 Jan 2019 16:57:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12071 invoked by uid 111); 18 Jan 2019 16:57:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 18 Jan 2019 11:57:58 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Jan 2019 11:57:54 -0500
Date:   Fri, 18 Jan 2019 11:57:54 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, bwilliamseng@gmail.com,
        git <git@vger.kernel.org>, bwilliams.eng@gmail.com
Subject: Re: [PATCH] mailmap: update brandon williams's email address
Message-ID: <20190118165754.GA11350@sigill.intra.peff.net>
References: <20181207205621.49961-1-bwilliams.eng@gmail.com>
 <20181207214013.GA73340@google.com>
 <CAGZ79kYrgpZDqAhg8c11V_qJTCzzw4-qrVN2z_Y_OAeCbWU6dQ@mail.gmail.com>
 <20181207222225.GC73340@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181207222225.GC73340@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 07, 2018 at 02:22:25PM -0800, Jonathan Nieder wrote:

> Stefan Beller wrote:
> 
> > What would be more of interest is why we'd be interested in this patch
> > as there is no commit/patch sent by Brandon with this email in gits history.
> 
> I think there's an implicit assumption in this question that isn't
> spelled out.  Do I understand correctly that you're saying the main
> purpose of .mailmap is to figure out whether two commits are by the
> same author?
> 
> My own uses of .mailmap primarily have a different purpose: to find
> out the preferred contact address for the author of a given commit.

I just had to cc Brandon and manually look up his email address, which
made me wonder what ever happened to this patch. :)

FWIW, I also use mailmap to find contact email addresses, with:

  $ git help who
  'who' is aliased to '!sh -c 'git --no-pager log -1 --format="%an <%aE>" --author="$1" -i' -'

So lacking another such registry, I'd like to add my support for using
mailmap for this purpose.

-Peff
