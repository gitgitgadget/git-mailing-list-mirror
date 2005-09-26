From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: rsync deprecated but promoted?
Date: Mon, 26 Sep 2005 22:12:09 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0509262208550.12539@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <20050925163201.GA29198@tumblerings.org> <4d4586301dca616f42880612fae01492@cream.org>
 <20050926133204.GB21019@pasky.or.cz> <Pine.LNX.4.58.0509260801430.3308@g5.osdl.org>
 <dh98gk$6rp$1@sea.gmane.org> <Pine.LNX.4.58.0509261038460.3308@g5.osdl.org>
 <dh9hqs$6nl$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 26 22:14:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJzKr-0004cP-VO
	for gcvg-git@gmane.org; Mon, 26 Sep 2005 22:12:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932497AbVIZUMR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 16:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbVIZUMQ
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 16:12:16 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:21640 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932498AbVIZUMP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2005 16:12:15 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5AB5313D472; Mon, 26 Sep 2005 22:12:10 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 40D4DB385C; Mon, 26 Sep 2005 22:12:10 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 24691B3858; Mon, 26 Sep 2005 22:12:10 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 9793013D472; Mon, 26 Sep 2005 22:12:09 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: walt <wa1ter@myrealbox.com>
In-Reply-To: <dh9hqs$6nl$1@sea.gmane.org>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9325>

Hi,

On Mon, 26 Sep 2005, walt wrote:

> Using the --full flag made the error disappear for your kernel tree,
> but had no effect on the git tree.

I think it is because of the "pu" branch, which gets fetched using rsync, 
but no ref is pointing to it. Since the "pu" branch is rebased quite 
often, it would also happen if you fetched the "pu" branch, though.

Ciao,
Dscho
