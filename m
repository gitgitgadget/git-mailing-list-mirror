From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git pull for update of netdev fails.
Date: Wed, 20 Sep 2006 23:23:11 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609202321390.19042@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060920080308.673a1e93@localhost.localdomain>
 <Pine.LNX.4.64.0609200816400.4388@g5.osdl.org> <20060920155431.GO8259@pasky.or.cz>
 <Pine.LNX.4.63.0609201801110.19042@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060920160756.GP8259@pasky.or.cz> <Pine.LNX.4.64.0609200915550.4388@g5.osdl.org>
 <Pine.LNX.4.64.0609200920290.4388@g5.osdl.org> <20060920163437.GC23260@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 23:25:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ9Xp-0006rI-MS
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 23:23:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWITVXQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 17:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbWITVXP
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 17:23:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:42447 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932122AbWITVXN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Sep 2006 17:23:13 -0400
Received: (qmail invoked by alias); 20 Sep 2006 21:23:11 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp004) with SMTP; 20 Sep 2006 23:23:11 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060920163437.GC23260@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27403>

Hi,

On Wed, 20 Sep 2006, Shawn Pearce wrote:

> Of course an update hook finally took care of the problem, but having
> non fast-forward pushs be permitted on a shared, bare repository
> by default is interesting to say the least.  :-)

Unfortunately, it is send-pack making the decision on the client side, not 
receive-pack on the server side, the latter of which knows if the server 
side is shared or not.

Ciao,
Dscho
