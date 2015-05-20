From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] git-verify-pack.txt: fix inconsistent spelling of
 "packfile"
Date: Wed, 20 May 2015 15:49:07 -0400
Message-ID: <20150520194906.GA8421@peff.net>
References: <1431845814-2541-1-git-send-email-ps@pks.im>
 <xmqqwq04745w.fsf@gitster.dls.corp.google.com>
 <20150519222427.GA994@peff.net>
 <xmqqmw0znjfc.fsf@gitster.dls.corp.google.com>
 <xmqqd21vnid6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 20 21:49:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yv9zc-0000Ai-NE
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 21:49:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754551AbbETTtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 15:49:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:33382 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754162AbbETTtK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 15:49:10 -0400
Received: (qmail 24730 invoked by uid 102); 20 May 2015 19:49:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 May 2015 14:49:09 -0500
Received: (qmail 26270 invoked by uid 107); 20 May 2015 19:49:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 May 2015 15:49:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 May 2015 15:49:07 -0400
Content-Disposition: inline
In-Reply-To: <xmqqd21vnid6.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269510>

On Wed, May 20, 2015 at 12:45:09PM -0700, Junio C Hamano wrote:

> One related thing is that there are few mentions of "idx file" to
> refer to "pack index" (e.g. show-index and verify-pack documentation
> pages); I think this was an attempt to disambiguate "pack index"
> from "the Index", but as long as we spell it "pack index", I think
> it should be OK, so while we are at it we may want to fix them.  We
> can leave "pack .idx file" as-is, but rewriting it to "pack index
> file" or just "pack index" may be OK as long as it is clear from the
> context.
> 
> "git show-index" has this in SYNOPSIS:
> 
> 	'git show-index' < idx-file
> 
> It probably should become
> 
> 	'git show-index' < <pack-index>

That makes "pack-file" make more sense to me. It is not "the abstract
concept of a packfile", but "the file with the .pack extension" (just as
"idx-file" is "the file with the .idx extension"). They are the same
thing if you think about it, of course, but you might choose one over
the other depending on the context.

-Peff
