From: Jeff King <peff@peff.net>
Subject: Re: how to make a commit only contain existing files
Date: Tue, 7 Dec 2010 22:39:10 -0500
Message-ID: <20101208033910.GA4065@sigill.intra.peff.net>
References: <alpine.DEB.2.00.1012071203190.662@asgard.lang.hm>
 <20101207211126.GA29453@sigill.intra.peff.net>
 <alpine.DEB.2.00.1012071652160.662@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Wed Dec 08 04:39:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQAsC-0008O2-SY
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 04:39:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754506Ab0LHDjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 22:39:15 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:56341 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754460Ab0LHDjO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 22:39:14 -0500
Received: (qmail 31250 invoked by uid 111); 8 Dec 2010 03:39:13 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 08 Dec 2010 03:39:13 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Dec 2010 22:39:10 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1012071652160.662@asgard.lang.hm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163165>

On Tue, Dec 07, 2010 at 04:52:48PM -0800, david@lang.hm wrote:

> >Won't "git add -A; git commit" do what you want?
> 
> it very well may, I'll have to upgrade git on that box to a version
> that supports it.

It was introduced in 1.6.0. If you have something older, "git add -u &&
git add ." will do the same thing.

-Peff
