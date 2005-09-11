From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-rev-list and git-format-patch script oddness
Date: Sun, 11 Sep 2005 11:20:49 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0509111120020.32244@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <46a038f905091101529e045af@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 11 11:21:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEO1K-0002oV-HF
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 11:21:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbVIKJUx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 05:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964828AbVIKJUx
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 05:20:53 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:5536 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964830AbVIKJUw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2005 05:20:52 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 97B391387BA; Sun, 11 Sep 2005 11:20:49 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 784D758F8E; Sun, 11 Sep 2005 11:20:49 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5ECC558F76; Sun, 11 Sep 2005 11:20:49 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3609E1387BA; Sun, 11 Sep 2005 11:20:49 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f905091101529e045af@mail.gmail.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8280>

Hi,

On Sun, 11 Sep 2005, Martin Langhoff wrote:

> When I run git-format-patch, it insists on outputting merges that have
> already been merged upstream, regardless of the fact that
> git-merge-base knows better.
> 
> Is there a way to get it to skip merged-in patches that git already
> has detected as merged upstream?

I always use something like

	git-format-patch HEAD ^origin

Hth,
Dscho
