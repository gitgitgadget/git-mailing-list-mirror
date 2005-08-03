From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Users of git-check-files?
Date: Wed, 3 Aug 2005 16:21:13 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508031618500.23728@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0508030109210.21304@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0508021942500.3341@g5.osdl.org> <7vvf2nk0h7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 03 16:21:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0K7U-0003JX-Le
	for gcvg-git@gmane.org; Wed, 03 Aug 2005 16:21:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbVHCOVP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Aug 2005 10:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbVHCOVP
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Aug 2005 10:21:15 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:58812 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S261365AbVHCOVP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2005 10:21:15 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 674B1D802B; Wed,  3 Aug 2005 16:21:14 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4E4379C6DB; Wed,  3 Aug 2005 16:21:14 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3A8AF9C6D4; Wed,  3 Aug 2005 16:21:14 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id ED00BD802B; Wed,  3 Aug 2005 16:21:13 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvf2nk0h7.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 2 Aug 2005, Junio C Hamano wrote:

> Linus Torvalds <torvalds@osdl.org> writes:
>
>> It has no point any more, all the tools check the file status on their
>> own, and yes, the thing should probably be removed.
>
> How about git-rev-tree?  Does anybody care?

I try to write a "git annotate" based on the output of git-whatchanged. 
Since git-whatchanged only shows the commit and its parent, I need to 
figure out what was the last diff that led to the current commit's state. 
This needs git-rev-tree.

Ciao,
Dscho

P.S.: My only unsolved problem is that git-whatchanged sometimes shows
the diffs in the wrong order (clock-skew problem?)
