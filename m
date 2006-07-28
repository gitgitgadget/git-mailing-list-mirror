From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Allow fetching from multiple repositories at once
Date: Fri, 28 Jul 2006 10:51:56 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607281045430.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060728054341.15864.35862.stgit@machine>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	alp@atoker.com
X-From: git-owner@vger.kernel.org Fri Jul 28 10:52:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6O4f-0006L7-V7
	for gcvg-git@gmane.org; Fri, 28 Jul 2006 10:52:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932598AbWG1Iv6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Jul 2006 04:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932592AbWG1Iv6
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Jul 2006 04:51:58 -0400
Received: from mail.gmx.de ([213.165.64.21]:64168 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932598AbWG1Iv6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Jul 2006 04:51:58 -0400
Received: (qmail invoked by alias); 28 Jul 2006 08:51:56 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp026) with SMTP; 28 Jul 2006 10:51:56 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060728054341.15864.35862.stgit@machine>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24376>

Hi,

On Fri, 28 Jul 2006, Petr Baudis wrote:

> This patch enables fetching multiple repositories at once over the Git
> protocol (and SSH, and locally if git-fetch-pack is your cup of coffee
> there). This is done especially for the xorg people who have tons of
> repositories and dislike pulls much slower than they were used to with CVS.
> I'm eager to hear how this affects the situation.

So the scenario is: one remote repository (probably shared), and multiple 
local repositories, all tracking different branches?

So, why not setup a single local (master) repository, setup all the other 
repos with the local master as alternate, and write a simple script which 
first fetches all branches into the master, and then pulls into the other 
local repos from that master?

The beauty of it is: you can still pull/push directly from the remote 
repo, if you want.

Ciao,
Dscho
