From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Get rid of .git/branches/ and .git/remotes/?
Date: Wed, 23 Nov 2005 16:08:40 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511231553390.8191@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0511201748440.14258@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0511200935081.13959@g5.osdl.org> <200511210026.30280.Josef.Weidendorfer@gmx.de>
 <200511221831.03954.Josef.Weidendorfer@gmx.de>
 <Pine.LNX.4.63.0511221854120.27872@wbgn013.biozentrum.uni-wuerzburg.de>
 <438371E8.2030701@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 16:09:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EewEr-0003Fu-HA
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 16:08:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbVKWPIq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 10:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750903AbVKWPIq
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 10:08:46 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:32416 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750865AbVKWPIp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2005 10:08:45 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D7BA913FC0D; Wed, 23 Nov 2005 16:08:44 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id BEDD09F3D8; Wed, 23 Nov 2005 16:08:44 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id AAB1D9F3D5; Wed, 23 Nov 2005 16:08:44 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8625813FC0D; Wed, 23 Nov 2005 16:08:40 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <438371E8.2030701@op5.se>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12633>

Hi,

On Tue, 22 Nov 2005, Andreas Ericsson wrote:

> Johannes Schindelin wrote:
> > 
> > 	git-config-set --get remote.origin.url
> > 
> 
> So... "git-config-set" is used for both getting and setting? Why not just
> "git-config --set" and "git-config --get" to make things a bit less confusing?

I tried to do this more like a proof of a concept (Yeah, famous last 
words...) and tried to be not so intrusive. There is already a config.c, 
and to keep with the naming, this would have to move to config-lib.c to 
make space for config.c which really is the source for git-config$(X).

Should we rename config.c to config-lib.c, and config-set.c to config.c? 
Personally, I think it too intrusive, but what the heck.

Ciao,
Dscho
