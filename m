From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Include Makefile.localdef in Makefile, if it exists.
Date: Sat, 3 Dec 2005 11:45:31 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512031144030.20595@wbgn013.biozentrum.uni-wuerzburg.de>
References: <3061.1133591717@lotus.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 03 11:45:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EiUtc-0005El-G6
	for gcvg-git@gmane.org; Sat, 03 Dec 2005 11:45:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbVLCKpd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Dec 2005 05:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbVLCKpd
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Dec 2005 05:45:33 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:3505 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750700AbVLCKpc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Dec 2005 05:45:32 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E0C3813F7DC; Sat,  3 Dec 2005 11:45:31 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C581E9F50E; Sat,  3 Dec 2005 11:45:31 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id ADA459F41D; Sat,  3 Dec 2005 11:45:31 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8608413F7DC; Sat,  3 Dec 2005 11:45:31 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jason Riedy <ejr@EECS.Berkeley.EDU>
In-Reply-To: <3061.1133591717@lotus.CS.Berkeley.EDU>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13154>

Hi,

On Fri, 2 Dec 2005, Jason Riedy wrote:

> And Johannes Schindelin writes:
>  - I wonder why you do not just override them in config.mak, which was 
>  - introduced just for that purpose...
> 
> 'Cause I'm a git and didn't notice it, thanks.

Nopraw.

> The prefix stuff probably ought to be moved below the -include 
> config.mak so someone need only change $(prefix) and not the rest.  I 
> might send along such a patch, along with a note about config.mak in 
> INSTALL...

Actually, it is a feature that you can override prefix and template_dir 
independently.

Hth,
Dscho
