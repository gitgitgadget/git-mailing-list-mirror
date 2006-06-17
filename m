From: Yann Dirson <ydirson@altern.org>
Subject: Re: [BUG] stgit branch renaming into new dir crashes
Date: Sat, 17 Jun 2006 23:31:21 +0200
Message-ID: <20060617213120.GV1297@nowhere.earth>
References: <20060613214053.GD7766@nowhere.earth> <b0943d9e0606160506g23179531v7921b67ac0e0aa0d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 17 23:30:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FriNb-0000Ob-WC
	for gcvg-git@gmane.org; Sat, 17 Jun 2006 23:30:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbWFQVax (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Jun 2006 17:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbWFQVax
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jun 2006 17:30:53 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:19353 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750932AbWFQVaw (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Jun 2006 17:30:52 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp5-g19.free.fr (Postfix) with ESMTP id C858326516;
	Sat, 17 Jun 2006 23:30:51 +0200 (CEST)
Received: from dwitch by bylbo.nowhere.earth with local (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1FriO1-0002kn-An; Sat, 17 Jun 2006 23:31:21 +0200
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <b0943d9e0606160506g23179531v7921b67ac0e0aa0d@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22032>

On Fri, Jun 16, 2006 at 01:06:56PM +0100, Catalin Marinas wrote:
> On 13/06/06, Yann Dirson <ydirson@altern.org> wrote:
> >When trying to rename a branch to a name including a slash, there is
> >no explicit creation of leading dirs, and stgit crashes:
> >
> >$ stg branch -r multitag dev/multitag
> >Traceback (most recent call last):
> [...]
> 
> What version of StGIT are you using? It seems to be OK with 0.10.

Right, that was with 0.9, and works perfectly with 0.10.  Relying too
much on /usr/bin/ ... :)

Best regards,
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
