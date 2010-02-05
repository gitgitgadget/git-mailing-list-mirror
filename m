From: Jeff King <jrk@wrek.org>
Subject: Re: [PATCH] fix an error message in git-push so it goes to stderr
Date: Fri, 5 Feb 2010 14:48:24 -0500
Message-ID: <20100205194824.GD24474@coredump.intra.peff.net>
References: <20100205004140.GA2841@cthulhu>
 <20100205150638.GB14116@coredump.intra.peff.net>
 <20100205193950.GA18108@cthulhu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Larry D'Anna <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Fri Feb 05 20:55:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdUGm-00041j-PE
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 20:55:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933728Ab0BETzG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 14:55:06 -0500
Received: from peff.net ([208.65.91.99]:57093 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932429Ab0BETzF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 14:55:05 -0500
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Feb 2010 14:55:04 EST
Received: (qmail 27576 invoked by uid 107); 5 Feb 2010 19:48:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 05 Feb 2010 14:48:28 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Feb 2010 14:48:24 -0500
Content-Disposition: inline
In-Reply-To: <20100205193950.GA18108@cthulhu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139073>

On Fri, Feb 05, 2010 at 02:39:50PM -0500, Larry D'Anna wrote:

> Also it seems to me that git push --dry-run --porcelain should exit successfully
> even if it knows some refs will be rejected.  The calling script can see just
> fine for itself that they will be rejected, and it probably still wants to know
> whether or not the dry-run succeeded, which has nothing to do with whether or
> not the same push would succeed as a not-dry-run.

I think that is OK, but only if "git push --dry-run" still exits with an
error case, since people may be using it for "will this push work?" and
not simply "did an error occur?".

-Peff
