From: Yann Dirson <ydirson@altern.org>
Subject: Re: [RFC] Applying a graft to a tree and "rippling" the changes through
Date: Sun, 20 Nov 2005 23:35:03 +0100
Message-ID: <20051120223503.GJ3393@nowhere.earth>
References: <20051117230723.GD26122@nowhere.earth> <Pine.LNX.4.63.0511180026080.18775@wbgn013.biozentrum.uni-wuerzburg.de> <20051119140404.GD3393@nowhere.earth> <20051119141341.GE3393@nowhere.earth> <Pine.LNX.4.63.0511191612350.4895@wbgn013.biozentrum.uni-wuerzburg.de> <20051119170929.GF3393@nowhere.earth> <pan.2005.11.19.17.23.17.920228@smurf.noris.de> <Pine.LNX.4.63.0511200217200.11653@wbgn013.biozentrum.uni-wuerzburg.de> <20051120073244.GA7902@kiste.smurf.noris.de> <Pine.LNX.4.63.0511201242210.27791@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 20 23:35:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Edxkb-0008M9-Qk
	for gcvg-git@gmane.org; Sun, 20 Nov 2005 23:33:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbVKTWdb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Nov 2005 17:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbVKTWdb
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Nov 2005 17:33:31 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:51910 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S932099AbVKTWda (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Nov 2005 17:33:30 -0500
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 78ACE966D;
	Sun, 20 Nov 2005 23:33:29 +0100 (CET)
Received: from dwitch by nan92-1-81-57-214-146 with local (Exim 4.54)
	id 1Edxm3-0004ib-Jx; Sun, 20 Nov 2005 23:35:03 +0100
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0511201242210.27791@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12407>

On Sun, Nov 20, 2005 at 12:44:28PM +0100, Johannes Schindelin wrote:
> On Sun, 20 Nov 2005, Matthias Urlichs wrote:
> 
> > Why not simply use info/grafts?
> 
> 'Cause you can't fetch a graft. But I agree, instead of telling somebody: 
> "I have this new branch which unifies history", you can send your friend a 
> oneliner which appends a graft.

It can also be useful to work with grafts locally, and then use a
script to convert the grafted tree into real commits.

Best regards,
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
