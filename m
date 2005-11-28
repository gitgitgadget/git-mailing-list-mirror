From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC 2/2] Automatically transform .git/{branches,remotes} into
 .git/config
Date: Mon, 28 Nov 2005 17:29:58 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511281728110.11362@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0511211455120.13775@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051127125945.GD22159@pasky.or.cz> <Pine.LNX.4.63.0511280248020.12343@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vfyph1ebq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 17:34:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgltH-0005Tq-Fr
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 17:30:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbVK1QaD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 11:30:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbVK1QaB
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 11:30:01 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:924 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751284AbVK1QaA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2005 11:30:00 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 931C913FEBD; Mon, 28 Nov 2005 17:29:59 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 79C1C9F473; Mon, 28 Nov 2005 17:29:59 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 6807B9DB02; Mon, 28 Nov 2005 17:29:59 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id CB08313FEC1; Mon, 28 Nov 2005 17:29:58 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfyph1ebq.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12893>

Hi,

On Sun, 27 Nov 2005, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > I only realized that we -- in the good tradition of UNIX -- have many 
> > different formats for different configurations: Some configurations are in 
> > .gitignore, some are in .git/branches/, some in .git/remotes/, some in 
> > .git/config, and even some in environment variables!
> 
> Can you live with something like this?
> 
>  - we will add new ones to config, now we have it;
> 
>  - we will not deprecate existing ones outside of config for some time;
> 
>  - we will not duplicate/move existing ones into config at least
>    for now to keep our work less complicated;
> 
>  - we would revisit deprecating things outside config file
>    sometime later after 1.0 stabilizes, and that's when we will
>    talk about moving these things into config.

I can very well live with this!

As a first step, we could support getting the remote information from 
.git/config after testing .git/branches/ and .git/remotes/?

Ciao,
Dscho
