From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] cvsimport - streamline temp index file creation and avoid creating empty tmpfiles
Date: Sat, 24 Jun 2006 03:05:57 -0700
Message-ID: <7vslluyika.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0606231811200.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<11511257501323-git-send-email-martin@catalyst.net.nz>
	<Pine.LNX.4.63.0606241145280.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Sat Jun 24 12:06:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fu51f-00010z-7S
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 12:06:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933377AbWFXKF7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 06:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933380AbWFXKF7
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 06:05:59 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:10162 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S933377AbWFXKF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 06:05:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060624100558.OCKM19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 24 Jun 2006 06:05:58 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606241145280.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 24 Jun 2006 11:50:09 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22498>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I would not care too strongly about that. Eventually, I really would like 
> this file to reside in $GIT_DIR, not /tmp, but whatever. That is not my 
> biggest concern right now. That I cannot update since June 18th, however, 
> is.

Would reverting 8f732649 in the meantime be an option for you?
