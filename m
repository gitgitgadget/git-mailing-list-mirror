From: Yann Dirson <ydirson@altern.org>
Subject: Re: [PATCH] CVSps fixed; git-cvsimport works, too
Date: Sat, 17 Jun 2006 15:47:17 +0200
Message-ID: <20060617134717.GR7766@nowhere.earth>
References: <20060617122158.GQ7766@nowhere.earth> <20060617132023.GA29452@pe.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>, cvsps@dm.cobite.com
X-From: git-owner@vger.kernel.org Sat Jun 17 15:47:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Frb8g-0006Av-Un
	for gcvg-git@gmane.org; Sat, 17 Jun 2006 15:47:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbWFQNqu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Jun 2006 09:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751630AbWFQNqu
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jun 2006 09:46:50 -0400
Received: from smtp4-g19.free.fr ([212.27.42.30]:58552 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751627AbWFQNqt (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Jun 2006 09:46:49 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp4-g19.free.fr (Postfix) with ESMTP id 18C4B510F3;
	Sat, 17 Jun 2006 15:46:48 +0200 (CEST)
Received: from dwitch by bylbo.nowhere.earth with local (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1Frb8w-0002Uw-2d; Sat, 17 Jun 2006 15:47:18 +0200
To: Chris Shoemaker <c.shoemaker@cox.net>
Content-Disposition: inline
In-Reply-To: <20060617132023.GA29452@pe.Belkin>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22016>

On Sat, Jun 17, 2006 at 09:20:23AM -0400, Chris Shoemaker wrote:
> > 
> > * when run with "-A" cvsps notices the inconsistency:
> > 
> > invalid initial_branch for file a, probably from old cache, run with -x.
> 
> good advice.
> 
> > 
> > 
> > I have included the current version of your patch in branch "to-check"
> > in http://ydirson.free.fr/soft/git/cvsps.git/.  I did not tak time to
> > look at it closely yet - do you plan to work on this issue ?
> 
> I wondered if you'd find that.  Evidentally, you're being thorough. :)
> 
> The intent of my patch is only to affect the branch ancestry
> calculation.  IIRC, the patch version is incompatible with cached
> results from unpatched versions.  Hence I would only expect it to work
> with '-x -A' (unless there was no pre-existing cache file).

All those tests were done with your patch applied, so the cache was
generated and re-read using the pached version.

> There's probably some nicer way to handle the cache incompatibility,
> but my current approach has been to tell people to delete their old
> cache file or run wih -x.  Suggestions are welcome.

If the cache format is changed, this would be a good candidate for the
"v2" cache format.  I already have 2 (incomplete) patches that well
need to bump the cache format version - see branches multitag (allow
several tags per patchset) and semicolon (allow semicolons in
filenames).

Best regards,
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
