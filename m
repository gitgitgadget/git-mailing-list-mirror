From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add a new extended SHA1 syntax <name>:<num>
Date: Sun, 21 Aug 2005 20:26:35 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508212025350.15353@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <7vll2viq05.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 21 23:34:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E6xSV-0007Zh-Gm
	for gcvg-git@gmane.org; Sun, 21 Aug 2005 23:34:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbVHUVeZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Aug 2005 17:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbVHUVeY
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Aug 2005 17:34:24 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:30668 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751133AbVHUVeY (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Aug 2005 17:34:24 -0400
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id j7LIQxR3028760
	for <git@vger.kernel.org>; Sun, 21 Aug 2005 11:27:00 -0700
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id DF86413C05F; Sun, 21 Aug 2005 20:26:28 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id CA59F9A07E; Sun, 21 Aug 2005 20:26:28 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id AD0339A055; Sun, 21 Aug 2005 20:26:28 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx67.rz.uni-wuerzburg.de [132.187.3.67])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5FEF113C05F; Sun, 21 Aug 2005 20:26:28 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vll2viq05.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.85, clamav-milter version 0.85 on zeus1
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Sun, 21 Aug 2005, Junio C Hamano wrote:

> The new notation is a short-hand for <name> followed by <num>
> caret ('^') characters.  E.g. "master:4" is the fourth
> generation ancestor of the current "master" branch head,
> following the first parents; same as "master^^^^" but a bit more
> readable.

This might confuse some people with the <src>:<dest> notation of the 
renaming fetch...

Ciao,
Dscho
