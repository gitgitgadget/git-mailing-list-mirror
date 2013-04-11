From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] http-backend documentation examples
Date: Wed, 10 Apr 2013 23:30:22 -0400
Message-ID: <20130411033022.GA14462@sigill.intra.peff.net>
References: <20130409054553.GA1537@mteis.lan>
 <20130409171247.GD21972@sigill.intra.peff.net>
 <5165DA13.8010100@gmail.com>
 <20130410214722.GA6215@sigill.intra.peff.net>
 <20130410231919.GA1315@mteis.lan>
 <20130411015613.GA8455@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	git@vger.kernel.org
To: Magnus Therning <magnus@therning.org>
X-From: git-owner@vger.kernel.org Thu Apr 11 05:30:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ8Da-0005Vc-6k
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 05:30:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935759Ab3DKDaa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 23:30:30 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39623 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759172Ab3DKDa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 23:30:29 -0400
Received: (qmail 11168 invoked by uid 107); 11 Apr 2013 03:32:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 10 Apr 2013 23:32:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Apr 2013 23:30:22 -0400
Content-Disposition: inline
In-Reply-To: <20130411015613.GA8455@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220809>

On Wed, Apr 10, 2013 at 09:56:13PM -0400, Jeff King wrote:

> The documentation should probably make the use of http.receivepack more
> clear in this situation.

Here's a patch series to do that. The first one would (hopefully) have
helped you arrive at the http.receivepack fix, as well as any other
people configuring Apache. The second one actually adds some basic
lighttpd config, including the query-string match, which is a better
solution anyway.

  [1/2]: doc/http-backend: clarify "half-auth" repo configuration
  [2/2]: doc/http-backend: give some lighttpd config examples

-Peff
