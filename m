From: Jeff King <peff@peff.net>
Subject: Re: Doesn't disambiguate between 'external command failed' and
 'command not found'
Date: Wed, 6 Jul 2011 13:58:03 -0400
Message-ID: <20110706175803.GB17978@sigill.intra.peff.net>
References: <1309884564.18513.12.camel@umgah>
 <4E137701.1020007@elegosoft.com>
 <20110705231604.GC12085@sigill.intra.peff.net>
 <4E144B55.8020907@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Alex Vandiver <alex@chmrr.net>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 19:58:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeWMf-00016i-2q
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 19:58:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754710Ab1GFR6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 13:58:06 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60901
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754670Ab1GFR6F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 13:58:05 -0400
Received: (qmail 23157 invoked by uid 107); 6 Jul 2011 17:58:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Jul 2011 13:58:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Jul 2011 13:58:03 -0400
Content-Disposition: inline
In-Reply-To: <4E144B55.8020907@elegosoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176718>

On Wed, Jul 06, 2011 at 01:47:33PM +0200, Michael Schubert wrote:

> Like this? I've replaced "Check the #!-line of the git-%s script." with
> "Maybe git-%s is broken?" to be less technical and specific..

Yeah, looks good to me (unless somebody wants to do something more
elaborate to catch other exec problems, but I personally don't think
it's worth the effort).

-Peff
