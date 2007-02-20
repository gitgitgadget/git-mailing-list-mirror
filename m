From: Yann Dirson <ydirson@altern.org>
Subject: Re: StGIT discards local commits on "stg pull"
Date: Tue, 20 Feb 2007 01:00:59 +0100
Message-ID: <20070220000059.GK4248@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070212022625.rvyyo0kc0wowgogc@webmail.spamcop.net> <b0943d9e0702120131r528fb29ete143b8ce5a0a99e9@mail.gmail.com> <20070212202634.GX4266@nan92-1-81-57-214-146.fbx.proxad.net> <20070212214704.GS5362@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0702191507m636348e7yab2a712925f9f55@mail.gmail.com> <1171927720.2257.41.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
X-From: git-owner@vger.kernel.org Tue Feb 20 01:49:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJJC1-0007vO-K9
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 01:49:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965804AbXBTAtG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 19:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965805AbXBTAtG
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 19:49:06 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:40004 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965804AbXBTAtE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 19:49:04 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 1388455312;
	Tue, 20 Feb 2007 01:02:11 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 95D681F087; Tue, 20 Feb 2007 01:00:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1171927720.2257.41.camel@dv>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40179>

On Mon, Feb 19, 2007 at 06:28:40PM -0500, Pavel Roskin wrote:
> > I think the fail-safe solution would be to leave the old behaviour
> > (i.e. git-pull and pull-does-rebase=no) and people that need to pull
> > from branches like that described above would use the fetch+rebase
> > approach. Ideally, we'll have this configurable per-branch (and could
> > leave the global one as well if the most specific is not available,
> > but should default to git-pull).
> 
> By the way, it would be great to reduce all complexity to "one bit" per
> branch.  If stgit.internal-pull (the name is subject to improvement) is
> on, "stgit pull" calls git-fetch and does rebase.  Otherwise, it calls
> git-pull.  No need to configure two variables per branch.

Being able to specify the command to use makes it possible to hook to
other SCM's (eg. using git-cvsimport, git-svn or similar).

I'll try to adapt by stg-cvs script to fit into this model some day
(indeed, "pullcmd = stg-cvs fetch" may indeed already work).

Best regards,
-- 
Yann.
