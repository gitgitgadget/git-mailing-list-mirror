From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] git tag --contains : avoid stack overflow
Date: Wed, 23 Apr 2014 15:17:50 -0400
Message-ID: <20140423191749.GB20596@sigill.intra.peff.net>
References: <20140416141519.GA9684@camelia.ucw.cz>
 <20140416154653.GB4691@sigill.intra.peff.net>
 <alpine.DEB.1.00.1404171902010.14982@s15462909.onlinehome-server.info>
 <20140417213238.GA14792@sigill.intra.peff.net>
 <alpine.DEB.1.00.1404172347440.14982@s15462909.onlinehome-server.info>
 <20140417215817.GA822@sigill.intra.peff.net>
 <20140423075325.GA7268@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org,
	Jean-Jacques Lafay <jeanjacques.lafay@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 21:17:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd2g8-0000L9-LZ
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 21:17:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756818AbaDWTRw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 15:17:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:36965 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753943AbaDWTRv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 15:17:51 -0400
Received: (qmail 24934 invoked by uid 102); 23 Apr 2014 19:17:51 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 23 Apr 2014 14:17:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Apr 2014 15:17:50 -0400
Content-Disposition: inline
In-Reply-To: <20140423075325.GA7268@camelia.ucw.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246869>

On Wed, Apr 23, 2014 at 09:53:25AM +0200, Stepan Kasal wrote:

> I have found out that "ulimit -s" does not work on Windows.
> Adding this as a prerequisite, we will skip the test there.

I found this bit weird, as the test originated on Windows. Did it never
actually cause a failure there (i.e., the "ulimit -s" doesn't do
anything)? Or does "ulimit" fail?

-Peff
