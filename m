From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] checkout --detached test: write supporting files
 before start of tests
Date: Fri, 13 Apr 2012 22:26:04 -0400
Message-ID: <20120414022604.GB17535@sigill.intra.peff.net>
References: <20110320090111.GA15641@sigill.intra.peff.net>
 <20110320090918.GB15948@sigill.intra.peff.net>
 <20120413225901.GA13220@burratino>
 <20120413232535.GB13995@burratino>
 <20120413233346.GB16663@sigill.intra.peff.net>
 <20120413234949.GF13995@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 14 04:26:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIsgm-0007QE-ND
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 04:26:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753449Ab2DNC0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Apr 2012 22:26:08 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33671
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753288Ab2DNC0G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2012 22:26:06 -0400
Received: (qmail 16027 invoked by uid 107); 14 Apr 2012 02:26:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 13 Apr 2012 22:26:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Apr 2012 22:26:04 -0400
Content-Disposition: inline
In-Reply-To: <20120413234949.GF13995@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195464>

On Fri, Apr 13, 2012 at 06:49:49PM -0500, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> >                                                If anything, should this
> > not be moving the cat inside the test_expect_success?
> 
> That would be fine with me.  It would involve changing the ' around
> "master" to '\'' and would mean that if some later patch wants to use
> the same message, the author will have to remember to factor it out.

Ah, yeah, that is probably why I left it outside the test in the first
place.

> On the other hand, nothing about the message is specific to that test
> assertion, so I am ok with the patch I sent, too.

I don't care much either way. I just know that there are a million other
places that set up "expect" right before the test, so it seems like a
common exception to our rule.

-Peff
