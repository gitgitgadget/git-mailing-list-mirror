From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Getting rid of symlinks in .git?
Date: Fri, 11 Nov 2005 15:14:24 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511111511050.7575@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20051110204543.GZ30496@pasky.or.cz> <43746118.30404@hogyros.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, Pavel Roskin <proski@gnu.org>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 11 15:15:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaZfk-0000mX-LW
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 15:14:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbVKKOO3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 09:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbVKKOO3
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 09:14:29 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:28061 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750754AbVKKOO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2005 09:14:29 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E1DA013F302; Fri, 11 Nov 2005 15:14:25 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C40219F250; Fri, 11 Nov 2005 15:14:25 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A6C009F24A; Fri, 11 Nov 2005 15:14:25 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 1B57C13F302; Fri, 11 Nov 2005 15:14:25 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Simon Richter <Simon.Richter@hogyros.de>
In-Reply-To: <43746118.30404@hogyros.de>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11595>

Hi,

On Fri, 11 Nov 2005, Simon Richter wrote:

> As someone who carries around git repositories on VFAT formatted USB 
> sticks, I welcome our symlink-deprived overlords.

Please note that symlinks are much more performant than symrefs. Working a 
lot with switching branches, this matters.

And -- as has been mentioned elsewhere -- it is no longer a problem to 
work on filesystems which don't support symlinks using a platform which 
does.

Hth,
Dscho
