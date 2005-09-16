From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Look at both unpacked and packed objects for short name
 expansion
Date: Fri, 16 Sep 2005 02:49:16 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0509160246280.10401@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0509160120470.3859@wgmdd8.biozentrum.uni-wuerzburg.de>
 <7vfys5votr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 16 02:50:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EG4Po-0004ns-Ej
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 02:49:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030543AbVIPAtS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 20:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965288AbVIPAtR
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 20:49:17 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:25992 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S965054AbVIPAtR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2005 20:49:17 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 56FB813C3E8; Fri, 16 Sep 2005 02:49:16 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 38E0591AA0; Fri, 16 Sep 2005 02:49:16 +0200 (CEST)
Received: from wrzx35.rz.uni-wuerzburg.de (wrzx35.rz.uni-wuerzburg.de [132.187.3.35])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 230648F027; Fri, 16 Sep 2005 02:49:16 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx35.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id ED3D8E27F2; Fri, 16 Sep 2005 02:49:15 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfys5votr.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8656>

Hi,

On Thu, 15 Sep 2005, Junio C Hamano wrote:

> I suspect your patch is an attempt to fix the last one, but I am
> not sure..

Half correct. I was not thinking it through... I had that case where I 
called git-whatchanged with a short sha1 and I kept getting the wrong 
history until I realized that the short sha1 was only unique when looking 
at the unpacked objects only.

Maybe I find time tomorrow to do something about the three problems you 
mentioned.

Ciao,
Dscho
