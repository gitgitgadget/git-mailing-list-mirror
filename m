From: Jeff King <peff@peff.net>
Subject: Re: 1.7.7.3 wishlist: add --verbose option to git-tag
Date: Tue, 3 Jan 2012 14:39:53 -0500
Message-ID: <20120103193952.GF20926@sigill.intra.peff.net>
References: <87d3b51vr0.fsf@cante.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Tue Jan 03 20:40:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiADN-0007eS-KO
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 20:40:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189Ab2ACTj6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jan 2012 14:39:58 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55526
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754581Ab2ACTjz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jan 2012 14:39:55 -0500
Received: (qmail 9260 invoked by uid 107); 3 Jan 2012 19:46:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 03 Jan 2012 14:46:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Jan 2012 14:39:53 -0500
Content-Disposition: inline
In-Reply-To: <87d3b51vr0.fsf@cante.cante.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187879>

On Sat, Dec 31, 2011 at 01:32:19AM +0200, Jari Aalto wrote:

> In scripts it would be useful if "git tag" would provide option:
> 
>     --verbose
> 
> As in script:
> 
>     git tag --verbose -m "Initial import" upstream/1.0

What would the --verbose flag do?

> It would also help if all commands would use similar interface. In "git
> tag" case, this would meen relocating:
> 
>     -v      =>      -g, --verify-gpg
> 
> And reserve these:
> 
>     -v, --verbose

I agree it would be nicer. We would need to follow the usual deprecation
procedure of:

  1. introduce "-g", leave "-v" as a deprecated alias

  2. wait a long time

  3. drop "-v"

If you want to start a discussion, producing a patch for (1) is probably
the best way. If your plan is eventual consistency between options of
various commands, an even better start would be listing the existing
non-verbose uses of "-v" and making aliases for all of them.

-Peff
