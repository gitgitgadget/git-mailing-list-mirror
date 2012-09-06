From: Jeff King <peff@peff.net>
Subject: Re: git blame --follow
Date: Thu, 6 Sep 2012 11:13:17 -0400
Message-ID: <20120906151317.GB7407@sigill.intra.peff.net>
References: <k29hpo$3av$1@ger.gmane.org>
 <20120906095804.GA15277@sigill.intra.peff.net>
 <k29sup$2e0$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "norbert.nemec" <norbert.nemec@native-instruments.de>
X-From: git-owner@vger.kernel.org Thu Sep 06 17:13:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9dly-0003IP-5f
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 17:13:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756844Ab2IFPNa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 11:13:30 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:59878 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756817Ab2IFPNT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2012 11:13:19 -0400
Received: (qmail 22119 invoked by uid 107); 6 Sep 2012 15:13:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 06 Sep 2012 11:13:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Sep 2012 11:13:17 -0400
Content-Disposition: inline
In-Reply-To: <k29sup$2e0$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204896>

On Thu, Sep 06, 2012 at 12:12:42PM +0200, norbert.nemec wrote:

> The option should either be rejected or do *something* documented and
> useful. Ideally, it should result in behavior that matches 'git log
> --follow' as closely as possible. So maybe, it should be a synonym
> for a certain number of "-C" options?

But I don't see how it would match "git log --follow", as that is a
fundamentally different operation that makes no sense in the context of
blame (why would you be adjusting the pathspec? There is no pathspec). A
synonym for "-C" would just confuse things more, as log also has "-C"
and it is not a synonym there.

So if anything, I'd say to simply reject it. It's not documented, and it
never did anything useful. Patches welcome.

-Peff
