From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC/PATCH] pager: do not fork a pager if environment variable PAGER is set to NONE
Date: Sat, 15 Apr 2006 13:50:33 -0700
Message-ID: <7vwtdqef6u.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0604151516150.6563@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 15 22:50:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUrj7-0006JE-8b
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 22:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbWDOUug (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Apr 2006 16:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbWDOUug
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Apr 2006 16:50:36 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:8675 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751457AbWDOUuf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Apr 2006 16:50:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060415205034.HHVB8660.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 15 Apr 2006 16:50:34 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0604151516150.6563@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 15 Apr 2006 15:16:36 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18762>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This helps debugging tremendously.
>
> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

I like what this wants to do.  I am not so sure PAGER=NONE is a
good convention, however.
