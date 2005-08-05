From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Use the template mechanism to set up refs/ hierarchy as
 well.
Date: Fri, 5 Aug 2005 02:35:10 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508050234460.25689@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <7v3bprjzzg.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0508042038200.23886@wgmdd8.biozentrum.uni-wuerzburg.de>
 <7vll3hxykj.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0508042215430.24657@wgmdd8.biozentrum.uni-wuerzburg.de>
 <7v7jf1xw90.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0508042311370.24861@wgmdd8.biozentrum.uni-wuerzburg.de>
 <7vmznxwfka.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 05 02:35:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0qBH-0005Dj-AC
	for gcvg-git@gmane.org; Fri, 05 Aug 2005 02:35:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262723AbVHEAfN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Aug 2005 20:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262772AbVHEAfN
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Aug 2005 20:35:13 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:24966 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S262723AbVHEAfL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2005 20:35:11 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 6C15FE239E; Fri,  5 Aug 2005 02:35:10 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 50217ABC81; Fri,  5 Aug 2005 02:35:10 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2466FABC27; Fri,  5 Aug 2005 02:35:10 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0E686E239E; Fri,  5 Aug 2005 02:35:10 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmznxwfka.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 4 Aug 2005, Junio C Hamano wrote:

> Oh, I see.  Then the "templates/Makefile building into
> templates/blt and then installing if you say make install"
> approach I described earlier would hopefully work perfectly well
> for you.  Just like you tack the $src to your $PATH, you can
> define GIT_TEMPLATE_DIRECTORY to $src/templates/blt.  Problem
> solved.

Yes. Call me an idiot.

Yours truly,
Dscho
