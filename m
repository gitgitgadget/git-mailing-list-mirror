From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT] [PATCH RFC v1 0/5] Add (static) ignore functionality to
	EGit
Date: Sun, 29 Mar 2009 21:27:32 -0700
Message-ID: <20090330042732.GS23521@spearce.org>
References: <cover.1238102327.git.ferry.huberts@pelagic.nl> <200903291123.24433.robin.rosenberg@dewire.com> <49CF50CC.10400@pelagic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
X-From: git-owner@vger.kernel.org Mon Mar 30 06:29:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lo97R-00076r-UD
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 06:29:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbZC3E1e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 00:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbZC3E1e
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 00:27:34 -0400
Received: from george.spearce.org ([209.20.77.23]:36555 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbZC3E1e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 00:27:34 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 542A238211; Mon, 30 Mar 2009 04:27:32 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <49CF50CC.10400@pelagic.nl>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115061>

"Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl> wrote:
> Robin Rosenberg wrote:
> > A quick reply (I might come up with more later): Ignore support should be mostly
> > in jgit, with only extensions into egit.
> > 
> I discussed this with shawn and proposed to first implement it in egit
> and when we have it right then move it into jgit. I think shawn agreed
> with that.

I may have agreed with it.  My memory isn't *that* good.  :-)

In general principal I agree with Robin, Git specific handling
should be in JGit as much as possible so we can reuse the logic in
more applications than just EGit.

But it may have been easier to get a first working prototype by doing
the code in EGit, and later pulling some of it down into JGit as we
identity what isn't EGit specific.

The problem with that is the dual licenses; code in EGit can't
be pulled down to JGit without relicensing it under the BSD.
Only the original author of the code can do that.  So if you
contribute ignore support to EGit under the EPL which is better
placed in JGit, Robin or myself can't pull it down ourselves,
we'd have to rewrite it.

But even rewriting may be difficult, as the rewrite may be too close
to the original (same language, same surrounding code, likely going
to produce a similar result).

-- 
Shawn.
