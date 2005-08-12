From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fetch-pack: start multi-head pulling.
Date: Fri, 12 Aug 2005 18:19:30 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508121818230.26488@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <7vwtmr4hm5.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0508120858420.3295@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 12 18:20:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3cFr-0005Qq-Jd
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 18:19:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbVHLQTc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 12:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbVHLQTc
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 12:19:32 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:27557 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751218AbVHLQTc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2005 12:19:32 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 29106E25BA; Fri, 12 Aug 2005 18:19:31 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 11D4BB3512; Fri, 12 Aug 2005 18:19:31 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E24EB9B881; Fri, 12 Aug 2005 18:19:30 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8E03FE25BA; Fri, 12 Aug 2005 18:19:30 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508120858420.3295@g5.osdl.org>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 12 Aug 2005, Linus Torvalds wrote:

> Wouldn't it be simpler/cleaner to just do
> 
> 	head=($(git-fetch-pack "$merge_repo" "$merge_head"))

I seem to remember Junio does not like bash arrays... And in a recent 
commit message, he even admits to using something different than bash!

Ciao,
Dscho
