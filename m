From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach parse_commit_buffer about grafting.
Date: Sat, 30 Jul 2005 12:53:47 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0507301253020.9738@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.58.0507261136280.19309@g5.osdl.org>
 <1122457238.3027.37.camel@baythorne.infradead.org> <Pine.LNX.4.58.0507270819550.3227@g5.osdl.org>
 <1122478870.28128.52.camel@hades.cambridge.redhat.com>
 <Pine.LNX.4.58.0507270846360.3227@g5.osdl.org> <7vslxw4tb1.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat Jul 30 12:54:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dyoys-0004TG-9V
	for gcvg-git@gmane.org; Sat, 30 Jul 2005 12:54:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbVG3Kxt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jul 2005 06:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263030AbVG3Kxt
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jul 2005 06:53:49 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:36503 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S261194AbVG3Kxs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2005 06:53:48 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 9FE01E259C; Sat, 30 Jul 2005 12:53:47 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 89045915CC; Sat, 30 Jul 2005 12:53:47 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7647B9152D; Sat, 30 Jul 2005 12:53:47 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id DB3E1E259C; Sat, 30 Jul 2005 12:53:46 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslxw4tb1.fsf_-_@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

is it possible that you forgot to initialize commit_graft_nr to 0?

Ciao,
Dscho
