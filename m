From: Yann Dirson <ydirson@altern.org>
Subject: Re: git-cvsimport doesn't quite work, wrt branches
Date: Thu, 15 Jun 2006 09:18:24 +0200
Message-ID: <20060615071823.GE7766@nowhere.earth>
References: <87irn5ovn6.fsf@rho.meyering.net> <Pine.LNX.4.64.0606131008470.5498@g5.osdl.org> <1150224411.20536.79.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Jim Meyering <jim@meyering.net>,
	Git Mailing List <git@vger.kernel.org>,
	Matthias Urlichs <smurf@smurf.noris.de>,
	Pavel Roskin <proski@gnu.org>
X-From: git-owner@vger.kernel.org Thu Jun 15 09:18:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fqm7J-0000Hr-0F
	for gcvg-git@gmane.org; Thu, 15 Jun 2006 09:18:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbWFOHSJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Jun 2006 03:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWFOHSJ
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jun 2006 03:18:09 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:42652 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751111AbWFOHSI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jun 2006 03:18:08 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 4027B7315A;
	Thu, 15 Jun 2006 09:18:04 +0200 (CEST)
Received: from dwitch by bylbo.nowhere.earth with local (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1Fqm7U-0007Nv-SG; Thu, 15 Jun 2006 09:18:24 +0200
To: Keith Packard <keithp@keithp.com>
Content-Disposition: inline
In-Reply-To: <1150224411.20536.79.camel@neko.keithp.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21881>

On Tue, Jun 13, 2006 at 11:46:51AM -0700, Keith Packard wrote:
> Yeah, we've got
> 
> 	git-cvsimport
> 	cvsps
> 	cvs rlog
> 	,v files
> 
> cvs rlog is designed to 'represent' the history of the repository to
> users.

I wouldn't exactly call that "history of the repository" :)

Are you thinking about any particular information from the ,v files,
that rlog fails to expose ?  That is, wouldn't be possible to do a job
similar to what parsecvs does, with remote support ?

Best regards,
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
