From: Yann Dirson <ydirson@altern.org>
Subject: Re: [PATCH] git-commit: filter out log message lines only when editor was run.
Date: Sun, 25 Jun 2006 09:21:00 +0200
Message-ID: <20060625072100.GG1502@nowhere.earth>
References: <20060624094217.GB7851@nowhere.earth> <e5bfff550606250008k702acfadm8860e9b672bced56@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net, GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 25 09:20:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuOvG-0004Q5-M5
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 09:20:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbWFYHUc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 03:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWFYHUc
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 03:20:32 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:39861 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751415AbWFYHUc (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jun 2006 03:20:32 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp6-g19.free.fr (Postfix) with ESMTP id D71C522530;
	Sun, 25 Jun 2006 09:20:30 +0200 (CEST)
Received: from dwitch by bylbo.nowhere.earth with local (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1FuOvV-0003hl-2R; Sun, 25 Jun 2006 09:21:01 +0200
To: Marco Costalba <mcostalba@gmail.com>
Content-Disposition: inline
In-Reply-To: <e5bfff550606250008k702acfadm8860e9b672bced56@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22592>

On Sun, Jun 25, 2006 at 09:08:02AM +0200, Marco Costalba wrote:
> 1) It's ok to let git-comit do not strip comment lines, it's already
> done by qgit.

That's great news :)

> 2) Please don't change git status output to use another symbol to mark
> comment lines because it will break line stripping code.

If it ever gets changed, it should anyway IMHO be made a parameter.  A
strategy could be to make it customizable first, advertize this loudly
so tools adapt themselves to force the prefix to what suits them best,
and then eventually change the default in a major release.

Best regards,
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
