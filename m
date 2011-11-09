From: Jeff King <peff@peff.net>
Subject: Re: git log --quiet bug?
Date: Tue, 8 Nov 2011 19:59:27 -0500
Message-ID: <20111109005927.GA25876@sigill.intra.peff.net>
References: <1320762978.3614.YahooMailNeo@web84005.mail.mud.yahoo.com>
 <20111108212930.GA18529@sigill.intra.peff.net>
 <1320791465.67359.YahooMailNeo@web84006.mail.mud.yahoo.com>
 <20111108232043.GA21957@sigill.intra.peff.net>
 <7vy5vqw47x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Prasad Deshpande <prasadgdeshpande@yahoo.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 09 01:59:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNwVr-0002yg-JV
	for gcvg-git-2@lo.gmane.org; Wed, 09 Nov 2011 01:59:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756540Ab1KIA7a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Nov 2011 19:59:30 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37215
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756061Ab1KIA7a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 19:59:30 -0500
Received: (qmail 9902 invoked by uid 107); 9 Nov 2011 00:59:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 08 Nov 2011 19:59:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Nov 2011 19:59:27 -0500
Content-Disposition: inline
In-Reply-To: <7vy5vqw47x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185123>

On Tue, Nov 08, 2011 at 04:04:50PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Try:
> >
> >   test -z "$(git rev-list -1 origin..HEAD)" &&
> >   echo nothing that needs pushing
> >
> > You can also use --count to get the exact number, but if you just care
> > whether there is something or nothing, using "-1" lets git stop the
> > graph traversal immediately.
> 
> Doesn't some variant of "branch -v" show the ahead/behind information for
> all branches?

Yeah, but I thought the question was how to figure this out
programatically in a script.

-Peff
