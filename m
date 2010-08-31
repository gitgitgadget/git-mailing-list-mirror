From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] tests: make test_must_fail fail on missing commands
Date: Tue, 31 Aug 2010 13:25:28 -0400
Message-ID: <20100831172528.GA15020@sigill.intra.peff.net>
References: <20100831155457.GB11014@sigill.intra.peff.net>
 <20100831155652.GB11530@sigill.intra.peff.net>
 <7v7hj6d8im.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jon Seymour <jon.seymour@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 19:25:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqUaN-000215-I1
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 19:25:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753129Ab0HaRZM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 13:25:12 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:43012 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750909Ab0HaRZM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 13:25:12 -0400
Received: (qmail 29183 invoked by uid 111); 31 Aug 2010 17:25:10 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 31 Aug 2010 17:25:10 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Aug 2010 13:25:28 -0400
Content-Disposition: inline
In-Reply-To: <7v7hj6d8im.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154945>

On Tue, Aug 31, 2010 at 09:58:09AM -0700, Junio C Hamano wrote:

> > +	elif test $exit_code = 127; then
> > +		echo >&2 "test_must_fail: command not found: $*"
> > +		return 1
> >  	fi
> 
> Hmm.  One worry is that if we ever exit(127) ourselves this would be
> confused, but hopefully we are not that clueless.

Yeah, I considered that but dismissed it. I don't think we are that
clueless, and even if we were, then I think test_must_fail is doing a
good thing by pointing it out to us.

-Peff
