From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach git push .git/branches shorthand
Date: Mon, 8 Aug 2005 11:55:46 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508081154190.32406@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <7viryhgdo5.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0508081106580.26210@wgmdd8.biozentrum.uni-wuerzburg.de>
 <200508081141.23242.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 08 11:56:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E24MJ-0007YK-6l
	for gcvg-git@gmane.org; Mon, 08 Aug 2005 11:55:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbVHHJzs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 05:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbVHHJzs
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 05:55:48 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:36061 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750793AbVHHJzr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2005 05:55:47 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C3A13E2FA8; Mon,  8 Aug 2005 11:55:46 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A495B9C7DC; Mon,  8 Aug 2005 11:55:46 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 926849C7D5; Mon,  8 Aug 2005 11:55:46 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 833BFE2BBF; Mon,  8 Aug 2005 11:55:46 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200508081141.23242.Josef.Weidendorfer@gmx.de>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 8 Aug 2005, Josef Weidendorfer wrote:

> IMHO, $GIT_DIR/branches/ is really confusing.
> Hmmm... in $GIT_DIR/branches/ there are named references to remote (named) 
> references.

Not necessarily. The following is perfectly valid:

echo "rsync://rsync.kernel.org/pub/scm/git/git.git > .git/branches/x

It does not contain a named reference, just a host.

Ciao,
Dscho
