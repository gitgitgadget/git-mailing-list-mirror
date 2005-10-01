From: Junio C Hamano <junkio@cox.net>
Subject: Re: local clone much slower than remote clone
Date: Fri, 30 Sep 2005 22:57:46 -0700
Message-ID: <7vslvlbwyt.fsf@assigned-by-dhcp.cox.net>
References: <433DF862.4020500@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 01 07:59:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELaOY-0007zy-Qj
	for gcvg-git@gmane.org; Sat, 01 Oct 2005 07:58:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbVJAF5w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Oct 2005 01:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbVJAF5w
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Oct 2005 01:57:52 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:29140 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750734AbVJAF5v (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Oct 2005 01:57:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051001055747.VADB16347.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 1 Oct 2005 01:57:47 -0400
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <433DF862.4020500@pobox.com> (Jeff Garzik's message of "Fri, 30
	Sep 2005 22:45:54 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9585>

Jeff Garzik <jgarzik@pobox.com> writes:

> time git clone /spare/repo/linux-2.6 scsi-sas-2.6

    $ git clone -l -s -n

would be the fastest.

Yes, -n is an irrelevant cheating ;-).
