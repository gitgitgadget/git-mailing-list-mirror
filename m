From: Yann Dirson <ydirson@altern.org>
Subject: Re: [RFC] Applying a graft to a tree and "rippling" the changes through
Date: Sat, 19 Nov 2005 15:13:41 +0100
Message-ID: <20051119141341.GE3393@nowhere.earth>
References: <20051117230723.GD26122@nowhere.earth> <Pine.LNX.4.63.0511180026080.18775@wbgn013.biozentrum.uni-wuerzburg.de> <20051119140404.GD3393@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ryan Anderson <ryan@michonline.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Nov 19 15:12:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdTRx-0008PP-IM
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 15:12:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbVKSOMO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Nov 2005 09:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbVKSOMO
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Nov 2005 09:12:14 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:56983 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750722AbVKSOMO (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Nov 2005 09:12:14 -0500
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 4323595DF;
	Sat, 19 Nov 2005 15:12:13 +0100 (CET)
Received: from dwitch by nan92-1-81-57-214-146 with local (Exim 4.54)
	id 1EdTTJ-0007Cc-M3; Sat, 19 Nov 2005 15:13:41 +0100
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20051119140404.GD3393@nowhere.earth>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12341>

On Sat, Nov 19, 2005 at 03:04:05PM +0100, Yann Dirson wrote:
> Trees have an existence outside any consideration of what changes led
> to them, as shown by the fact that git trees do not reference anything
> outside them.  And it is right that, at that level, noone tells you
> how you got there - not less nor more than when you fetch a
> linux-x.y.z.tar.gz2 from kernel.org.
> 
> Then at a bit higher level, you can consider changes from a tree to a
> tree.  What you usually do when you commit a change is explaining what
> you change to the tree.  Then changes themselves are just derived from
> the trees (iow, "abstracted from" the trees), and you augment this
> information with a message explaining what you did.
> 
> Then at a still higher level, you can derive history lines from the
> individual trees and changes, and augment this information, eg. by
> signing them.

IOW,
- 1st level describes states that existed
- 2nd level describes events that occured, causing the state to change
- 3rd level describes the succession of events

and for the record, I am likely to introduce with ArcheoloGIT a 4th
level, which will describe how our idea of history evolves over time.

Best regards,
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
