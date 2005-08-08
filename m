From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: git-commit-script, was Re: "git revert" (Re: pci_update_resource()
 getting called on sparc64)
Date: Mon, 8 Aug 2005 23:30:59 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508082329170.2934@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <20050808.103304.55507512.davem@davemloft.net>
 <Pine.LNX.4.58.0508081131540.3258@g5.osdl.org> <20050808160846.GA7710@kroah.com>
 <20050808.123209.59463259.davem@davemloft.net> <20050808194249.GA6729@kroah.com>
 <Pine.LNX.4.58.0508081249110.3258@g5.osdl.org> <Pine.LNX.4.58.0508081257190.3258@g5.osdl.org>
 <7vd5oo40mq.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0508081357020.3258@g5.osdl.org>
 <7voe882kds.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 08 23:31:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2FD9-0004Pv-QE
	for gcvg-git@gmane.org; Mon, 08 Aug 2005 23:31:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbVHHVbE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 17:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbVHHVbD
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 17:31:03 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:21380 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932268AbVHHVbB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2005 17:31:01 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5073FE32BA; Mon,  8 Aug 2005 23:31:00 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 360099CC24; Mon,  8 Aug 2005 23:31:00 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 217B69C966; Mon,  8 Aug 2005 23:31:00 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D3F01E32BA; Mon,  8 Aug 2005 23:30:59 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7voe882kds.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 8 Aug 2005, Junio C Hamano wrote:

>  * git commit does not take commit message from stdin.  I think
>    we should do something like this:
>
> [...]

And could we rename the *-m* flag at the same time? Because I often catch 
myself typing

	git commit -m "Some_commit_message"

Ciao,
Dscho
