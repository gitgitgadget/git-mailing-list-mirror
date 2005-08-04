From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Use the template mechanism to set up refs/ hierarchy as
 well.
Date: Thu, 4 Aug 2005 20:41:09 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508042038200.23886@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <7v3bprjzzg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 20:44:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0kgP-0004YX-Tk
	for gcvg-git@gmane.org; Thu, 04 Aug 2005 20:43:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262534AbVHDSmm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Aug 2005 14:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262596AbVHDSmm
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Aug 2005 14:42:42 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:5077 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S262534AbVHDSlK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2005 14:41:10 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0C917E23DC; Thu,  4 Aug 2005 20:41:10 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E67DB9C6F3; Thu,  4 Aug 2005 20:41:09 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D469593E22; Thu,  4 Aug 2005 20:41:09 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id BADB5E23DC; Thu,  4 Aug 2005 20:41:09 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3bprjzzg.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 2 Aug 2005, Junio C Hamano wrote:

> This may be controversial from the robustness standpoint, so I
> am placing it in the proposed update queue first.  Discussions
> on the list very welcomed.

I'd vote against it: As of now, I can perfectly do

export PATH=$PATH:/whereever/my/git/is
git-init-db

which would not work with this patch. I don't mind the templating 
mechanism per se, though. It should make life easier for new bees.
Let's just make sure git-init-db is usable without installing 
anything.

Ciao,
Dscho
