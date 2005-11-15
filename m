From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/3] Support setting SymrefsOnly=true from scripts
Date: Tue, 15 Nov 2005 15:07:44 -0800
Message-ID: <7vfypxh5mn.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0511152233430.2152@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 16 00:08:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec9u9-00051p-8j
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 00:07:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965072AbVKOXHr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 18:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965073AbVKOXHq
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 18:07:46 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:21906 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S965072AbVKOXHq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 18:07:46 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051115230632.ULCT20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 15 Nov 2005 18:06:32 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0511152233430.2152@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 15 Nov 2005 22:36:05 +0100
	(CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11960>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> 	- set SymrefsOnly=true right from the start with
> 		git-init-db --dont-use-symrefs

I am almost tempted to say that we should be doing --template=
option to git-init-db for something like this, and make the
template instantiation first thing before even reading the
config file.

The rest might be useful to better support end-users, but I am
not sure.  Is it that much hassle to them to edit an .ini file?
