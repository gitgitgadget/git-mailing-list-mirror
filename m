From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/8] Clean up work-tree handling
Date: Sun, 29 Jul 2007 12:54:51 -0700
Message-ID: <7vodhvm1dg.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707271851370.14781@racer.site>
	<Pine.LNX.4.64.0707271956420.14781@racer.site>
	<7vk5sly3h9.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707280115370.14781@racer.site>
	<7vejitwe8m.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707280152120.14781@racer.site>
	<7vlkd1umwf.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707291645580.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, matled@gmx.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 29 21:54:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFEqu-00072e-Bz
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 21:54:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762775AbXG2Tyx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 15:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765281AbXG2Tyx
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 15:54:53 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:55029 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762397AbXG2Tyw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 15:54:52 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070729195451.PMOF23215.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sun, 29 Jul 2007 15:54:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id VXur1X00A1kojtg0000000; Sun, 29 Jul 2007 15:54:51 -0400
In-Reply-To: <Pine.LNX.4.64.0707291645580.14781@racer.site> (Johannes
	Schindelin's message of "Sun, 29 Jul 2007 16:53:16 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54134>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I still have a problem with what should happen if both "core.bare == true" 
> and "core.worktree = /some/where/over/the/rainbow".  Should it be bare, or 
> should it have a working tree?

They sound contradicting with each other to me.  Isn't that a
clear configuration error?
