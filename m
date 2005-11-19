From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git --exec-path conversion
Date: Sat, 19 Nov 2005 12:20:26 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511191218370.27986@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20051119111444.82122.qmail@web26309.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 19 12:21:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdQlj-0007ch-J8
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 12:20:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbVKSLU2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Nov 2005 06:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbVKSLU2
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Nov 2005 06:20:28 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:20152 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751064AbVKSLU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Nov 2005 06:20:28 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2795613FECC; Sat, 19 Nov 2005 12:20:27 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0E4389F36D; Sat, 19 Nov 2005 12:20:27 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id EEE9391B78; Sat, 19 Nov 2005 12:20:26 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8C03613FECC; Sat, 19 Nov 2005 12:20:26 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Marco Costalba <mcostalba@yahoo.it>
In-Reply-To: <20051119111444.82122.qmail@web26309.mail.ukl.yahoo.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12329>

Hi,

On Sat, 19 Nov 2005, Marco Costalba wrote:

>     if (cmd.left(3) == "git") 
>          cmd = cmd.prepend(exec-path);

Little nit: Test for "git-", because "git" and "gitk" will stay in the 
PATH.

Ciao,
Dscho
