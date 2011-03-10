From: Jeff King <peff@peff.net>
Subject: Re: Summer of Code project ideas due this Friday
Date: Thu, 10 Mar 2011 11:30:11 -0500
Message-ID: <20110310163011.GA17137@sigill.intra.peff.net>
References: <AANLkTinpVKBjcqxaCGH0vp82kpKsO2uCBPdMoMKco6Ex@mail.gmail.com>
 <20110303185918.GA18503@sigill.intra.peff.net>
 <AANLkTinXZDq5FJxMmxUuWpCGgMYb3HH774eLJCojmnOz@mail.gmail.com>
 <20110303203323.GA21102@sigill.intra.peff.net>
 <20110309174956.GA22683@sigill.intra.peff.net>
 <AANLkTinpAOE06YX-m=ptQM_y-QMGpVmjewDxWopkXJkQ@mail.gmail.com>
 <20110309215841.GC4400@sigill.intra.peff.net>
 <20110310001017.GA24169@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>, git <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 17:30:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pxikn-0005zK-5H
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 17:30:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751989Ab1CJQaO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 11:30:14 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38535
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750963Ab1CJQaN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 11:30:13 -0500
Received: (qmail 28583 invoked by uid 107); 10 Mar 2011 16:30:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 Mar 2011 11:30:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Mar 2011 11:30:11 -0500
Content-Disposition: inline
In-Reply-To: <20110310001017.GA24169@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168830>

On Wed, Mar 09, 2011 at 06:10:17PM -0600, Jonathan Nieder wrote:

> 2. Merge libgit2 into git.git: polish the existing code in libgit2 so
>    that standard git can use it.  Presumably this would happen by
>    porting one function at a time, not by making git link to libgit2
>    immediately.  People familiar with libgit2 might be able to pick
>    out particularly interesting subsets to start with (diff
>    generation?).

That's definitely bigger than a SoC project at this point. However, one
smaller project might be to start implementing a subset of git commands
(probably plumbing) on top of libgit2, and then see how well the result
passes git.git tests.

> 4. filter-branch killer: using fast-import's new features to implement
>    common filter-branch operations (--subdirectory-filter,
>    --prune-empty, obliterating certain files) faster.

Yeah, I like that. Or maybe somebody can pick up git-sequencer, which in
theory could be used to filter-branch, too (or maybe sequencer can go on
top of fast-import? :) ).

> 5. rev-list: Coping with timeskew.

I don't think this is big enough for a SoC project. It's on my todo list
for the near-term, though.

> 7. packfilev4.

I suspect that is too complex for a SoC project. But you never know.

-Peff
