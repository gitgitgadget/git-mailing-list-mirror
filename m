From: Jeff King <peff@peff.net>
Subject: Re: Why doesn't git commit -a track new files
Date: Thu, 24 Feb 2011 11:00:27 -0500
Message-ID: <20110224160027.GA30275@sigill.intra.peff.net>
References: <20110224112246.3f811ac2@glyph>
 <4D6672F7.4020101@drmicha.warpmail.net>
 <20110224154908.GA29309@sigill.intra.peff.net>
 <4D667F1A.5060408@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Marco <netuse@lavabit.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Feb 24 17:00:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsdcH-0005zO-8Z
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 17:00:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755625Ab1BXQA2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 11:00:28 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:46755 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754769Ab1BXQA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 11:00:28 -0500
Received: (qmail 25338 invoked by uid 111); 24 Feb 2011 16:00:27 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 24 Feb 2011 16:00:27 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Feb 2011 11:00:27 -0500
Content-Disposition: inline
In-Reply-To: <4D667F1A.5060408@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167827>

On Thu, Feb 24, 2011 at 04:54:02PM +0100, Michael J Gruber wrote:

> > But as you mentioned, it is sadly not as trivial as just adding a new
> > way to call "git add". So I think nobody has simply cared enough to
> > implement it to date.
> 
> How about this program:
> 
> - refactor add, commit to share the "add parts"

Sounds good.

> - homogenize interface: replace "add -u" by "add -a" (hidden
> compatibility thingy of course)

I like it.

> - hom. interface: allow "-a pathspec" for commit

What would it do? It would just behave like "git commit -i pathspec"?

> - have commit -A

Sounds good.

> Oh, and do "commit -n" what one would expect [1.8.0] :)

Yeah, I like that, too.

Are you volunteering to work on it all? :)

-Peff
