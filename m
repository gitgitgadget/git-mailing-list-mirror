From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] branch: add optional parameter to -r to specify
 remote
Date: Mon, 20 Jun 2011 03:03:16 -0400
Message-ID: <20110620070316.GA15246@sigill.intra.peff.net>
References: <1308511149-10933-1-git-send-email-billiob@gmail.com>
 <1308511149-10933-2-git-send-email-billiob@gmail.com>
 <7vtyble9k8.fsf@alter.siamese.dyndns.org>
 <4DFEEB60.5000005@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Boris Faure <billiob@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jun 20 09:03:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYYW7-00047G-3b
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 09:03:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753183Ab1FTHDW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 03:03:22 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45482
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753008Ab1FTHDV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 03:03:21 -0400
Received: (qmail 18647 invoked by uid 107); 20 Jun 2011 07:03:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 20 Jun 2011 03:03:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Jun 2011 03:03:16 -0400
Content-Disposition: inline
In-Reply-To: <4DFEEB60.5000005@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176052>

On Mon, Jun 20, 2011 at 08:40:32AM +0200, Johannes Sixt wrote:

> > 	$ git branch --match "jk/*"
> > 
> > to show only local topic branches whose names match the given blob.
> 
> I would hate having to learn a new syntax '--match "jk/*"' when we can
> already say
> 
>     $ git log --remotes
>     $ git log --remotes=alice --remotes=bob
>     $ git log --remotes="jk/*"
> 
> IMO, it is the right approach to have a long option --remotes with an
> optional argument.

For that matter, --match should be spelled "--glob", as we already have:

  $ git log --glob='jk/*'

I think having the ref-selection for "git branch" match that of the
revision walker makes sense.

-Peff
