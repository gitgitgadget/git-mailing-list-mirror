Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60AB61FF40
	for <e@80x24.org>; Mon, 20 Jun 2016 17:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755153AbcFTRTC (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 13:19:02 -0400
Received: from cloud.peff.net ([50.56.180.127]:57350 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755009AbcFTRS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 13:18:57 -0400
Received: (qmail 32109 invoked by uid 102); 20 Jun 2016 17:18:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Jun 2016 13:18:24 -0400
Received: (qmail 16567 invoked by uid 107); 20 Jun 2016 17:18:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Jun 2016 13:18:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Jun 2016 13:18:22 -0400
Date:	Mon, 20 Jun 2016 13:18:22 -0400
From:	Jeff King <peff@peff.net>
To:	Stefan Beller <sbeller@google.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Vadim Eisenberg <VADIME@il.ibm.com>
Subject: Re: [PATCH] shallow clone to not imply shallow submodules
Message-ID: <20160620171821.GA2316@sigill.intra.peff.net>
References: <xmqq7fdkx5oz.fsf@gitster.mtv.corp.google.com>
 <1466441998-18896-1-git-send-email-sbeller@google.com>
 <20160620171312.GA1880@sigill.intra.peff.net>
 <CAGZ79kbKoch0odOOz2QWhoGoSOBOgYyQ_QgbxPXy2iJJVqP6Vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kbKoch0odOOz2QWhoGoSOBOgYyQ_QgbxPXy2iJJVqP6Vw@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jun 20, 2016 at 10:14:47AM -0700, Stefan Beller wrote:

> > This follows the style of the other tests, so it's the right thing here.
> > But as a style suggestion, I think:
> >
> >   git -C super_clone/sub log --oneline >lines &&
> >   test_line_count = 3 lines
> >
> > is nicer than the subshell. It's more succinct, and it saves a process.
> 
> which we would want to refactor to in a follow up, but not merge it
> through to 2.9.1.

Yeah, exactly. That was what I meant by "here".

-Peff
