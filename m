From: Yann Dirson <ydirson@altern.org>
Subject: Re: Autoconf/Automake
Date: Thu, 15 Jun 2006 09:24:50 +0200
Message-ID: <20060615072450.GF7766@nowhere.earth>
References: <1150324030.23268.12.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 15 09:24:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqmDT-0001TZ-Di
	for gcvg-git@gmane.org; Thu, 15 Jun 2006 09:24:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbWFOHYb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Jun 2006 03:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbWFOHYb
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jun 2006 03:24:31 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:9123 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751194AbWFOHYa (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jun 2006 03:24:30 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g19.free.fr (Postfix) with ESMTP id E172C9AA16;
	Thu, 15 Jun 2006 09:24:29 +0200 (CEST)
Received: from dwitch by bylbo.nowhere.earth with local (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1FqmDi-0007W1-FV; Thu, 15 Jun 2006 09:24:50 +0200
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <1150324030.23268.12.camel@dv>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21882>

On Wed, Jun 14, 2006 at 06:27:10PM -0400, Pavel Roskin wrote:
> Is there any interest in converting the build system used by git to
> Autoconf and Automake?  The ad-hoc configuration in Makefile is getting
> too big.  As for nice features like remembering $prefix, wouldn't it be
> better to add them to Automake instead of limiting them to just one
> project?

Since there are many people objecting to autotools, what about using
Jam instead ?  It has the advantage of being designed to be
cross-platform, and should have all the features we would need for *git.

When compared to autotools, it rather takes the place of automake, and
can also be use together with autoconf (or any non-make-specific
replacement you can name) if there is a need for it.

Best regards,
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
