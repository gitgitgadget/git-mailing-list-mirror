From: Junio C Hamano <junkio@cox.net>
Subject: Re: Fix uninteresting tags in new revision parsing
Date: Tue, 18 Apr 2006 21:36:47 -0700
Message-ID: <7vu08qb2qo.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0604182027460.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 19 06:37:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FW4R4-0002uj-TL
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 06:37:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWDSEgv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Apr 2006 00:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWDSEgv
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Apr 2006 00:36:51 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:36234 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750809AbWDSEgu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Apr 2006 00:36:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060419043649.ORJE18351.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 19 Apr 2006 00:36:49 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18907>

Linus Torvalds <torvalds@osdl.org> writes:

> When I unified the revision argument parsing, I introduced a simple bug 
> wrt tags that had been marked uninteresting. When it was preparing for the 
> revision walk, it would mark all the parent commits of an uninteresting 
> tag correctly uninteresting, but it would forget about the commit itself.

Thanks.  Can't believe I missed it...
