From: Yann Dirson <ydirson@altern.org>
Subject: Re: [PATCH] Ignore commits for which cvsps can't identify a branch
Date: Sat, 10 Jun 2006 21:24:57 +0200
Message-ID: <20060610192457.GA6620@nowhere.earth>
References: <200602102102.k1AL2Xkd010415@biesi.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 10 21:25:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fp952-0005Dz-PF
	for gcvg-git@gmane.org; Sat, 10 Jun 2006 21:25:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751688AbWFJTY5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Jun 2006 15:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751666AbWFJTY5
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jun 2006 15:24:57 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:34022 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751266AbWFJTY4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Jun 2006 15:24:56 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 84C7F2488C;
	Sat, 10 Jun 2006 21:24:55 +0200 (CEST)
Received: from dwitch by bylbo.nowhere.earth with local (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1Fp94r-000214-SB; Sat, 10 Jun 2006 21:24:57 +0200
To: Christian Biesinger <cbiesinger@web.de>
Content-Disposition: inline
In-Reply-To: <200602102102.k1AL2Xkd010415@biesi.no-ip.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21617>

On Fri, Feb 10, 2006 at 10:02:33PM +0100, Christian Biesinger wrote:
> cvps sometimes can't identify a branch for a specific revision, it shows
> messages like:
>   WARNING: revision 1.36.2.2 of file Makefile.in on unnamed branch
> and uses #CVSPS_NO_BRANCH as branch name in its output.

This issue is a bit old, but still...

I have seen such CVSPS_NO_BRANCH things with "cvsps -u", and could
always get rid of it using "cvspx -x".  Christian, did you try to run
"cvsps -x" to be sure the cache is valid, and did it get rid of the
CVSPS_NO_BRANCH ?  It could help if you could make a cvsps cache
available, which exhibits the problem.

Best regards,
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
