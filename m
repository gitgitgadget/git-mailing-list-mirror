From: Yann Dirson <ydirson@altern.org>
Subject: Re: [PATCH] CVSps fixed; git-cvsimport works, too
Date: Sat, 17 Jun 2006 20:51:27 +0200
Message-ID: <20060617185126.GS7766@nowhere.earth>
References: <20060617122158.GQ7766@nowhere.earth> <20060617132023.GA29452@pe.Belkin> <20060617134717.GR7766@nowhere.earth> <20060617143443.GA29602@pe.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>, cvsps@dm.cobite.com
X-From: git-owner@vger.kernel.org Sat Jun 17 20:51:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Frfsr-0003yh-8N
	for gcvg-git@gmane.org; Sat, 17 Jun 2006 20:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbWFQSu6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Jun 2006 14:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbWFQSu6
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jun 2006 14:50:58 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:10130 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750824AbWFQSu5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Jun 2006 14:50:57 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 98D1F73154;
	Sat, 17 Jun 2006 20:50:56 +0200 (CEST)
Received: from dwitch by bylbo.nowhere.earth with local (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1FrftH-0002eW-Di; Sat, 17 Jun 2006 20:51:27 +0200
To: Chris Shoemaker <c.shoemaker@cox.net>
Content-Disposition: inline
In-Reply-To: <20060617143443.GA29602@pe.Belkin>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22025>

On Sat, Jun 17, 2006 at 10:34:43AM -0400, Chris Shoemaker wrote:
> Are you saying there was no pre-existing cache file when the patched
> version was first run?

It was the sample script you provided to demonstrate the problem which
showed the new issue: it does a "cvsps -x" first, then runs
git-cvsimport, which runs "cvsps -u".  That one does fails.  I'm
pretty sure the cache does not exist beforehand, since your script
creates the repo in a temporary directory.

BTW, I'll see about adding a testsuite to cvsps, based on the
framework used by git.  All these scriptlets used to exhibit the
various problems have to be kept somewhere.


>  Did you delete it?  If so, then there's a bug somewhere.

I do think there is a bug somewhere :)


> The complaint is basically, Hey, there's an initial branch
> determination already made for this file, but it's not the one I would
> have made, so it must have been restored from a cache file that I
> didn't make.

OK, thanks for the clarification.

Best regards,
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
