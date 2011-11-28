From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/6] echo usernames as they are typed
Date: Mon, 28 Nov 2011 13:59:56 -0500
Message-ID: <20111128185956.GA28191@sigill.intra.peff.net>
References: <20111124105801.GA6168@sigill.intra.peff.net>
 <20111127082744.GA32068@sigill.intra.peff.net>
 <CABPQNSb09kxjvdvz2P-WqU2VtMspaaA8ujTNLJ4+MuCrV=2zsw@mail.gmail.com>
 <20111128035321.GA15640@sigill.intra.peff.net>
 <CABPQNSbLvWh-ivaqBk-Du+kwZvV3t+ajEJhHATRzyGZbHYyM=Q@mail.gmail.com>
 <20111128113127.GA23408@sigill.intra.peff.net>
 <CABPQNSYd8PFsoRi6NtjQYNQzM+NHv_aRCLRWQ=XsFuw2gGWAng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 28 20:00:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RV6RA-0006jF-HF
	for gcvg-git-2@lo.gmane.org; Mon, 28 Nov 2011 20:00:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753892Ab1K1S77 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Nov 2011 13:59:59 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54117
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752843Ab1K1S76 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2011 13:59:58 -0500
Received: (qmail 26202 invoked by uid 107); 28 Nov 2011 19:06:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 Nov 2011 14:06:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Nov 2011 13:59:56 -0500
Content-Disposition: inline
In-Reply-To: <CABPQNSYd8PFsoRi6NtjQYNQzM+NHv_aRCLRWQ=XsFuw2gGWAng@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186026>

On Mon, Nov 28, 2011 at 01:59:34PM +0100, Erik Faye-Lund wrote:

> > Certainly on non-Windows something like that would not be welcome. The
> > user can already have specified GIT_ASKPASS if they don't have a
> > terminal. And once the credential-helper code is in, they can use a
> > platform-specific helper that provides a nice dialog if they want it.
> >
> 
> Yes, that's certainly cleaner implementation-wise. But didn't you
> change it to only do the storage-part in the last round, or did I
> misunderstand the updated series?

Yeah, sorry, I'm getting ahead of myself. I left room in the spec for an
"ask" operation on helpers, but I haven't implemented it yet.

-Peff
