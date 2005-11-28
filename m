From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC 2/2] Automatically transform .git/{branches,remotes} into
 .git/config
Date: Mon, 28 Nov 2005 02:52:08 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511280248020.12343@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0511211455120.13775@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051127125945.GD22159@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 02:53:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgYBj-0007uy-24
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 02:52:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbVK1BwM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Nov 2005 20:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbVK1BwM
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Nov 2005 20:52:12 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:6326 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751218AbVK1BwM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Nov 2005 20:52:12 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C490E13F9F2; Mon, 28 Nov 2005 02:52:08 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A42ECB39A6; Mon, 28 Nov 2005 02:52:08 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7C146B3505; Mon, 28 Nov 2005 02:52:08 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2DFBE13F9F2; Mon, 28 Nov 2005 02:52:08 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051127125945.GD22159@pasky.or.cz>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12846>

Hi,

On Sun, 27 Nov 2005, Petr Baudis wrote:

> I've tried to explain that branches and remotes are different concepts,

Well, no. They aren't. The "branches" concept is a proper special case of 
the "remotes" concept.

But what the heck, I don't care what you eventually use.

I only realized that we -- in the good tradition of UNIX -- have many 
different formats for different configurations: Some configurations are in 
.gitignore, some are in .git/branches/, some in .git/remotes/, some in 
.git/config, and even some in environment variables!

If everybody says that this should stay so, I'll just shut up.

Hth,
Dscho
