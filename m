From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/3] tests: Prepare --textconv tests for
 correctly-failing conversion program
Date: Tue, 28 Sep 2010 10:39:28 -0400
Message-ID: <20100928143928.GA8918@sigill.intra.peff.net>
References: <cover.1285351816.git.kirr@landau.phys.spbu.ru>
 <66d4603c7e21561557f612690d6196e7ae0b38f9.1285351816.git.kirr@landau.phys.spbu.ru>
 <7vsk0vyriw.fsf@alter.siamese.dyndns.org>
 <20100928120722.GA29525@landau.phys.spbu.ru>
 <20100928132356.GA5829@sigill.intra.peff.net>
 <20100928143540.GA30357@landau.phys.spbu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	Cl??ment Poulain <clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Kirill Smelkov <kirr@landau.phys.spbu.ru>
X-From: git-owner@vger.kernel.org Tue Sep 28 16:39:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0bLG-000213-0U
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 16:39:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755505Ab0I1Ojc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 10:39:32 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:45939 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752006Ab0I1Ojb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 10:39:31 -0400
Received: (qmail 29516 invoked by uid 111); 28 Sep 2010 14:39:31 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 28 Sep 2010 14:39:31 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Sep 2010 10:39:28 -0400
Content-Disposition: inline
In-Reply-To: <20100928143540.GA30357@landau.phys.spbu.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157427>

On Tue, Sep 28, 2010 at 06:35:40PM +0400, Kirill Smelkov wrote:

> > >  t/t4042-diff-textconv-caching.sh |    4 ++--
> > 
> > Why are we touching t4042 at all in this series? We are not actually
> > adding any tests to it, AFAICT.
> 
> Because we want to catch potential wrong textconv invocation on non
> "bin: " files there too?

But we don't actually add any tests that display the problem there, do
we? And even if we wanted to test the diff implementation, wouldn't
t4030 be the write place to do that? t4042 is specifically about
textconv caching.

-Peff
