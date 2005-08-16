From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add SubmittingPatches
Date: Tue, 16 Aug 2005 03:03:10 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508160252310.26927@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <7vslxep5jq.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0508160147560.26580@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0508151715520.3553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 03:04:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4prM-00054d-Td
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 03:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965054AbVHPBDM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 21:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965056AbVHPBDM
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 21:03:12 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:24549 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S965054AbVHPBDM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2005 21:03:12 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0127FE26B2; Tue, 16 Aug 2005 03:03:11 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D995CB08A1; Tue, 16 Aug 2005 03:03:10 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id BF168AD0CB; Tue, 16 Aug 2005 03:03:10 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A9DCAE26B2; Tue, 16 Aug 2005 03:03:10 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508151715520.3553@g5.osdl.org>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 15 Aug 2005, Linus Torvalds wrote:

> On Tue, 16 Aug 2005, Johannes Schindelin wrote:
> > 
> > BTW, I don't know how many people still use pine, but for those poor souls 
> > it may be good to mention that the quell-flowed-text is needed for recent 
> > versions.
> 
> And 4.58 needs at least this
>
>[...]

Sorry, I forgot the "no-strip-whitespace-before-send" option, too. AFAIK 
it was introduced in 4.60 (the "fix" Junio was referring to).

Maybe we should enhance git-applymbox to detect whitespace corruption in 
particular, and output the User-Agent header (or if that does not 
exist, the Message-ID header; thanks, pine) on error.

Ciao,
Dscho
