From: Jeff King <peff@peff.net>
Subject: Re: missing tags!
Date: Wed, 8 Dec 2010 15:18:30 -0500
Message-ID: <20101208201829.GA15938@sigill.intra.peff.net>
References: <7986.1291837475@relay.known.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: layer <layer@known.net>
X-From: git-owner@vger.kernel.org Wed Dec 08 21:18:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQQTI-0005iA-Nj
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 21:18:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754292Ab0LHUSf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 15:18:35 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:60718 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752604Ab0LHUSf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 15:18:35 -0500
Received: (qmail 19116 invoked by uid 111); 8 Dec 2010 20:18:31 -0000
Received: from 129-79-255-95.dhcp-bl.indiana.edu (HELO sigill.intra.peff.net) (129.79.255.95)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 08 Dec 2010 20:18:31 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Dec 2010 15:18:30 -0500
Content-Disposition: inline
In-Reply-To: <7986.1291837475@relay.known.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163219>

On Wed, Dec 08, 2010 at 11:44:35AM -0800, layer wrote:

> I have a repo to which I push to frequently.  For each release of the
> software from this repo, I create an annotated tag and push it to this
> repo.  I noticed yesterday that he has a single tag in it, when it
> should have 100+.  The tag there was the last one I pushed to it.
> 
> The missing tags were created with
> 
>   git tag -a -m "release 4.2rm t1" release42rm_t1 HEAD
> 
> and pushed to the (bare) repo in question with
> 
>   git push origin release42rm_t1
> 
> I cannot imagine how the tags got deleted, and I'm looking for some
> guidance.

How did you verify that the tags were deleted? Are you sure they are not
just packed?

-Peff
