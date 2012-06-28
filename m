From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] Allow help.htmlpath to be an http: URL
Date: Thu, 28 Jun 2012 13:50:41 -0400
Message-ID: <20120628175041.GA4731@sigill.intra.peff.net>
References: <7vwr2s5f9v.fsf@alter.siamese.dyndns.org>
 <20120627225248.GB27566@sigill.intra.peff.net>
 <20120628065623.GB1742@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Chris Webb <chris@arachsys.com>
X-From: git-owner@vger.kernel.org Thu Jun 28 19:50:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SkIrl-0004K8-Ap
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jun 2012 19:50:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755438Ab2F1Rut (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jun 2012 13:50:49 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:48043
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754878Ab2F1Rus (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2012 13:50:48 -0400
Received: (qmail 1737 invoked by uid 107); 28 Jun 2012 17:50:51 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 28 Jun 2012 13:50:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Jun 2012 13:50:41 -0400
Content-Disposition: inline
In-Reply-To: <20120628065623.GB1742@arachsys.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200790>

On Thu, Jun 28, 2012 at 07:56:23AM +0100, Chris Webb wrote:

> > This, and "://", both sound sensible.
> 
> I have no real preference between any of the suggestions so far: they'd all
> be completely fine with me. Peff's :// test for a URL is much better than my
> http: prefix, so should replace the latter if we need a test at all, but
> apart from that I don't mind at all.
> 
> Okay, I'll re-send now the :// version I did in response to Peff's first
> email purely on the basis that it doesn't change the behaviour at all for
> existing users who don't set htmlpath at all, plus it's already sat in my
> reflog!

I think the "://" one is my preference. I just looked over your v3
series, and the patches look good to me.

-Peff
