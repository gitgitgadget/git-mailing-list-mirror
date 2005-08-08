From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach git push .git/branches shorthand
Date: Mon, 8 Aug 2005 12:36:22 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508081234300.32668@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <7viryhgdo5.fsf@assigned-by-dhcp.cox.net>
 <200508081141.23242.Josef.Weidendorfer@gmx.de>
 <Pine.LNX.4.63.0508081154190.32406@wgmdd8.biozentrum.uni-wuerzburg.de>
 <200508081225.59949.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 08 12:39:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E251S-00038O-79
	for gcvg-git@gmane.org; Mon, 08 Aug 2005 12:38:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbVHHKgX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 06:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbVHHKgX
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 06:36:23 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:65256 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750814AbVHHKgX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2005 06:36:23 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 44F2DE30B8; Mon,  8 Aug 2005 12:36:22 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 28AED9C7E7; Mon,  8 Aug 2005 12:36:22 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 181479C7D4; Mon,  8 Aug 2005 12:36:22 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 03966E30B8; Mon,  8 Aug 2005 12:36:22 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200508081225.59949.Josef.Weidendorfer@gmx.de>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 8 Aug 2005, Josef Weidendorfer wrote:

> Your example defaults to the master head.

My point being that I still can say

	git pull x some_non_default_head

with a file "x" in .git/branches. Anyway, I don't care much either way, if 
it be "remotes/" or "remoterefs/" or 
"magic_mapping_for_remote_repositories/" or even "repositories/".

Ciao,
Dscho
