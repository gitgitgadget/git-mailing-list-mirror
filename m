From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] If NO_MMAP is defined, fake mmap() and munmap()
Date: Fri, 07 Oct 2005 16:44:22 -0700
Message-ID: <7vwtkoyjs9.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0510080050550.20922@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 08 01:46:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EO1t7-0007Qv-OC
	for gcvg-git@gmane.org; Sat, 08 Oct 2005 01:44:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964879AbVJGXo1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Oct 2005 19:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964880AbVJGXo0
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Oct 2005 19:44:26 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:11398 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S964879AbVJGXo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2005 19:44:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051007234408.OPEQ29747.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 7 Oct 2005 19:44:08 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0510080050550.20922@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 8 Oct 2005 00:55:40 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9828>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Since some platforms do not support mmap() at all, and others do only just 
> so, this patch introduces the option to fake mmap() and munmap() by 
> malloc()ing and read()ing explicitely.

I guess I can just drop Alex Riesen patch and any other recent
patches that try to work around mmap().  Happy!

 
