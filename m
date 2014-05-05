From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/5] contrib/subtree/Makefile: Standardisation pass
Date: Mon, 5 May 2014 01:08:04 -0400
Message-ID: <20140505050803.GA6569@sigill.intra.peff.net>
References: <1399121375-14727-1-git-send-email-nod.helm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, greend@obbligato.org, apenwarr@gmail.com,
	gpmcgee@gmail.com, mmogilvi_git@miniinfo.net
To: James Denholm <nod.helm@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 06 18:18:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whhsr-0005Yp-11
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:06:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754406AbaEEFII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 01:08:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:45063 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754255AbaEEFIH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 01:08:07 -0400
Received: (qmail 19575 invoked by uid 102); 5 May 2014 05:08:07 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 05 May 2014 00:08:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 May 2014 01:08:04 -0400
Content-Disposition: inline
In-Reply-To: <1399121375-14727-1-git-send-email-nod.helm@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248126>

On Sat, May 03, 2014 at 10:49:30PM +1000, James Denholm wrote:

> The main issues are that calls are made to git itself in the build
> process, and that a subtree-exclusive variable is used for specifying
> the exec path. Patches 1/5 through 3/5 resolve these.
> 
> The "cleanup" fixes (4/5 and 5/5) are based on precedents set by other
> makefiles across the project.

Thanks, these all look sane to me (I do not use subtree, but since it's
just about Makefiles, it was pretty easy to review).

> One problem is foreseen: 3/5 will necessitate that package maintainers
> who already have git-subtree included in their packages update their
> build-scripts.

I think that's probably OK. We strive for backwards compatibility in the
tool itself, but refactoring Makefiles in contrib/ affects a pretty
limited audience.

-Peff
