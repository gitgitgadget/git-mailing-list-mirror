From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git merge questions
Date: Sat, 17 Dec 2005 00:58:50 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512170056380.11000@wbgn013.biozentrum.uni-wuerzburg.de>
References: <68948ca0512161205x3d5921bfm3bfcaa64f988eb99@mail.gmail.com>
 <7vacf0g4ga.fsf@assigned-by-dhcp.cox.net> <7vy82keo8p.fsf@assigned-by-dhcp.cox.net>
 <68948ca0512161335k50a3ec64lee6f73ea4f8ae23f@mail.gmail.com>
 <7voe3gd6ul.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Don Zickus <dzickus@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 17 01:00:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EnPTY-0006Uo-3f
	for gcvg-git@gmane.org; Sat, 17 Dec 2005 00:59:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbVLPX6x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Dec 2005 18:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbVLPX6x
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Dec 2005 18:58:53 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:18304 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751342AbVLPX6w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2005 18:58:52 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 49C6B13FAF2; Sat, 17 Dec 2005 00:58:51 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 301459DF6B; Sat, 17 Dec 2005 00:58:51 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 1E2FD99561; Sat, 17 Dec 2005 00:58:51 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id BBD5513FB51; Sat, 17 Dec 2005 00:58:50 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7voe3gd6ul.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13763>

Hi,

just a thought: maybe in this case -- git fails to recognize a rename -- 
Pasky's idea would have some merit. You could then provide git with some 
extra information a la .git/info/grafts: "Even if you, git, do not believe 
it: this file *was* renamed from blah to blop".

Ciao,
Dscho
