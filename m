From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: How is working on arbitrary remote heads supposed to work in
 Cogito (+ PATCH)?
Date: Tue, 16 Aug 2005 01:55:55 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508160153000.26580@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <20050729081051.GH24895@pasky.ji.cz> <20050813041114.GA29412@hpsvcnb.fc.hp.com>
 <7vacjmqnu7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Carl Baldwin <cnb@fc.hp.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 01:56:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4ooE-0001Mm-Ic
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 01:56:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965037AbVHOXz5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 19:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965040AbVHOXz5
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 19:55:57 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:51938 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S965037AbVHOXz4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2005 19:55:56 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 06DE0E282D; Tue, 16 Aug 2005 01:55:56 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id DCB39B08A1; Tue, 16 Aug 2005 01:55:55 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id BF1C5ACB9C; Tue, 16 Aug 2005 01:55:55 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A1815E282D; Tue, 16 Aug 2005 01:55:55 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vacjmqnu7.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, 13 Aug 2005, Junio C Hamano wrote:

> Johannes posted a script on the list a couple of days ago, which
> should work well, except that it was written before the
> git-fetch-pack command was updated to natively download from
> multiple refs, so it does not know how to fetch multiple refs at
> a one go.

Actually, my script usually only calls fetch once. It checks if the commit 
object is already local before trying to fetch it, and it turns out that a 
single fetch is often (always?) sufficient to slurp the other commits, 
too. I did not have time to find out if that is a true bug in git.

Ciao,
Dscho
