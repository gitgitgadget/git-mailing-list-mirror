From: Yann Dirson <ydirson@altern.org>
Subject: Re: [PATCH] add --remote option to git-clone.
Date: Fri, 2 Feb 2007 00:42:46 +0100
Message-ID: <20070201234246.GD5362@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070201220122.GF17617@mellanox.co.il> <20070201220657.GB19271@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Fri Feb 02 00:43:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HClag-0007a4-Eq
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 00:43:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422917AbXBAXnj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 18:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422919AbXBAXnj
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 18:43:39 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:41167 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422917AbXBAXni (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 18:43:38 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 59A9E9B78D;
	Fri,  2 Feb 2007 00:43:36 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id A27B71F080; Fri,  2 Feb 2007 00:42:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20070201220657.GB19271@fieldses.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38431>

On Thu, Feb 01, 2007 at 05:06:57PM -0500, J. Bruce Fields wrote:
> On Fri, Feb 02, 2007 at 12:01:22AM +0200, Michael S. Tsirkin wrote:
> > I'm often annoyed by the fact that when I clone from this repository,
> > I get a copy of all topic branches and origin tracking master
> > by default, when I actually might only want to work on a different
> > topic. And getting all extra branches is annoying on a slow connection.
> 
> Can you quantify "annoying"?
> 
> Not a challenge, I'm just curious--I would've thought that, for most
> projects, even with long-lived topic branches, it wouldn't be that
> expensive to get a second branch once you'd gotten one.

Regardless of the extra branches, it is also annoying to have the
master branch in the clone branched off the HEAD of the parent repo.
Especially when you intend to fork an stgit stack off the non-HEAD
branch - it will be a pleasure to make "stg clone" to take advantage
of this new feature :)

This is also a feature which is available in cogito since ages
(cg-clone URL#branch), and not having it in plain git is an annoyance.

Best regards,
-- 
Yann.
