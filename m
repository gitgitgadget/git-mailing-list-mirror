From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Prevent git-upload-pack segfault if object cannot be found
Date: Fri, 17 Feb 2006 22:50:17 -0800
Message-ID: <7vd5hlupna.fsf@assigned-by-dhcp.cox.net>
References: <87hd6x34lf.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 18 07:50:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FALvC-0007BK-2H
	for gcvg-git@gmane.org; Sat, 18 Feb 2006 07:50:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbWBRGuU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Feb 2006 01:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750920AbWBRGuT
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Feb 2006 01:50:19 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:38383 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750905AbWBRGuS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Feb 2006 01:50:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060218065023.APU25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 18 Feb 2006 01:50:23 -0500
To: Carl Worth <cworth@cworth.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16391>

Thanks, this is the last remaining call that did not check its
return value from opendir().

I queued this one and three clone things from you.  They will
appear in "next" first, but also be in 1.2.2.
