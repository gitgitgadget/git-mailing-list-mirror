From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Move couple of ifdefs after "include config.mk"
Date: Thu, 1 Dec 2005 09:08:27 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512010906400.22709@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20051201012333.44bd81f2.tihirvon@gmail.com>
 <Pine.LNX.4.63.0512010144050.11941@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051201033201.02b47071.tihirvon@gmail.com> <7vhd9tmw1g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Timo Hirvonen <tihirvon@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 01 09:09:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhjUc-0000Zk-B8
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 09:08:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbVLAII3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 03:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbVLAII3
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 03:08:29 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:60303 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750758AbVLAII2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2005 03:08:28 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7888113FA02; Thu,  1 Dec 2005 09:08:27 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 61531B53A4; Thu,  1 Dec 2005 09:08:27 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 441DAB5378; Thu,  1 Dec 2005 09:08:27 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0622B13FA02; Thu,  1 Dec 2005 09:08:27 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhd9tmw1g.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13040>

Hi,

On Wed, 30 Nov 2005, Junio C Hamano wrote:

> Honestly speaking, I'd personally prefer to just get rid of "-include 
> config.mak" from Makefile.

But it is only one line, heck only 20 bytes!

And you can still use your "./Make" method, and it is not widely 
advertised, and you can override settings from the platform-dependent 
code, and I feel much better at having my littly config.mak, my precious!

Ciao,
Dscho
