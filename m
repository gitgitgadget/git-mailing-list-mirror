From: Yann Dirson <ydirson@altern.org>
Subject: Re: Autoconf/Automake
Date: Thu, 15 Jun 2006 18:32:09 +0200
Message-ID: <20060615163209.GJ7766@nowhere.earth>
References: <1150324030.23268.12.camel@dv> <20060615072450.GF7766@nowhere.earth> <20060615133146.GA5794@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pavel Roskin <proski@gnu.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 15 18:31:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fqul5-00069G-SD
	for gcvg-git@gmane.org; Thu, 15 Jun 2006 18:31:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030799AbWFOQbt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Jun 2006 12:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030808AbWFOQbt
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jun 2006 12:31:49 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:27052 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S1030799AbWFOQbs (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jun 2006 12:31:48 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 67DF527718;
	Thu, 15 Jun 2006 18:31:47 +0200 (CEST)
Received: from dwitch by bylbo.nowhere.earth with local (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1FqulN-0007mb-L2; Thu, 15 Jun 2006 18:32:09 +0200
To: Alex Riesen <raa.lkml@gmail.com>
Content-Disposition: inline
In-Reply-To: <20060615133146.GA5794@steel.home>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21896>

On Thu, Jun 15, 2006 at 03:31:46PM +0200, Alex Riesen wrote:
> Yann Dirson, Thu, Jun 15, 2006 09:24:50 +0200:
> > Since there are many people objecting to autotools, what about using
> > Jam instead ?  It has the advantage of being designed to be
> > cross-platform, and should have all the features we would need for *git.
> 
> Except that it is not readily available everywhere, has unreadable
> and illogical syntax, and lots of unknown assumptions built in.
> We are forced to use that thing at work, and it is mostly hated.

Well, being hated is often the fate of tools for which users got no
training, but are forced to used because of a corporate decision.
That does not necessarily mean the tool is bad in itself.

> If we are about to need a configuration system (and I doubt it), may
> be we should at least select a system small enough to have it always
> in git repo? (yes, as linux kernel configuration system is)

The kernel is a beast that is specific enough to need its own build
system, and does not support that many platforms, IIRC.  Wrong
example, if you want my opinion :)

Best regards,
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
