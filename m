From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Slight enhancement of GIT wrapper
Date: Thu, 14 Apr 2005 01:07:28 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0504140106470.15139@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <200504132249.16848.pisa@cmp.felk.cvut.cz> <20050413225509.GL25711@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 01:04:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DLquG-0002wI-Vv
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 01:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbVDMXHf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Apr 2005 19:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbVDMXHf
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Apr 2005 19:07:35 -0400
Received: from wrzx35.rz.uni-wuerzburg.de ([132.187.3.35]:18860 "EHLO
	wrzx35.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S261214AbVDMXHa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2005 19:07:30 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx35.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 32674DD348; Thu, 14 Apr 2005 01:07:29 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 1B10099C60; Thu, 14 Apr 2005 01:07:29 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E300DC975; Thu, 14 Apr 2005 01:07:28 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id BA891D44C1; Thu, 14 Apr 2005 01:07:28 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050413225509.GL25711@pasky.ji.cz>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 14 Apr 2005, Petr Baudis wrote:

> Dear diary, on Wed, Apr 13, 2005 at 10:49:16PM CEST, I got a letter
> where Pavel Pisa <pisa@cmp.felk.cvut.cz> told me that...
>
> > +
> > +if [ -h "$0" ]; then
> > +  GIT_DIR=`ls -l "$0" | sed 's/^.*-> *\(.*\) *$/\1/'`
>
> Well, I don't like this much, but I'm not sure how to do better.

How about

	GIT_DIR=$(ls -L "$0")

Ciao,
Dscho
