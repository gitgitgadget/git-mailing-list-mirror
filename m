From: Jeff King <peff@peff.net>
Subject: Re: More git status --porcelain lossage
Date: Sat, 10 Apr 2010 00:14:42 -0400
Message-ID: <20100410041442.GC11977@coredump.intra.peff.net>
References: <20100409190601.47B37475FEF@snark.thyrsus.com>
 <20100410041247.GB11977@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Eric Raymond <esr@snark.thyrsus.com>
X-From: git-owner@vger.kernel.org Sat Apr 10 06:15:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0S6C-0008IM-2i
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 06:15:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841Ab0DJEPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 00:15:07 -0400
Received: from peff.net ([208.65.91.99]:46242 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750719Ab0DJEPG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 00:15:06 -0400
Received: (qmail 13329 invoked by uid 107); 10 Apr 2010 04:15:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 10 Apr 2010 00:15:06 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Apr 2010 00:14:42 -0400
Content-Disposition: inline
In-Reply-To: <20100410041247.GB11977@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144500>

On Sat, Apr 10, 2010 at 12:12:48AM -0400, Jeff King wrote:

> > Conclusion: As it is presently, git status --porcelain format is
> > irretrievably botched.  You need a field separator that's musch less
> > likely to land in a filename, like '|' - and to warn in the documentation
> > that careful front ends must check for and ignore '\|'.
> 
> We already quote correctly, so it is only sloppy parsers that will be in
> trouble. Yes, space is more common than "|", but sloppy is sloppy. Parse
> it right, or use "-z".

BTW, this should go on your "git status --porcelain documentation
failures" list. We really need to note that the output paths may be
quoted.

-Peff
