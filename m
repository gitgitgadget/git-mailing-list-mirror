From: Jeff King <peff@peff.net>
Subject: Re: Does it make sense to pull from mirror? (Re: [BUG?] push to
 mirrior interferes with parallel operations)
Date: Thu, 18 Nov 2010 14:05:44 -0500
Message-ID: <20101118190544.GB30438@sigill.intra.peff.net>
References: <e355bb33c6192a6a29de56c7be93278e.squirrel@artax.karlin.mff.cuni.cz>
 <20101118175007.GA26505@sigill.intra.peff.net>
 <20101118175810.GB26505@sigill.intra.peff.net>
 <20101118184904.GO3693@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Thu Nov 18 20:05:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJ9nu-0003qM-Vs
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 20:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756472Ab0KRTFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 14:05:50 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:54806 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756029Ab0KRTFu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 14:05:50 -0500
Received: (qmail 18242 invoked by uid 111); 18 Nov 2010 19:05:49 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 18 Nov 2010 19:05:49 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Nov 2010 14:05:44 -0500
Content-Disposition: inline
In-Reply-To: <20101118184904.GO3693@efreet.light.src>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161707>

On Thu, Nov 18, 2010 at 07:49:04PM +0100, Jan Hudec wrote:

> > So I think we need --mirror=push, or something similar.
> 
> Does it *ever* make sense to have a non-bare pull mirror. I think it does
> not.

I don't think so. But it may make sense to have a bare push mirror, as I
mention in my other email. So we may still want to make it easy for the
user to specify.

-Peff
