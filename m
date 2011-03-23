From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3 0/5]rev-list and friends: --min-parents, --max-parents
Date: Wed, 23 Mar 2011 10:48:35 -0400
Message-ID: <20110323144835.GA30337@sigill.intra.peff.net>
References: <20110321105628.GC16334@sigill.intra.peff.net>
 <cover.1300872923.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Mar 23 15:48:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2PMc-0007F7-2n
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 15:48:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932703Ab1CWOsk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 10:48:40 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37995
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755524Ab1CWOsj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 10:48:39 -0400
Received: (qmail 5388 invoked by uid 107); 23 Mar 2011 14:49:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 23 Mar 2011 10:49:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Mar 2011 10:48:35 -0400
Content-Disposition: inline
In-Reply-To: <cover.1300872923.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169839>

On Wed, Mar 23, 2011 at 10:38:47AM +0100, Michael J Gruber wrote:

> Compared to what is currently in pu (which is v2+eps), v3 has:

This one looks good to me (I like the --no-{min,max}-parents).

> 1/3 -> 1/5 unchanged
> 
> 2/3 -> 2/5 unchanged
> 
> 3/5 is !squash for 2/5 and introduces --no-min-parents and --no-max-parents
> as natural ways to reset the limits
> 
> 3/3 -> 4/5 with a fix to the notation in documentation (spell out =<number>)
> and an additional dodecapus test
> 
> 5/5 is !fixup for 4/5 and adds test, doc and completion for --no-min-parents
> and --no-max-parents
> 
> Junio, please let me/us know whether sending an amended series in this way
> (which I've seen before) is actually convenient for you or not. !squash
> commits require a message edit, for example. OTOH, I don't know any (other?)
> good inter diff solution.

As a reviewer, I find it is usually most convenient to just have the
submitter do the squash, and then write below the "---" (or in a cover
letter like this) a brief explanation of the differences.

Yeah, I end up reading the whole patch again, including bits I already
read, but that is probably a good thing. A good patch is hopefully not
too long, and it is easier (to me, anyway) to review it as a whole and
not as an interdiff.

Technically speaking, what you posted gives more information, and I
could always apply and squash myself to get the final form. But I'm lazy
and I tend to review straight from the mail reader or from $EDITOR while
replying. So to me it's just an extra step.

I have occasionally seen people with long patches reply to the patch
themselves and say "btw, it is hard to see what is changed here in v2,
so here is a much more readable interdiff from v1". And that can be
useful at times, but it's nice to have the patch author using their
judgement about when it will be useful or not.

Just my two cents.

> Thanks for everyone's input which went into this (Junio, Jeff, Jonathan).

Thank you for taking the lead on writing it. :)

-Peff
