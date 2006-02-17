From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/5] Fixes for ancient versions of GNU make
Date: Sat, 18 Feb 2006 00:29:37 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602180024390.32416@wbgn013.biozentrum.uni-wuerzburg.de>
References: <11491.1140196527@lotus.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 18 00:30:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAF2s-0008HH-P2
	for gcvg-git@gmane.org; Sat, 18 Feb 2006 00:29:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbWBQX3j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Feb 2006 18:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbWBQX3j
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Feb 2006 18:29:39 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:40669 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750803AbWBQX3j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2006 18:29:39 -0500
Received: from virusscan.mail (amavis2.rz.uni-wuerzburg.de [132.187.3.47])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0422214138E; Sat, 18 Feb 2006 00:29:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id EBDAD1237;
	Sat, 18 Feb 2006 00:29:37 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B69E914138E; Sat, 18 Feb 2006 00:29:37 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jason Riedy <ejr@EECS.Berkeley.EDU>
In-Reply-To: <11491.1140196527@lotus.CS.Berkeley.EDU>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16375>

Hi,

On Fri, 17 Feb 2006, Jason Riedy wrote:

> And Johannes Schindelin writes:
>  - 
>  - Some version of GNU make do not understand $(call), and have 
>  - problems to interpret rules like this:
> 
> Is building a newer version of GNU make impossible on Irix?

No. But it is annoying to be forced to upgrade every second package. If 
there'd be some real benefit, then okay, I'd do it. But there is really no 
point in not supporting the old version.

Besides, in some environments you are just not allowed to go wild 
installing programs. And in some environments, you just don't have the 
quota.

Hth,
Dscho
