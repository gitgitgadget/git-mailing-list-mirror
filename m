From: Yann Dirson <ydirson@altern.org>
Subject: What's in cvsps.git
Date: Fri, 16 Jun 2006 23:44:58 +0200
Message-ID: <20060616214458.GP7766@nowhere.earth>
References: <20060611122746.GB7766@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: cvsps@dm.cobite.com, "David D. Kilzer" <ddkilzer@kilzer.net>,
	Marcus Crafter <crafterm@debian.org>
X-From: git-owner@vger.kernel.org Fri Jun 16 23:44:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrM7J-0002y1-9f
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 23:44:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbWFPVoe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 17:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751522AbWFPVoe
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 17:44:34 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:14518 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751519AbWFPVod (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jun 2006 17:44:33 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 8B0F348D51;
	Fri, 16 Jun 2006 23:44:32 +0200 (CEST)
Received: from dwitch by bylbo.nowhere.earth with local (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1FrM7f-0000do-5B; Fri, 16 Jun 2006 23:44:59 +0200
To: GIT list <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060611122746.GB7766@nowhere.earth>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21975>


I have now added all patches gathered from here, as well as those in
the current Debian package.  Still have to dig other distros.

Note the log-length limit increment is being superceded by a dynamic
allocation patch.

Repo URL:  http://ydirson.free.fr/soft/git/cvsps.git

==============================

	* master has:

Alexander Litvinov:
      Handle cvs repo with modules

Anand Kumria:
      FreeBSD isn't evil - just misguided

David D. Kilzer:
      cvsps: should ignore TRUNK branch if it exists in log
      Dynamically allocate the log buffer to prevent warning messages

Linus Torvalds:
      Increase log-length limit to 64kB
      Improve handling of file collisions in the same patchset
      Fix branch ancestor calculation

Pavel Roskin:
      Use __linux__ conditional, not LINUX.
      Use INADDR_NONE instead of -1 to check inet_addr() result

Roberto C. Sanchez:
      Diff opts typo fix.

Yann Dirson:
      Call cvs with -q flag when fetching the log
      Dependency handling


	* to-check additionally has:

Linus Torvalds:
      Make time ordering less important than revision ordering


	* dev branches still have incomplete stuff, so I don't list it
	here.

-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
