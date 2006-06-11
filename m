From: Yann Dirson <ydirson@altern.org>
Subject: Collecting cvsps patches
Date: Sun, 11 Jun 2006 14:27:46 +0200
Message-ID: <20060611122746.GB7766@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: cvsps@dm.cobite.com
X-From: git-owner@vger.kernel.org Sun Jun 11 14:27:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpP2m-0005vq-6g
	for gcvg-git@gmane.org; Sun, 11 Jun 2006 14:27:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbWFKM1o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Jun 2006 08:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWFKM1o
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jun 2006 08:27:44 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:17059 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751235AbWFKM1n (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Jun 2006 08:27:43 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 923E448944;
	Sun, 11 Jun 2006 14:27:42 +0200 (CEST)
Received: from dwitch by bylbo.nowhere.earth with local (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1FpP2h-0002wD-1O; Sun, 11 Jun 2006 14:27:47 +0200
To: GIT list <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21653>

Since there are has been some work done here and there on cvsps, but
upstream does not seem to have time to issue a new release, I have
started to collect the patches I found.

I guess this is a good place for a heads-up: if you know of any other
bugfixes or feature patches to cvsps, I'd like to hear about it, so I
can add it to my repo.

Not that the master branch is an octopus merge of all works in there,
including my preliminary work on multiple-tag support, so for now you
may want to do your own mix.

For now it has:

* bugfixes and such:

Anand Kumria:
      FreeBSD isn't evil - just misguided

Linus Torvalds:
      Increase log-length limit to 64kB
      Improve handling of file collisions in the same patchset
      Fix branch ancestor calculation

Yann Dirson:
      Cleanup the tag handling to simplify multi-tag handling
      Dependency handling

* features

Yann Dirson:
      Allow to have multiple tags on a single patchset.

-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
