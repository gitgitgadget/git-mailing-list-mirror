From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: First cut at git port to Cygwin
Date: Thu, 29 Sep 2005 10:46:15 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0509291043580.20717@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <433B3B10.5050407@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 29 10:47:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKu3a-000139-Jm
	for gcvg-git@gmane.org; Thu, 29 Sep 2005 10:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbVI2IqT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 04:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbVI2IqT
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 04:46:19 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:56741 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751184AbVI2IqT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2005 04:46:19 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3065C13EA3A; Thu, 29 Sep 2005 10:46:18 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 172529DB1F; Thu, 29 Sep 2005 10:46:18 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0442291601; Thu, 29 Sep 2005 10:46:18 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 83B9313EA3A; Thu, 29 Sep 2005 10:46:15 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <433B3B10.5050407@zytor.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9477>

Hi,

On Wed, 28 Sep 2005, H. Peter Anvin wrote:

> Another funny which I haven't been able to figure out yet is that 'gitk'
> scrunches all its output up into a few pixels at the top of the window.

See my mail about rootless X11. I went about working around that 
particular Tk bug by specifying the dimensions of the panes explicitely. 
However, I was not especially happy with my workaround, since it did not 
reproduce the layout exactly after a restart. Maybe you can figure it out 
how to do that.

Ciao,
Dscho
