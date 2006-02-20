From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-rev-list --help anywhere
Date: Sun, 19 Feb 2006 21:52:07 -0800
Message-ID: <7vu0auefw8.fsf@assigned-by-dhcp.cox.net>
References: <20060219112627.18989.qmail@science.horizon.com>
	<20060219183930.GB10010@steel.home>
	<Pine.LNX.4.63.0602192023270.11855@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, linux@horizon.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 20 06:52:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FB3y3-00033F-93
	for gcvg-git@gmane.org; Mon, 20 Feb 2006 06:52:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932652AbWBTFwL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Feb 2006 00:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932654AbWBTFwL
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Feb 2006 00:52:11 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:10423 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932652AbWBTFwK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2006 00:52:10 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060220054848.KBHZ17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 20 Feb 2006 00:48:48 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0602192023270.11855@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sun, 19 Feb 2006 20:25:02 +0100
	(CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16466>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> can someone please enlighten me why you need to see the usage, when you 
> cannot execute the command anyway?

I think Pasky gave rev-list just as an example, as I am sure
there are other lowlevel core tools, that share this same
unfriendliness.  Primarily, these tools are meant for scripting,
and not for end-user interactive use.  For this reason, it is
not high on my priority list to add --help to the lowlevel core
tools, although it would be nicer to have.
