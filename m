From: Jeff King <peff@peff.net>
Subject: Re: Understanding and improving --word-diff
Date: Tue, 9 Nov 2010 23:17:05 -0500
Message-ID: <20101110041705.GB8955@sigill.intra.peff.net>
References: <20101108151601.GF22067@login.drsnuggles.stderr.nl>
 <20101109220136.GA5617@sigill.intra.peff.net>
 <alpine.DEB.1.00.1011100102540.2226@bonsai2>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 10 05:17:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PG27V-0001rH-TU
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 05:17:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786Ab0KJERJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 23:17:09 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:41744 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751089Ab0KJERI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 23:17:08 -0500
Received: (qmail 13137 invoked by uid 111); 10 Nov 2010 04:17:07 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 10 Nov 2010 04:17:07 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Nov 2010 23:17:05 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1011100102540.2226@bonsai2>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161130>

On Wed, Nov 10, 2010 at 01:05:56AM +0100, Johannes Schindelin wrote:

> > Yeah, as you figured out, word diff is really about formats that aren't 
> > line oriented.
> 
> Not really correct. While the _current_ way to show word diffs is 
> imitating GNU wdiff, the internal data structure does allow for more 
> sophisticated output.

Fair enough. I was basing my statement on the output. If somebody would
like to demonstrate how the code can be used to get line-oriented diffs
with highlighting, I would be very happy to eat my words. :)

> P.S.: Peff, I hope you're fine with me responding to the first sentence 
> only. After all, you know that my attention span is 7.2 seconds.

Heh. I am happy you responded at all. You are very quiet these days. :)

-Peff
