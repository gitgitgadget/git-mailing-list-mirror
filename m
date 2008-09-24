From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC/PATCH] remove vim syntax highlighting in favor of upstream
Date: Wed, 24 Sep 2008 11:07:42 -0700
Message-ID: <20080924180742.GB3669@spearce.org>
References: <1222269726-15632-1-git-send-email-szeder@ira.uka.de> <20080924155745.GA3908@coredump.intra.peff.net> <20080924170154.GA6816@neumann> <20080924175315.GA10337@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: SZEDER GGGbor <szeder@ira.uka.de>, vim@tpope.info,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 24 20:09:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiYnG-0001Lj-Di
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 20:08:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752260AbYIXSHn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 14:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751995AbYIXSHn
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 14:07:43 -0400
Received: from george.spearce.org ([209.20.77.23]:41398 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878AbYIXSHn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 14:07:43 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 974B038360; Wed, 24 Sep 2008 18:07:42 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080924175315.GA10337@coredump.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96675>

Jeff King <peff@peff.net> wrote:
> [Shawn cc'd as the interim maintainer. I, for one, welcome our
> new Java-programming overlords].

Heh.
 
> Here is a patch, then. Shawn, we should probably give any vim users a
> few days to object in case there is something they don't like about the
> upstream version, but other than that, I think this should be applied to
> master.

Thanks.  Its queued in my pile of patches waiting for ACKs and/or
comments before I actually apply them to my tree.  I'll let it sit
for a little, but I think we want to apply it.

> -- >8 --
> remove vim syntax highlighting in favor of upstream
> 
> As of version 7.2, vim ships with its own syntax
> highlighting for git commit messages, which is:
> 
>   1. more comprehensive in splitting up the various
>      components of the file
> 
>   2. in accordance with the usual vim behavior for syntax
>      highlighting (e.g., respecting b:current_syntax)
> 
>   3. presumably better maintained (I have not been using
>      what's in git's contrib/ directory for some time in
>      favor of the upstream version)
> 
> This patch gets rid of our local version and just points
> interested parties to the upstream version.

-- 
Shawn.
