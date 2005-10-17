From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-snapshot.sh
Date: Tue, 18 Oct 2005 00:21:50 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510180021120.15669@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20051017220615.GG12774@schottelius.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 18 00:23:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERdMn-0007oH-NE
	for gcvg-git@gmane.org; Tue, 18 Oct 2005 00:22:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbVJQWVx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Oct 2005 18:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbVJQWVx
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Oct 2005 18:21:53 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:40167 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932348AbVJQWVw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2005 18:21:52 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E368CE1038; Tue, 18 Oct 2005 00:21:50 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id CADC39EE28; Tue, 18 Oct 2005 00:21:50 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B81D29C26C; Tue, 18 Oct 2005 00:21:50 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 6D4E7E1038; Tue, 18 Oct 2005 00:21:50 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
In-Reply-To: <20051017220615.GG12774@schottelius.org>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10194>

Hi,

On Tue, 18 Oct 2005, Nico -telmich- Schottelius wrote:

> I really like to have a snapshot available from my sources in VCS.
> 
> Therefore I wrote the attached script.
>
> git-tar-tree $(git-log | head -n1 | awk '{ print $2 }') 

And why not "git-tar-tree HEAD"?

Ciao,
Dscho
