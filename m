From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 06/13] credential: apply helper config
Date: Tue, 6 Dec 2011 19:45:11 -0500
Message-ID: <20111207004511.GA28370@sigill.intra.peff.net>
References: <20111206062127.GA29046@sigill.intra.peff.net>
 <20111206062247.GF29233@sigill.intra.peff.net>
 <7vsjkxckwk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 01:45:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RY5dR-0002Ad-Dv
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 01:45:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755198Ab1LGApO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 19:45:14 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41576
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755119Ab1LGApN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 19:45:13 -0500
Received: (qmail 10252 invoked by uid 107); 7 Dec 2011 00:51:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 06 Dec 2011 19:51:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Dec 2011 19:45:11 -0500
Content-Disposition: inline
In-Reply-To: <7vsjkxckwk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186409>

On Tue, Dec 06, 2011 at 03:58:35PM -0800, Junio C Hamano wrote:

> > +test_expect_success 'respect configured credentials' '
> > +	test_config credential.helper "$HELPER" &&
> > +	check fill <<-\EOF
> > +	--
> > +	username=foo
> > +	password=bar
> > +	--
> > +	EOF
> > +'
> 
> Hmm, why do I get ask-ass-{username,password} from this one?

Ugh. Because apparently one of my re-roll tweaks from patch 03 regressed
this. Sorry, I should have been more careful about running the full
suite, not just the tests in the commits I tweaked.

Let me investigate and get back to you.

-Peff
