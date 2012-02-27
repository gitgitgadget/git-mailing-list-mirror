From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] fsck: do not print dangling objects by default
Date: Mon, 27 Feb 2012 23:18:24 +0100
Message-ID: <20120227221820.GA1194@ecki>
References: <20120226204357.GA26088@ecki>
 <7vty2ddzqj.fsf@alter.siamese.dyndns.org>
 <7vhayddxgp.fsf@alter.siamese.dyndns.org>
 <20120227191846.GB1600@sigill.intra.peff.net>
 <7vr4xg6pn2.fsf@alter.siamese.dyndns.org>
 <20120227211316.GA29081@ecki>
 <20120227213304.GB19779@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 27 23:26:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S291y-0002j4-U6
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 23:26:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755907Ab2B0W0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Feb 2012 17:26:49 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:45915 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755899Ab2B0W0s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 17:26:48 -0500
Received: from localhost (p5B22E80B.dip.t-dialin.net [91.34.232.11])
	by bsmtp.bon.at (Postfix) with ESMTP id 22AAD13004D;
	Mon, 27 Feb 2012 23:26:45 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20120227213304.GB19779@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191686>

On Mon, Feb 27, 2012 at 04:33:04PM -0500, Jeff King wrote:
> On Mon, Feb 27, 2012 at 10:13:16PM +0100, Clemens Buchacher wrote:
> 
> > > Yes, that was certainly part of my pros-and-cons analysis.  If you run
> > > "git fsck" without "--no-dangling" without reading the manual, you may
> > > get confused, but that is *not* the primary audience.
> > 
> > It is not my only concern that users might be confused. I believe the
> > command prints a lot of useless messages, which is by itself a UI
> > deficiency. But even worse, those numerous messages tend to hide an
> > actual problem in a long scrollback buffer. Sometimes my scrollback
> > buffer is not even large enough and I have to re-run fsck (which is not
> > exactly a fast command), just so I can grep out the dangling blobs.
> 
> Yeah, but doesn't adding "--no-dangling" solve that issue?

I can just as well use grep -v ^dangling.
