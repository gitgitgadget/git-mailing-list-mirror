From: Jeff King <peff@peff.net>
Subject: Re: Rebase & Trailing Whitespace
Date: Fri, 9 Sep 2011 15:38:42 -0400
Message-ID: <20110909193842.GA31109@sigill.intra.peff.net>
References: <CAE1pOi0rY4kRR4rvEdFhzzTgfhUczHMX=H5_9+o5aHnv4vTadw@mail.gmail.com>
 <20110901023127.GB31838@sigill.intra.peff.net>
 <29267EE41F9343E68AAAE2C33AA40E1A@PhilipOakley>
 <20110901212618.GB16308@sigill.intra.peff.net>
 <4E6086AA.40806@drmicha.warpmail.net>
 <20110902082851.GA17703@sigill.intra.peff.net>
 <20110903201832.GB8362@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Philip Oakley <philipoakley@iee.org>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Fri Sep 09 21:38:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R26uZ-0006EA-4H
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 21:38:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759781Ab1IITip (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 15:38:45 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35744
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759687Ab1IITio (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 15:38:44 -0400
Received: (qmail 1278 invoked by uid 107); 9 Sep 2011 19:39:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 09 Sep 2011 15:39:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Sep 2011 15:38:42 -0400
Content-Disposition: inline
In-Reply-To: <20110903201832.GB8362@ecki>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181113>

On Sat, Sep 03, 2011 at 10:18:32PM +0200, Clemens Buchacher wrote:

> I am looking at the output of:
> 
>  git diff --check 4b825 -- $(git ls-files '*.[ch]'|grep -v ^compat)
> 
> Most of those are false positives from multiline function argument
> lists, which are aligned with the first line. So the above command
> would break more than it would fix.
> 
> I don't care either way, but for future reference: Do we or do we
> not want indentation with spaces in this case?

I thought our policy was that a tab is 8 spaces, and that indentations
of size N should be floor(N/8) tabs and (N%8) spaces. I know other
projects disagree (e.g., they want tabs for structural indentation and
spaces for all other alignment), but that seems to be the general use in
git.

-Peff
