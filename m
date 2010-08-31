From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] tests: make test_must_fail fail on missing commands
Date: Tue, 31 Aug 2010 14:08:48 -0400
Message-ID: <20100831180847.GC15020@sigill.intra.peff.net>
References: <20100831155457.GB11014@sigill.intra.peff.net>
 <20100831155652.GB11530@sigill.intra.peff.net>
 <20100831172657.GP2315@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jon Seymour <jon.seymour@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 20:08:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqVG7-0006zE-2b
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 20:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754580Ab0HaSIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 14:08:30 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:38898 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754569Ab0HaSIa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 14:08:30 -0400
Received: (qmail 29450 invoked by uid 111); 31 Aug 2010 18:08:29 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 31 Aug 2010 18:08:29 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Aug 2010 14:08:48 -0400
Content-Disposition: inline
In-Reply-To: <20100831172657.GP2315@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154951>

On Tue, Aug 31, 2010 at 12:26:57PM -0500, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > The point of it is to run a command that produces failure. A
> > missing command is more likely an error in the test script
> 
> Makes sense.  Here's the corresponding change for test_might_fail.

I think this is probably worth doing. Unless somebody is doing something
silly like:

  test_might_fail command_that_might_exist

But that seems a pretty contrived scenario (I am imagining something
like "call sync now, but if we don't have it, don't fail". But in the
test scripts that seems unlikely).

-Peff
