From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/8] t1300: style updates
Date: Wed, 24 Oct 2012 02:37:12 -0400
Message-ID: <20121024063712.GA17789@sigill.intra.peff.net>
References: <20121023223502.GA23194@sigill.intra.peff.net>
 <20121023223554.GA17392@sigill.intra.peff.net>
 <50878BAB.60809@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Oct 24 08:37:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQuap-0003nR-8o
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 08:37:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933506Ab2JXGhR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2012 02:37:17 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53682 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933348Ab2JXGhQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2012 02:37:16 -0400
Received: (qmail 26889 invoked by uid 107); 24 Oct 2012 06:37:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 24 Oct 2012 02:37:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Oct 2012 02:37:12 -0400
Content-Disposition: inline
In-Reply-To: <50878BAB.60809@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208290>

On Wed, Oct 24, 2012 at 08:33:15AM +0200, Johannes Sixt wrote:

> Am 10/24/2012 0:35, schrieb Jeff King:
> > -test_expect_success 'non-match value' \
> > -	'test wow = $(git config --get nextsection.nonewline !for)'
> > +test_expect_success 'non-match value' '
> > +	test wow = $(git config --get nextsection.nonewline !for)
> > +'
> 
> Here's a case you forgot to update to test_cmp.

Thanks. I noticed I left quite a few of those in (the other changes I
did mechanically, but I only fixed up the "test" ones in nearby spots).

> > +test_expect_success 'get-regexp variable with no value' '
> > +	git config --get-regexp novalue > output &&
> > +	 test_cmp expect output'
> 
> And while you are here, you might want to remove this extra space. ;)
> 
> Otherwise, looks fine.

Thanks, I'll fix up both.

-Peff
