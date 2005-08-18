From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC] Allow file removal when "git commit --all" is used.
Date: Thu, 18 Aug 2005 12:49:46 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508181248110.30218@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <7v64u3k74m.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 18 12:51:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5hy3-0005so-R3
	for gcvg-git@gmane.org; Thu, 18 Aug 2005 12:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbVHRKtt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Aug 2005 06:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbVHRKtt
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Aug 2005 06:49:49 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:50129 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932176AbVHRKts (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2005 06:49:48 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 68715136423; Thu, 18 Aug 2005 12:49:47 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4AF70B0963; Thu, 18 Aug 2005 12:49:47 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 24709B0945; Thu, 18 Aug 2005 12:49:47 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A60991364BE; Thu, 18 Aug 2005 12:49:46 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64u3k74m.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 18 Aug 2005, Junio C Hamano wrote:

> After you deleted files from your working tree, automatic
> git-update-cache used when the "--all" flag is given to "git
> commit" barfs because it lacks the --remove flag.
> 
> It can be argued that this is a feature; people should be
> careful and something with a grave consequence like removing
> files should be done manually, in which case the current
> behaviour may be OK.
> 
> The patch is for people who thinks the user who uses the "--all"
> flag deserves the danger that comes with the convenience.
> 
> Comments?

This is a sane default behaviour. Maybe introduce yet another flag 
"--no-remove", which says that removes should not be performed? But then, 
"--all" is mostly used by lazy people, who probably expect the removes to 
take place.

Ciao,
Dscho
