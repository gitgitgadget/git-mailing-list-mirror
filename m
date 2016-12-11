Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 252B9203EA
	for <e@80x24.org>; Sun, 11 Dec 2016 13:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753265AbcLKNu7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Dec 2016 08:50:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48778 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753220AbcLKNu7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Dec 2016 08:50:59 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9E363C04B928;
        Sun, 11 Dec 2016 13:50:58 +0000 (UTC)
Received: from krava (dhcp-1-167.brq.redhat.com [10.34.1.167])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id uBBDovSd002452;
        Sun, 11 Dec 2016 08:50:57 -0500
Date:   Sun, 11 Dec 2016 14:50:57 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] git crash for git remote update tip tip
Message-ID: <20161211135057.GA32029@krava>
References: <20161211121744.GA1973@krava>
 <20161211125116.xsabnud5tfwadndt@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161211125116.xsabnud5tfwadndt@sigill.intra.peff.net>
User-Agent: Mutt/1.7.1 (2016-10-04)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Sun, 11 Dec 2016 13:50:58 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 11, 2016 at 07:51:16AM -0500, Jeff King wrote:
> On Sun, Dec 11, 2016 at 01:17:44PM +0100, Jiri Olsa wrote:
> 
> > I accidentaly added 2 remotes and git remote update
> > crashed, see the attached output.
> > 
> > [jolsa@krava perf]$ git --version
> > git version 2.7.4
> 
> This is fixed already by b7410f616 (builtin/fetch.c: don't free
> remote->name after fetch, 2016-06-14), which is in v2.9.1.

ugh, time to update my fedora ;-)

thanks,
jirka
