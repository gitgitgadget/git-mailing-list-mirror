From: Yann Dirson <ydirson@altern.org>
Subject: Re: [RFC] git integrated bugtracking
Date: Sun, 3 Jun 2007 22:04:31 +0200
Message-ID: <20070603200431.GF6992@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070603114843.GA14336@artemis> <878xb19ot5.fsf@graviton.dyn.troilus.org> <20070603133109.GD14336@artemis> <200706031548.30111.johan@herland.net> <20070603151921.GB30347@artemis>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	Catalin Marinas <catalin.marinas@gmail.com>
To: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Poole <mdpoole@troilus.org>
X-From: git-owner@vger.kernel.org Sun Jun 03 22:04:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuwJc-0001hF-Q0
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 22:04:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbXFCUEd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 16:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbXFCUEd
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 16:04:33 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:57552 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750838AbXFCUEc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 16:04:32 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 89E0B5A166;
	Sun,  3 Jun 2007 22:04:30 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 51F791F01B; Sun,  3 Jun 2007 22:04:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070603151921.GB30347@artemis>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49027>

One thing that I just thought about is how such a system would play
with eg. StGIT.

Precisely, if I stick a BTS note (found/not-found probably makes no
sense here, so that'd mostly be fixes/enhances notes) to a given
version of an StGIT patch, I probably want the BTS to be able to tell
that the next version of the patch "probably has" the same note - if a
given patch fixes a given bug, I infer the patch is primarily written
as a fix for that bug, so later revisions of the patch (eg. cleanups)
would also fix it.  But maybe we'd want the patch author to
explicitely make such an assertion, in case a cleanup would have
broken the fix - both options could be useful in different cases.

Currently, old versions of an StGIT patch are only available through
StGIT patchlogs, which are not ancestors of later versions of the same
patch.  That is, even the "subsequent versions inherit notes" policy
would need extra StGIT-aware stuff to work.

This may be something to keep in mind here - but that issue could also
be seen as belonging to the more general (and with ongoing work)
aspect of git/StGIT interactions.  Even better if the 2 ongoing
reflexions cross-fertilisate :)

Best regards,
-- 
Yann.
