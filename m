From: Larry D'Anna <larry@elder-gods.org>
Subject: Re: [PATCH] fix an error message in git-push so it goes to stderr
Date: Fri, 5 Feb 2010 14:50:04 -0500
Message-ID: <20100205195004.GA21772@cthulhu>
References: <20100205004140.GA2841@cthulhu>
 <20100205150638.GB14116@coredump.intra.peff.net>
 <20100205193950.GA18108@cthulhu>
 <20100205194824.GD24474@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <jrk@wrek.org>
X-From: git-owner@vger.kernel.org Fri Feb 05 20:50:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdUBz-0000Hc-6R
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 20:50:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755804Ab0BETuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 14:50:07 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:56899 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755787Ab0BETuG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 14:50:06 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id AACEE82217D; Fri,  5 Feb 2010 14:50:04 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20100205194824.GD24474@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139071>

* Jeff King (jrk@wrek.org) [100205 14:48]:
> On Fri, Feb 05, 2010 at 02:39:50PM -0500, Larry D'Anna wrote:
> 
> > Also it seems to me that git push --dry-run --porcelain should exit successfully
> > even if it knows some refs will be rejected.  The calling script can see just
> > fine for itself that they will be rejected, and it probably still wants to know
> > whether or not the dry-run succeeded, which has nothing to do with whether or
> > not the same push would succeed as a not-dry-run.
> 
> I think that is OK, but only if "git push --dry-run" still exits with an
> error case, since people may be using it for "will this push work?" and
> not simply "did an error occur?".

Yup.  That's exactly what the patch I just posted does.

      --larry
