From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Contents of file for a commit
Date: Sun, 27 Jan 2008 00:01:28 -0500
Message-ID: <20080127050127.GT24004@spearce.org>
References: <18332.1826.220373.129812@lisa.zopyra.com> <20080127044027.GS24004@spearce.org> <20080127044944.GA25247@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 27 06:02:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIzep-00039F-U2
	for gcvg-git-2@gmane.org; Sun, 27 Jan 2008 06:02:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbYA0FBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2008 00:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbYA0FBd
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jan 2008 00:01:33 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:49866 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718AbYA0FBc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2008 00:01:32 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JIzeE-000816-Mk; Sun, 27 Jan 2008 00:01:38 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8387B20FBAE; Sun, 27 Jan 2008 00:01:28 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20080127044944.GA25247@coredump.intra.peff.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71805>

Jeff King <peff@peff.net> wrote:
> On Sat, Jan 26, 2008 at 11:40:27PM -0500, Shawn O. Pearce wrote:
> 
> > You can also just view the file if you don't want those changes
> > to be made:
> > 
> > `git show $commit -- $path`
> 
> That doesn't work. It says "show me $commit, but limited by $path". So
> if $path was changed, you see the commit log and diff. If it wasn't, you
> see nothing.

Gah.  Indeed.  I should have suggested to Bill:

`git show $commit:$path`

sorry about the confusion, and thanks for the clarification.  :-)

-- 
Shawn.
