From: Jeff King <peff@peff.net>
Subject: Re: [RFC] branch: list branches by single remote
Date: Tue, 16 Aug 2011 08:14:50 -0700
Message-ID: <20110816151448.GA5152@sigill.intra.peff.net>
References: <4E383132.3040907@elegosoft.com>
 <20110804040646.GA5104@sigill.intra.peff.net>
 <4E4A729D.9030906@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Schubert <mschub@elegosoft.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Aug 16 17:15:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtLM4-0005vV-T5
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 17:15:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687Ab1HPPO4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Aug 2011 11:14:56 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49300
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751621Ab1HPPOz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 11:14:55 -0400
Received: (qmail 3263 invoked by uid 107); 16 Aug 2011 15:15:34 -0000
Received: from me42036d0.tmodns.net (HELO sigill.intra.peff.net) (208.54.32.228)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 16 Aug 2011 11:15:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Aug 2011 08:14:50 -0700
Content-Disposition: inline
In-Reply-To: <4E4A729D.9030906@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179455>

On Tue, Aug 16, 2011 at 03:37:33PM +0200, Michael J Gruber wrote:

> > This isn't right. You are assuming that a remote called "foo" will have
> > all of its branches in refs/remotes/foo. That's true under the default
> > configuration, but technically speaking, the remote tracking branches of
> > "foo" are defined by the right-hand side of foo's fetch refspecs.
> 
> You are 100% right here, but...
> 
> > So I think you want something more like this:
> 
> ...the op still might want to filter simply by the remote name.

That is a perfectly reasonable approach. It just should be called
"--glob" or something, and not "remote".  git-tag allows patterns to an
explicit "tag -l", but "-l" is already taken for git-branch.

> Reminds me that I have to resurrect my patterns-with-branches series....

Please do. I think it's a much simpler and more versatile solution to
the same problem.

-Peff
