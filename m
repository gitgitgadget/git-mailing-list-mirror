From: Yann Dirson <ydirson@altern.org>
Subject: Re: Collecting cvsps patches
Date: Tue, 13 Jun 2006 11:54:45 +0200
Message-ID: <20060613095445.GM1297@nowhere.earth>
References: <20060611122746.GB7766@nowhere.earth> <1150173310.15831.6.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>, cvsps@dm.cobite.com
X-From: git-owner@vger.kernel.org Tue Jun 13 11:54:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fq5bb-0004jA-3o
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 11:54:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbWFMJyf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Jun 2006 05:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750864AbWFMJyf
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 05:54:35 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:46486 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750847AbWFMJye (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jun 2006 05:54:34 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp5-g19.free.fr (Postfix) with ESMTP id DD36027533;
	Tue, 13 Jun 2006 11:54:33 +0200 (CEST)
Received: from dwitch by bylbo.nowhere.earth with local (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1Fq5bh-0004ri-VA; Tue, 13 Jun 2006 11:54:46 +0200
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <1150173310.15831.6.camel@dv>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21775>

Hi Pavel,

On Tue, Jun 13, 2006 at 12:35:10AM -0400, Pavel Roskin wrote:
> I'm sending four patches - two compile
> fixes for recent regressions and two patches fixing DNS resolution on
> 64-bit systems - one on Linux and the other on other OSes.

Thanks, applied the two latter fixes, and folded the compile fix into
the patch it should have been part of :)

For the dependency stuff, I added the -Y flag to hte makedepend
invocation.  This produces many warnings, but at least does the job
right.

I'll push the whole once I have finished a little work on another
branch.

Please excuse any delays due to the recent birth of our 3rd son ;)

Best regards,
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
