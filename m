From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: question about git-submodule
Date: Sun, 15 Jul 2007 13:51:48 +0200
Message-ID: <20070715115148.GD999MdfPADPa@greensroom.kotnet.org>
References: <20070713214630.GB7106@genesis.frugalware.org>
 <20070715083959.GC999MdfPADPa@greensroom.kotnet.org>
 <20070715104712.GF2568@steel.home>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: VMiklos <vmiklos@frugalware.org>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 15 13:51:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IA2dm-00008u-Ut
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 13:51:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758842AbXGOLvv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 07:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758679AbXGOLvu
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 07:51:50 -0400
Received: from smtp14.wxs.nl ([195.121.247.5]:56543 "EHLO smtp14.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758541AbXGOLvu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 07:51:50 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp14.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JL700I5RYACVX@smtp14.wxs.nl> for git@vger.kernel.org; Sun,
 15 Jul 2007 13:51:48 +0200 (CEST)
Received: (qmail 18319 invoked by uid 500); Sun, 15 Jul 2007 11:51:48 +0000
In-reply-to: <20070715104712.GF2568@steel.home>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52545>

On Sun, Jul 15, 2007 at 12:47:12PM +0200, Alex Riesen wrote:
> Count me out. Junio convinced me instead and having tried the
> subprojects I find it really convenient: I can choose when and what
> should be updated and I can see what _can_ be updated, iff I decide
> to. Subprojects defined in such a loosely way are more flexible then
> having git-pull fetch subprojects by default.

I agree that fetching should probably be left as a separate operation,
but if you have all the data, then I find it very inconvenient that
every time you switch to a different commit you have to update
all the subprojects separately too.
Did you change your mind about this part too?

> Sometimes I even want be
> _sure_ the subprojects are completely untouched (I have some critical
> parts in them).

The update in the superproject would fail if the subproject is dirty
(just as with files.)

skimo
